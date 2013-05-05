<?php

abstract class AdmNewsModel extends Record{

	const Table = 'news';

	public	$id,
			$sujet,
			$contenu,
			$contenu_suite,
			$post_on,
			$auteur_id,
			$categorie_id,
			$source,
			$source_link,
			$commentaire;
			
	public function isValid(){
		
		if( empty($this->sujet) || empty($this->contenu) || empty($this->auteur_id) ){
			return false;
		}
		
		return true;
	}
}