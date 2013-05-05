<?php
/**
*	SHARKPHP VA
*	@author ChRom
*	@url http://www.sharkphp.com
*/

function blokMENU($menu_id, $app){

	if( !$Menu = $app->cache->get('blok_menu_' . $menu_id) ):
	
		// Recuperation du menu
		$Menu = $app->db->get_one(PREFIX . 'menu', array('id =' => $menu_id) );
		
		// Verification var $Menu non vide
		if( empty($Menu) ) return '';
		
		// Unserialize data
		$Menu['links'] = unserialize($Menu['links']);
		
		// Envoie des datas a smarty
		$app->smarty->assign('Menu', $Menu);
		
		// A lui de jouer ;)
		$Menu =  $app->smarty->fetch(VIEW_PATH . 'blok' . DS . 'blokMENU.tpl');

		$app->cache->save($Menu);

		return $Menu;

	endif;
	
	return $Menu;
}