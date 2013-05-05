<?php

class membreController extends Controller{
	
	/**
	 * Affiche la liste des membres ayant un profil public
	 * @return html
	 */
	public function indexAction(){
		$this->load_manager('user');
		
		$Membres =	$this->manager->user->getAllProfilPublic();
		
		$this->app->smarty->assign(array(
			'ctitre'				=>	'Membres',
			'description_this_page'	=>	'Liste des carpistes',
			'Membres'				=>	$Membres,
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'membre' . DS . 'index.tpl');
		
	}
	
}