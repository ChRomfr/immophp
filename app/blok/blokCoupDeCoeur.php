<?php

function blokCoupDeCoeur($app){
	
	// Recuperation d un coup de coeur aleatoire dans base
	$Annonce	=	$app->db
						->select('b.id, b.nom, b.reference, b.prix')
						->from(PREFIX . 'bien b')
						->where(array('b.visible =' => 1, 'b.vendu =' => 0, 'b.delete =' => 0, 'b.coup_de_coeur =' => 1))
						->order('RAND()')
						->get_one();

	// On traite le cas 0 coup de coeur dans la base
	// On recupere une annonce aleatoire dans la base
	if( empty($Annonce) ):
		$Annonce	=	$app->db
						->select('b.id, b.nom, b.reference, b.prix')
						->from(PREFIX . 'bien b')
						->where(array('b.visible =' => 1, 'b.vendu =' => 0, 'b.delete =' => 0))
						->order('RAND()')
						->get_one();
	endif;

	// On recupere une photo pour l'annonce
	$Tmp = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $Annonce['id'] . DS);

	$y=1;
	if( $Tmp && count($Tmp) > 0){
		foreach( $Tmp as $key => $value ):
			$Annonce['photo'] = $value;
			if($y==1):
				break;
			endif;
		endforeach;
	}
	

	// envoie des vars au template et generation du code HTML
	$app->smarty->assign('Annonce',$Annonce);

	return $app->smarty->fetch( VIEW_PATH . 'blok' . DS . 'blokCoupDeCoeur.tpl' );

}