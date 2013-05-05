<?php

class BaseutilisateurManager extends BaseModel{
    
   	public function existIdentifiant($identifiant){	
		return $this->db->count(PREFIX . 'user', array('identifiant = ' => $identifiant));	// Execution de la requete
	}
	
	public function existEmail($email){		
		return $this->db->count(PREFIX . 'user', array('email = ' => $email));	// Execution de la requete
	}
	
	public function save($user){
		if( empty($user->id) )
			return $this->db->insert(PREFIX . 'user', $user);
		else
			return $this->db->update(PREFIX . 'user', $user, array('id =' => $user->id));
	}
	
	public function getByIdentifiantAndPassword($user){
		return $this->db->get_one(PREFIX . 'user', array('identifiant =' => $user->identifiant, 'password =' => $user->password) );
	}
	
	public function getById($id){
		return $this->db->get_one(PREFIX . 'user', array('id =' => $id));
	}
	
	public function getUserForSelect(){
		return 	$this->db->select('id, identifiant')
				->from(PREFIX . 'user')
				->order('identifiant')
				->get();
	}
	
	public function	update($data){
		$this->db->update(PREFIX . 'user', $data);
	}
}