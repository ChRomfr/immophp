<?php

class statsController extends Controller{
	
	public function indexAction(){
		$Stats = array(
			'NbMembres'			=>	$this->app->db->count(PREFIX . 'user'),
			'NbSessions'		=>	$this->app->db->count(PREFIX . 'carpbook_session'),
			'NbDeparts'			=>	$this->app->db->count(PREFIX . 'carpbook_depart'),
			'NbLieux'			=>	$this->app->db->count(PREFIX . 'carpbook_lieu'),
			'NbPostes'			=>	$this->app->db->count(PREFIX . 'carpbook_poste'),
			'NbPhotosDeparts'	=>	$this->app->db->count(PREFIX . 'carpbook_depart_photo'),
		);
		
		$this->app->smarty->assign(array(
			'Stats'		=>	$Stats,
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'stats' . DS . 'index.tpl');
	}
}
