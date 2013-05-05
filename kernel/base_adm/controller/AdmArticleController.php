<?php

abstract class AdmArticleController extends Controller{

	public function indexAction(){
		
		$this->load_manager('article', 'admin');
		
		$Articles = $this->manager->article->getAll();
		
		$this->app->smarty->assign(array(
			'c_titre'	=>	$this->lang['Administration'] . '::' . $this->lang['Article'],
			'Articles'	=>	$Articles,
		));
		
		if( is_file( VIEW_PATH . 'article' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'article' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'article' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function addAction(){
		
		if( $this->app->HTTPRequest->postExists('article') ):
			
			$this->load_model('article','admin');
			
			$Article = new article($this->app->HTTPRequest->postData('article'));
			
			if( ($Result = $Article->isValid()) !== true){
				$this->app->smarty->assign('Error', $Result);
				goto printform;
			} 
			
			$Article->setAuthor($_SESSION['utilisateur']['id']);
			$Article->setCreatOn(time());
			$Article->setEditBy($_SESSION['utilisateur']['id']);
			$Article->setEditOn(time());
			
			$Article->id = $Article->save();

			$Result = $this->upload( $Article->id, 'image', true );
			if( $Result !== false):
				$Article->image = $Result;
			endif;


			$Result = $this->upload( $Article->id, 'fichier', false);
			if( $Result !== false ):
				$Article->fichier = $Result;
			endif;

			$Article->save();

			# Ajout du liens	
			addLinkAvailable($Article->title, 'article/read/' . $Article->id);
			
			return $this->redirect( $this->app->Helper->getLinkAdm('article/index'), 3, $this->lang['Article_ajoute']);
		endif;
		
		printform:

		$this->getFormValidatorJs();

		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');
		
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('article');
		
		$this->registry->smarty->assign(array(
			'Categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	$this->lang['Administration'],
		));
		
		if( is_file( VIEW_PATH . 'article' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'article' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'article' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);		
	}
	
	public function editAction($article_id){
		
		$this->load_model('article', 'admin');
		
		if( $this->app->HTTPRequest->postExists('article') ):
				
			$Article = new article($this->app->HTTPRequest->postData('article'));
			
			if( ($Result = $Article->isValid()) !== true):
				$this->app->smarty->assign('Error', $Result);
				goto printform;
			endif;
			
			$Article->setEditBy($_SESSION['utilisateur']['id']);
			$Article->setEditOn(time());

			$Result = $this->upload( $Article->id, 'image', true );
			if( $Result !== false):
				$Article->image = $Result;
			endif;

			$Result = $this->upload( $Article->id, 'fichier', false);
			if( $Result !== false ):
				$Article->fichier = $Result;
			endif;
			
			$Article->save();
		
			return $this->redirect( $this->app->Helper->getLinkAdm('article/index'), 3, $this->lang['Article_modifie']);
		endif;
		
		printform:
		$Article = new article();
		$Article->get($article_id);

		$this->getFormValidatorJs();

		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');
		
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('article');
		
		$this->app->smarty->assign(array(
			'Article'		=>	$Article,
			'Categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	$this->lang['Administration'],
		));
		
		if( is_file( VIEW_PATH . 'article' . DS . 'edit.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'article' . DS . 'edit.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'article' . DS . 'edit.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function deleteAction($article_id){
		
		$this->app->db->delete(PREFIX . 'article', $article_id);
				
		deleteLinkAvailable('article/read/' . $article_id);
		
		return $this->redirect( $this->app->Helper->getLinkAdm('article/index'), 3, $this->lang['Article_supprime']);		
	}

	private function upload($article_id, $file, $image = false){

		$Dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'article' . DS . $article_id;
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php';
		
		if( !is_dir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'article' . DS) ):
			@mkdir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'article' . DS);
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