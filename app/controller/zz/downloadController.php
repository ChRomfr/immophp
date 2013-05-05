<?php
if( !defined('IN_VA')) exit;

/**
*	downloadController
*	Gere l affichage des pages liées au telechagermen
*	@author ChRom
*/
require_once BASE_APP_PATH . 'controller' . DS . 'BaseDownloadController.php';

class downloadController extends Basedownloadcontroller{
	
	public function __construct($registry){
		parent::__construct($registry);
		
		// ACL
		if( ($this->registry->config['download_view_by'] == 'pilot' && $_SESSION['utilisateur']['id'] == 'Visiteur') || ( $this->registry->config['download_view_by'] == 'pilot' && isset($_SESSION['utilisateur']['pilot']) && $_SESSION['utilisateur']['pilot'] != 1) ):
			header('location:' . getLink("index") ); exit;
		elseif($this->registry->config['download_view_by'] == 'member' && $_SESSION['utilisateur']['id'] == 'Visiteur'):
			header('location:' . getLink("index") ); exit;
		endif;
	}
	
		
}  // class