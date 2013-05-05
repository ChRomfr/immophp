<?php

abstract class AdmPageModel extends Record{

	const Table = 'page';
	
	public	$id,
			$titre,
			$contenu,
			$creat_on,
			$edit_on,
			$auteur_id,
			$visible;
			
	public function isValid(){
		if( empty($this->titre) || empty($this->contenu) )
			return false;
		
		return true;
	}
	
}