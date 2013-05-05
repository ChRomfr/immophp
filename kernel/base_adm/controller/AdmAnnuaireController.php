<?php

abstract class AdmAnnuaireController extends Controller{

	public function indexAction(){

		if( $this->app->HTTPRequest->getExists('param') ):
			$tmp = $this->app->HTTPRequest->getData('param');
			$param = array();
			foreach($tmp as $k => $v):
				$param[''. $k .' ='] = $v;
			endforeach;
		else:
			$param = null;
		endif;

		$per_page = 20;

		# Changement du model
		$this->load_manager('site','admin');

		# NbSites
		$NbSites = $this->app->db->count(PREFIX . 'annuaire_site', $param);

		$Pagination = new Zebra_Pagination();
		$Pagination->records($NbSites);
		$Pagination->records_per_page($per_page);
		
		$Sites = $this->manager->site->getAll($param, $per_page, getOffset($per_page) );

		$this->app->smarty->assign(array(
			'Sites'			=>	$Sites,
			'Pagination'	=>	$Pagination,
			'ctitre'		=>	'Administration :: Annuaire',
		));
		
		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'annuaire' . DS . 'index.tpl');
	}

	public function detailAction($id){

		# Chargement du model
		$this->load_manager('site','admin');

		if( $this->app->HTTPRequest->postExists('site') ):
			$Site = new myObject( $this->app->HTTPRequest->postData('site'));

			# Recuperation information du site actuel dans la base
			$Actuel = new myObject( $this->manager->site->getById($id) );

			if( $Actuel->status != 'valid' && $Site->status == 'valid'):
				$Site->valid_by   = $_SESSION['utilisateur']['id'];
				$Site->date_valid = TimeToDATETIME();
			endif;

			$Site->edit_on = TimeToDATETIME();

			$this->app->db->update(PREFIX . 'annuaire_site', $Site, array('id =' => $Site->id));

			return $this->redirect( $this->app->Helper->getLinkAdm('annuaire'), 3, 'Site modifié');

		endif;

		# Recuperation du site
		$Site = new myObject( $this->manager->site->getById($id) );

		# Recuperation information utilisateur
		if( !empty($Site->user_id) ):
			$Site->user = new myObject( $this->app->db->get_one(PREFIX . 'user', array('id =' => $Site->user_id)) );
		endif;

		$this->app->smarty->assign(array(
			'Site'		=>	$Site,
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'annuaire' . DS . 'detail.tpl');

	}

	/**
	 * Traite la suppression d un site de l annuaire
	 * @param  [type] $id [description]
	 * @return [type]     [description]
	 */
	public function deleteAction($id){
		$this->app->db->delete(PREFIX . 'annuaire_site', $id);
		return $this->redirect( $this->app->Helper->getLinkAdm('annuaire'), 3, 'Site supprimé');
	}

	/**
	 * Affiche et traite le formulaire pour les preferences
	 * de l annuaire
	 * @return [type] [description]
	 */
	public function settingAction(){

		

		if(  $this->Http->post('config') !== null):
			$Config = new Config();

			$Config->set( $this->Http->post('config') );
			$Config->save();
			$this->cache->remove('config');

			return $this->Helper->redirect( $this->Helper->getLinkAdm('annuaire/setting'), 3, 'Configuration sauvegardée' );

		endif;

		$this->Helper->getFormValidatorJs();
		return $this->tpl->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'annuaire' . DS . 'setting.tpl');
	}
}