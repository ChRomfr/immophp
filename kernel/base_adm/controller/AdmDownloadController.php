<?php

abstract class AdmDownloadController extends Controller{

	public function indexAction(){

		$this->load_manager('download','admin');
		
		$this->registry->smarty->assign(array(
			'downloads'		=>	$this->manager->download->getAll(),
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'download' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'download' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'download' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}

	public function addAction(){
		
		if( $this->registry->HTTPRequest->postExists('download') ):
			$this->load_model('download','admin');			
			
			$download = new download( $this->app->HTTPRequest->postData('download') );
			
			if( $download->isValid() !== true ):
				goto print_form;
			endif;
			
			$download->prepareForSave();
			$download->id = $download->save();

			# Traitement des fichiers
			if( empty($download->url) ):
				$Result = $this->upload( $download->id, 'fichier');
				if( $Result !== false):
					$download->url = $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/download/' . $download->id . '/' . $Result;
				else:
					$download->url = '';
				endif;
			endif;
						
			# Traitement aperçu
			$Result = $this->upload( $download->id, 'image', true);
			if( $Result !== false):
				$download->apercu = $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/download/' . $download->id . '/' . $Result;
			else:
				$download->apercu = '';
			endif;

			$download->save();
			
			return $this->redirect( $this->app->Helper->getLinkAdm('download'), 3, $this->lang['Telechargement_ajoute']);
		endif;
		
		print_form:

		$this->load_manager('categorie');
		$this->manager->categorie->setTable('download');
		$this->getFormValidatorJs();
		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');

		$this->app->smarty->assign(array(
			'categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	$this->lang['Administration'],
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'download' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'download' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'download' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);		
	}

	 public function editAction($id){
		
		$this->load_model('download','admin');		
		
		if( $this->registry->HTTPRequest->postExists('download') ){		
			$Actuel = new download();
			$Actuel->get($id);	
			
			$download = new download( $this->registry->HTTPRequest->postData('download') );
			
			if( $download->isValid() !== true ):
				goto print_form;
			endif;
				
			# Traitement des fichiers
			if( empty($download->url) ):
				$Result = $this->upload( $download->id, 'fichier');
				if( $Result !== false):
					$download->url = $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/download/' . $download->id . '/' . $Result;
				else:
					$download->url = $Actuel->url;
				endif;
			endif;
						
			# Traitement aperçu
			$Result = $this->upload( $download->id, 'image', true);
			if( $Result !== false):
				$download->apercu = $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/download/' . $download->id . '/' . $Result;
			else:
				$download->apercu = $Actuel->apercu;
			endif;
				
			$download->save();
			
			return $this->redirect($this->app->Helper->getLinkAdm('download'), 3, $this->lang['Telechargement_modifie']);
		}
		
		print_form:
		$Download = new download();
		$Download->get($id);

		$this->load_manager('categorie');
		$this->manager->categorie->setTable('download');
		$this->getFormValidatorJs();
		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');

		$this->registry->smarty->assign(array(
			'categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	$this->lang['Administration'],
			'download'		=>	$Download,
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'download' . DS . 'edit.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'download' . DS . 'edit.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'download' . DS . 'edit.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);		
	}

	public function deleteAction($id){
		$this->load_model('download','admin');

		$Download = new Download();
		$Download->delete($id);

		# Suppression fichier et dossier
		$Files = getFilesInDir( ROOT_PATH . 'web' . DS . 'upload' . DS . 'download' . DS . $id . DS );
		foreach( $Files as $k => $v):
			@unlink(ROOT_PATH . 'web' . DS . 'upload' . DS . 'download' . DS . $id . DS . $v);
		endforeach;
		@rmdir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'download' . DS . $id . DS);

		return $this->redirect($this->app->Helper->getLinkAdm('download'), 3, $this->lang['Telechargement_supprime']);
	}

	private function upload($download_id, $file, $image = false){

		$Dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'download' . DS . $download_id;
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php';
		
		if( !is_dir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'download' . DS) ):
			@mkdir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'download' . DS);
		endif;

		if( !is_dir($Dir) ):
			@mkdir($Dir);
		endif;
		
		$Fichier = new Upload($_FILES[''.$file.'']);

		if( $image == true):
	        if($Fichier->uploaded):
				$Fichier->allowed = 'image/*';
	            $Fichier->file_overwrite = true;
	            $Fichier->file_new_name_body  = microtime(true);
				$Fichier->image_resize          = true;
				$Fichier->image_ratio_y         = true;
				$Fichier->image_x               = 1024;
	            $Fichier->process($Dir);

	            if( $Fichier->processed ):
	            	return $Fichier->file_dst_name;
	            else:
	            	return false;
	            endif;
			endif;
			return false;
		else:
			if($Fichier->uploaded):
	            $Fichier->file_overwrite = true;
	            $Fichier->file_new_name_body  = microtime(true);
	            $Fichier->process($Dir);

	            if( $Fichier->processed ):
	            	return $Fichier->file_dst_name;
	            else:
	            	return false;
	            endif;
			endif;
			return false;
		endif;
	}

}