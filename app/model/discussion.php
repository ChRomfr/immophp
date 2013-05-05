<?php
class discussion extends Record{
	
	public	$id,
			$sujet,
			$reply = 1,
			$last_update;
			
	
	public function isValid(){
		if( empty($this->sujet) ){
			return false;
		}
		
		return true;
	}
	
	public function save($manager){
		$this->last_update = time();
		
		if( empty($this->id) ){
			return $manager->insert($this);
		}else{
			return $amanegr->update($this);
		}
	}
}