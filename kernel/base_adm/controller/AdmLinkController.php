<?php

abstract class AdmLinkController extends Controller{

	public function indexAction(){

		$this->load_manager('link','admin');
		
		$this->registry->smarty->assign(array(
			'links'		=>	$this->manager->link->getAll(),
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'link' . DS . 'index.tpl');
	}

	public function addAction(){
		
		if( $this->app->HTTPRequest->postExists('link') ):
			$this->load_model('link','admin');			
			
			$link = new link( $this->app->HTTPRequest->postData('link') );
			
			$link->id = $link->save();
					
			# Traitement aperçu
			$Result = $this->upload( $link->id, 'image', true);

			if( $Result !== false):
				$link->image = $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/link/' . $link->id . '/' . $Result;
			else:
				$link->image = '';
			endif;

			$link->save();
			
			return $this->redirect( $this->app->Helper->getLinkAdm('link'), 3, 'Lien enregistré');
		endif;
		
		print_form:

		$this->load_manager('categorie');
		$this->manager->categorie->setTable('link');
		$this->getFormValidatorJs();
		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');

		$this->app->smarty->assign(array(
			'categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	'Liens :: Nouveau',
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'link' . DS . 'add.tpl');		
	}

	 public function editAction($id){
		
		$this->load_model('link','admin');		
		
		if( $this->app->HTTPRequest->postExists('link') ){	

			# Recuperation du lien actuel	
			$Actuel = new link();
			$Actuel->get($id);	
			
			# Lien modifie
			$link = new link( $this->app->HTTPRequest->postData('link') );
						
			# Traitement aperçu
			$Result = $this->upload( $link->id, 'image', true);
			if( $Result !== false):
				$link->image = $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/link/' . $link->id . '/' . $Result;
			else:
				$link->image = $Actuel->image;
			endif;
				
			$link->save();
			
			return $this->redirect( $this->app->Helper->getLinkAdm('link'), 3, 'Lien modifié');
		}
		
		print_form:
		$link = new link();
		$link->get($id);

		$this->load_manager('categorie');
		$this->manager->categorie->setTable('link');
		$this->getFormValidatorJs();
		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');

		$this->registry->smarty->assign(array(
			'categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	$this->lang['Administration'],
			'link'			=>	$link,
		));
		
		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'link' . DS . 'edit.tpl');
	}

	public function deleteAction($id){
		$this->load_model('link','admin');

		$link = new link();
		$link->delete($id);

		# Suppression fichier et dossier
		$Files = getFilesInDir( ROOT_PATH . 'web' . DS . 'upload' . DS . 'link' . DS . $id . DS );
		foreach( $Files as $k => $v):
			@unlink(ROOT_PATH . 'web' . DS . 'upload' . DS . 'link' . DS . $id . DS . $v);
		endforeach;
		@rmdir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'link' . DS . $id . DS);

		return $this->redirect($this->app->Helper->getLinkAdm('link'), 3, 'Lien supprimé');
	}

	private function upload($link_id, $file, $image = false){

		$Dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'link' . DS . $link_id;
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php';
		
		if( !is_dir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'link' . DS) ):
			@mkdir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'link' . DS);
		endif;

		if( !is_dir($Dir) ):
			@mkdir($Dir);
		endif;
		
		$Fichier = new Upload($_FILES[''.$file.'']);

        if($Fichier->uploaded):
			$Fichier->allowed = 'image/*';
            $Fichier->file_overwrite = true;
            $Fichier->file_new_name_body  = microtime(true);
			$Fichier->image_resize          = true;
			$Fichier->image_ratio_y         = true;
			$Fichier->image_x               = 400;
            $Fichier->process($Dir);

            if( $Fichier->processed ):
            	return $Fichier->file_dst_name;
            else:
            	return false;
            endif;
		endif;

		return false;
	}

}