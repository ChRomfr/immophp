<?php

class Basecommentaire extends Record{

	public	$commentaire,
			$auteur_id,
			$post_on,
			$model_id;
			
	public function setPostOn($time){
		$this->post_on = $time;
	}
			
	public function isValid(){
		
		if( !empty($this->commentaire) && !empty($this->auteur_id) && !empty($this->model_id) ):
			$this->commentaire = strip_tags($this->commentaire);
			$this->commentaire = htmlentities($this->commentaire);
			return true;
		endif;
		
		return false;
	}
	
} // end class