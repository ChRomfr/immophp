<?php

function blokActualite($app, $blok){
	
	# Recuperation des actualités
	$News = $app->db
				->select('n.id, n.sujet, post_on, nc.name as categorie, u.identifiant as auteur')
				->from(PREFIX . 'news n')
				->left_join(PREFIX . 'news_categorie nc','n.categorie_id = nc.id')
				->left_join(PREFIX . 'user u','n.auteur_id = u.id')
				->order('n.post_on DESC')
				->limit(5)
				->get();

	# Envoie a smarty
	$app->smarty->assign(array(
		'blok'		=>	$blok, 
		'News'		=>	$News,
	));

	return $app->smarty->fetch(VIEW_PATH . 'blok' . DS . 'blokActualite.tpl');
}