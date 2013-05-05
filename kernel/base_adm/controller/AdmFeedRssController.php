<?php

abstract class AdmFeedRssController extends Controller{

	public function indexAction(){

		# Recuperation des liens
		$Flux 	=	$this->app->db->get(PREFIX . 'feed_rss_link');

		# Envoie a smarty
		$this->app->smarty->assign(array(
			'Flux'	=>	$Flux 
		));
		
		# Generation du template
		return $this->app->smarty->fetch( ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'feedrss' . DS . 'index.tpl');
	}

	public function addAction(){

		if( $this->app->HTTPRequest->postExists('link') ):
			$Flux = new AdmFluxLinkModel($this->app->HTTPRequest->postData('link'));
			$Flux->save();
			return $this->redirect( $this->app->Helper->getLinkAdm('feedRss'), 3, 'Flux enregistre');
		endif;

		$this->getFormValidatorJs();
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('feed_rss_link');

		$this->app->smarty->assign(array(
			'categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	$this->lang['Administration'] . ' :: Nouveau fil d actualite',
		));
		
		# Generation du template
		return $this->app->smarty->fetch( ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'feedrss' . DS . 'add.tpl');
	}

	public function editAction($id){

		if( $this->app->HTTPRequest->postExists('link') ):
			$Flux = new AdmFluxLinkModel($this->app->HTTPRequest->postData('link'));
			$Flux->save();
			return $this->redirect( $this->app->Helper->getLinkAdm('feedRss'), 3, 'Flux enregistre');
		endif;

		$Flux = new AdmFluxLinkModel();
		$Flux->get($id);

		$this->getFormValidatorJs();
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('feed_rss_link');

		# Envoie a smarty
		$this->app->smarty->assign(array(
			'Flux'			=>	$Flux,
			'categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	$this->lang['Administration'] . ' :: Edition fil d actualite',
		));
		
		# Generation du template
		return $this->app->smarty->fetch( ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'feedrss' . DS . 'edit.tpl');
	}

	public function deleteAction($id){

		$this->app->db->delete(PREFIX . 'feed_rss_link', $id);
		$this->app->db->delete(PREFIX . 'feed_rss_item', null, array('feed_rss_link_id = ' => $id));

		return $this->redirect( $this->app->Helper->getLinkAdm('feedRss'), 3, 'Flux supprime');
	}

}