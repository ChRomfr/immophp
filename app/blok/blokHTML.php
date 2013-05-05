<?php
/**
*	SHARKPHP VA
*	CMS FOR VIRTUAL AIRLINE
*	@author ChRom
*	@url http://va.sharkphp.com
*/

function blokHTML($blok, $app){
	$app->smarty->assign('blok', $blok);
	return $app->smarty->fetch(VIEW_PATH . 'blok' . DS . 'blokHTML.tpl');
}