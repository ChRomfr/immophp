<?php
class utilisateurManager extends BaseutilisateurManager{
	
	public function insert(utilisateur $user){
		return $this->db->insert(PREFIX . 'user', $user);
	}
}