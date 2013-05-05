<?php

class AdmBlokModel extends Record{

	const Table = 'blok';

		public	$id,
			$position,
			$fichier,
			$call_fonction,
			$name,
			$contenu,
			$type,
			$visible,
			$ordre;
	
	/**
	*	Si 1 blok visible seulement sur la page d'index
	*	Si 0 blok visible sur toute les pages
	*/
	public	$only_index;
	
	/**
	*	Permet de definir par qui est visible le blok
	*	all
	*	member
	*	pilot
	*	admin
	*/
	public	$visible_by;
	
	public function setOnlyIndex( $value ){
		$this->only_index = $value;
	}
	
	public function setVisibleBy( $value ){
		$this->visible_by = $value;
	}
			
	public function isValid(){
		
		if( $this->type == 'HTML' )
			return $this->isValidHTML();
			
		return true;
				
	}
	
	private function isValidHTML(){
		
		if(	empty($this->position) || empty($this->ordre) || empty($this->name) || 	empty($this->contenu) )
			return false;
		else
			return true;			
				
	}
	
	public function setName($str){
		$this->name = $str;
	}

}