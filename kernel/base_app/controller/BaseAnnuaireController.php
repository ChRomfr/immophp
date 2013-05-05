<?php

abstract class Baseannuairecontroller extends Controller{


	public function indexAction(){

		$per_page = 10;
		
		$Tree = new Tree($this->app->db, PREFIX . 'annuaire_categorie');
		
		$this->load_manager('annuaire', 'base_app');
		
		if( $this->app->HTTPRequest->getExists('cid') ): 

			$categorie_id = $this->app->HTTPRequest->getData('cid');

			$Categorie = $this->app->db->get_one(PREFIX . 'annuaire_categorie', array('id =' => $categorie_id));
			$Categories = $this->app->db->get(PREFIX . 'annuaire_categorie', array('parent_id =' => $categorie_id), 'name');
			$Parents = $Tree->getParent($Categorie['lft'], $Categorie['rght']);
			
			$Sites		= $this->manager->annuaire->getAll( $per_page, getOffset($per_page), $categorie_id );
			$NbSites	= $this->manager->annuaire->count($categorie_id);

			$Pagination = new Zebra_Pagination();
			$Pagination->records($NbSites);
			$Pagination->records_per_page($per_page);

			$this->app->smarty->assign(array(
				'Parents'		=>	$Parents,
				'Categorie'		=>	$Categorie,
				'Sites'			=>	$Sites,
				'NbSites'		=>	$NbSites,
				'Pagination'	=>	$Pagination,
				'Categories'	=>	$Categories,
			));
			
		else:

			$categorie_id = 0;	
			$Categories   = $this->app->db->get(PREFIX . 'annuaire_categorie', array('parent_id =' => 0), 'name');
			$LastSites    = $this->manager->annuaire->getAll(10, 0, null);

			$this->app->smarty->assign(array(
				'Sites'			=>	$LastSites,
				'Categories'	=>	$Categories,
				'ctitre'		=>	'Annuaire',
			));

		endif;	
				
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'annuaire' . DS . 'index.tpl');
	}

	public function detailAction($id){
		# Chargement du model
		$this->load_manager('annuaire', 'base_app');

		# Recuperation du fichier
		$Site = new myObject( $this->manager->annuaire->getById($id) );

		# Recuperation des categories parents
		$Tree = new Tree($this->app->db, PREFIX . 'annuaire_categorie');
		$Categorie = $this->app->db->get_one(PREFIX . 'annuaire_categorie', array('id =' => $Site->categorie_id));
		$Parents = $Tree->getParent($Categorie['lft'], $Categorie['rght']);

		$Site->description = BBCode2Html($Site->description);

		# Envoie a smarty des donnees
		$this->app->smarty->assign(array(
			'Site'					=>	$Site,
			'Parents'				=>	$Parents,
			'Categorie'				=>	$Categorie,
			'ctitre'				=>	'Annuaire' . ' :: ' . $Site->name,
			'Description_this_page'	=>	$Site->resume,
		));

		if( !empty($Site->flux_rss_1) && $this->app->config['annuaire_site_rss'] == 1):
			$this->app->smarty->assign('Flux1', new Feed($Site->flux_rss_1) );
		endif;

		if( !empty($Site->flux_rss_2) && $this->app->config['annuaire_site_rss'] == 1):
			$this->app->smarty->assign('Flux2', new Feed($Site->flux_rss_2) );
		endif;
		
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'annuaire' . DS . 'detail.tpl');
	}

	public function proposerAction(){

		if( $this->app->HTTPRequest->postExists('site') ):
			$Site = new Basesite($this->app->HTTPRequest->postData('site'));

			$Result = $Site->isValid($this->app->config);

			if( $Result !== true):
				$this->app->smarty->assign('Error', $Result);
				goto printform;
			endif;

			$Site->prepareForSave();

			$Site->save();

			return $this->redirect( $Helper->$this->app->Helper->getLink('annuaire'), 3, 'Votre site vient d etre proposé' );

		endif;

		printform:

		$this->load_manager('categorie');
		$this->manager->categorie->setTable('annuaire');

		$this->getFormValidatorJs();

		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/bbcode/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/bbcode/set.js','js');

		$this->app->smarty->assign(array(
			'categories'	=>	$this->manager->categorie->getAll(),
			'ctitre'		=>	'Annuaire :: Proposer un site',
		));

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'annuaire' . DS . 'proposer.tpl');
	}

	public function lienderetourAction(){
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'annuaire' . DS . 'lienderetour.tpl');
	}

}