<?php
class message extends Record{
	
	public	$id,
			$destinataire_id,
			$auteur_id,
			$message,
			$lu = 0,
			$post_on,
			$discussion_id;
			
	public function isValid(){
		if( empty($this->destinataire_id) || empty($this->message) ){
			return false;
		}

		return true;
	}
	
	public function setAuteurId($id){
		$this->auteur_id = $id;
	}
	
	public function save($manager){
		$this->post_on = time();
		return $manager->insert($this);				
	}
	
	
}