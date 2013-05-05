<?php

class systemeController extends AdmSystemeController{
	
	public function indexAction(){
		
		// Recuperation des et utilisateur en lignr
		$users_online = $this->app->db->select('u.identifiant, s.*')->from(PREFIX . 'sessions s')->left_join(PREFIX . 'user u', 'u.id = s.user_id')->where( array('last_used >' => time() - 300) )->get();
		
		$this->app->smarty->assign('uonline', $users_online);
			
		return $this->app->smarty->fetch(VIEW_PATH . 'systeme' . DS . 'index.tpl');
	}
		
}	// end of class