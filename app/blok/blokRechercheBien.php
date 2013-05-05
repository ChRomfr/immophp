<?php

function blokRechercheBien($app, $Blok){
    
    
    $app->smarty->assign(array(
		'Agences'		=>	getAgences($app), 
       	'Categories' 	=>  getCategories($app),
    ));
    
    return $app->smarty->fetch(VIEW_PATH . 'blok' . DS . 'blokRechercheBien.tpl');
    
}