<?php
/**
*	SHARKPHP VA
*	CMS FOR VIRTUAL AIRLINE
*	@author ChRom
*	@url http://va.sharkphp.com
*/

function blokRSS($blok, $app){
	
	$blok['contenu'] = unserialize($blok['contenu']);
	
	require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'FeedReader.php';
	
	if( $blok['position'] == 'right' OR $blok['position'] == 'left' ):
	
		$app->smarty->assign(array(
			'blok'		=>	$blok,
			'flux'		=>	$Flux = new Feed($blok['contenu']['flux1']),	
		));
		
	else:
        
        // Traitement du cookie show/hide
        if( isset($_COOKIE['blok_' . $blok['id'].'']) && $_COOKIE['blok_' . $blok['id'].''] == 'hidden' ):
        	$blok['visible'] = false;
        else:
        	$blok['visible'] = true;
        endif;
	
		$app->smarty->assign(array(
			'blok'		=>	$blok,
			'flux'		=>	new Feed($blok['contenu']['flux1']),	
			'flux2'		=>	!empty($blok['contenu']['nameflux2']) ? new Feed($blok['contenu']['flux2']) : '',
		));
		
	endif;
	
	return $app->smarty->fetch(VIEW_PATH . 'blok' . DS . 'blokRSS.tpl'); 
}

