<?php

abstract class AdmNewsController extends Controller{

	/**
	 * [indexAction Affiche la liste des news]
	 * @return [string] [Code HTML de la page]
	 */
	public function indexAction(){
		
		$this->load_manager('news', 'admin');
		$news_in_db = $this->manager->news->count();
		$news = $this->manager->news->getAll(30, getOffset(30));
		
		
		$this->app->smarty->assign(array(
			'news'			=>	$news,
			'pagination'	=>	$news_in_db > 30 ? getPagination( array('perPage'=>30, 'fileName'=>getLink('news') .'?page=%d', 'totalItems'=>$news_in_db) ) : null
		));
		
		$tpl_file = null;

		if( is_file( VIEW_PATH . 'news' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'news' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'news' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);

	}	
	
	public function addAction(){
		
		$this->load_model('news', 'admin');
		$this->load_manager('news', 'admin');
		
		if( $this->app->HTTPRequest->postExists('news') ){
			$news = new news($this->app->HTTPRequest->postData('news'));
			
			if( $news->isValid() !== true ):
				goto print_form;
			endif;

			$news->post_on = time();
			
			$news->save();
			
			return $this->redirect($this->app->Helper->getLinkAdm('news'), 3, $this->lang['News_ajoutee']);
		}
		
		print_form:
		
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('news');

		$this->getFormValidatorJs();

		if( !$this->app->HTTPRequest->getExists('noeditor') ):
			$this->app->load_web_lib('markitup/skins/simple/style.css','css');
			$this->app->load_web_lib('markitup/sets/default/style.css','css');
			$this->app->load_web_lib('markitup/jquery.markitup.js','js');
			$this->app->load_web_lib('markitup/sets/default/set.js','js');
		endif;
		
		$this->app->smarty->assign(array(
			'categories' 	=> 	$this->manager->categorie->getAll(),
			'c_titre'		=>	$this->lang['Administration'] . ':: News',
		));
		
		$tpl_file = null;

		if( is_file( VIEW_PATH . 'news' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'news' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'news' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	/**
	 * Affiche et traite le formulaire d edition
	 * @param  [type] $id [description]
	 * @return [type]     [description]
	 */
	public function editAction($id){
		
		$this->load_model('news', 'admin');
		$this->load_manager('news', 'admin');
		
		if( $this->app->HTTPRequest->postExists('news') ){
			$news = new news($this->app->HTTPRequest->postData('news'));
			
			if( $news->isValid() !== true ):
				goto print_form;
			endif;
			
			$news->save();
			
			return $this->redirect($this->app->Helper->getLinkAdm('news'), 3, $this->lang['News_modifiee']);
		}
		
		print_form:
		
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('news');
		
		$this->getFormValidatorJs();
		
		if( !$this->app->HTTPRequest->getExists('noeditor') ):
			$this->app->load_web_lib('markitup/skins/simple/style.css','css');
			$this->app->load_web_lib('markitup/sets/default/style.css','css');
			$this->app->load_web_lib('markitup/jquery.markitup.js','js');
			$this->app->load_web_lib('markitup/sets/default/set.js','js');
		endif;
		
		$this->app->smarty->assign(array(
			'news'		 =>	new news($this->manager->news->getById($id)),
			'categories' => $this->manager->categorie->getAll(),
		));
		
		if( is_file( VIEW_PATH . 'news' . DS . 'edit.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'news' . DS . 'edit.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'news' . DS . 'edit.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function deleteAction($id){
		
		$this->app->db->delete(PREFIX . 'news', $id);
		$this->app->db->delete(PREFIX . 'news_commentaire', null, array('model_id =' => $id));
		return $this->redirect($this->app->Helper->getLinkAdm('news'), 3, $this->lang['News_supprimee']);
	}
}