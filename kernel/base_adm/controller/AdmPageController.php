<?php

abstract class AdmPageController extends Controller{
	
	/**
	 * Affiche la liste des pages
	 * @return [type] [description]
	 */
	public function indexAction(){

		# On charge le manager
		$this->load_manager('page','admin');

		# On recupere et envoie les pages a smarty
		$this->app->smarty->assign('pages', $this->manager->page->getAll());

		# Generation du template et envoie a pour affichage
		if( is_file( VIEW_PATH . 'page' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'page' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'page' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);

	}
	
	/**
	 * Affiche et traite le formulaire d ajout
	 * 
	 */
	public function addAction(){
		
		if( $this->app->HTTPRequest->postExists('page') ):
			
			$this->load_model('page','admin');
			$page = new page($this->app->HTTPRequest->postData('page'));
			
			if( $page->isValid() !== true) goto printform;
				
			$this->load_manager('page','admin');
			
			$page->id = $this->manager->page->save($page);
			
			addLinkAvailable($page->titre, 'page/index/' . $page->id);
			
			return $this->redirect($this->app->Helper->getLinkAdm('page/index'), 3, $this->lang['Page_ajoutee']);
			
		endif;
		
		printform:
		
		$this->getFormValidatorJs();

		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');

		if( is_file( VIEW_PATH . 'page' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'page' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'page' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function editAction($id){
		
		$this->load_model('page','admin');
		$this->load_manager('page','admin');
		
		if( $this->app->HTTPRequest->postExists('page') ):		
			
			$page = new page($this->app->HTTPRequest->postData('page'));
			
			if( $page->isValid() !== true) goto printform;			
			
			$this->manager->page->save($page);
						
			return $this->redirect($this->app->Helper->getLinkAdm('page/index'), 3, $this->lang['Page_modifiee']);			
		endif;
		
		printform:
		$this->getFormValidatorJs();

		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/sets/default/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/sets/default/set.js','js');;

		$this->app->smarty->assign('page', $this->manager->page->getById($id));

		if( is_file( VIEW_PATH . 'page' . DS . 'edit.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'page' . DS . 'edit.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'page' . DS . 'edit.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function deleteAction($id){
		
		$this->app->db->delete(PREFIX . 'page', $id);
		
		deleteLinkAvailable('page/index/' . $id);
		
		return $this->redirect($this->app->Helper->getLinkAdm('page/index'), 3, $this->lang['Page_supprimee']);
	}
	
}

