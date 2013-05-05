<?php

class utilisateurManager extends BaseModel{
	
	public function getAll(){
		
		return	$this->db->get(PREFIX . 'user', null, 'identifiant');
		
	}
	
	public function delete($id){		
		$this->db->delete(PREFIX . 'user', $id);
		$this->db->delete(PREFIX . 'sessions', null, array('user_id =' => $id) );		
	}
	
	public function getById($id){
		return $this->db->get_one(PREFIX . 'user', array('id =' => $id));
	}
	
	public function update($user){
		return $this->db->update(PREFIX . 'user', $user);
	}
	
}