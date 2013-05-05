<?php

function blokUtilisateur($app){
	
	$app->smarty->assign(array(
		//'nbNotReadMessage'	=>	$app->db->count(PREFIX . 'messbox', array('lu =' => 0, 'destinataire_id =' => $_SESSION['utilisateur']['id']))
	));

	return $app->smarty->fetch(VIEW_PATH . 'blok' . DS . 'blokUtilisateur.tpl');
}