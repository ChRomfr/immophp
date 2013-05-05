<?php

Abstract class AdmPageManager extends BaseModel{
	
	public function save(page $page){
		if( empty($page->id) )
			return $this->db->insert(PREFIX . 'page', $page);
		else
			return $this->db->update(PREFIX . 'page', $page, array('id =' => $page->id));
	}
	
	public function getAll(){
		return	$this->db->select('p.*, u.identifiant')
				->from(PREFIX . 'page p')
				->left_join(PREFIX . 'user u', 'u.id = p.auteur_id')
				->get();
	}
	
	public function getById($id){
		return	$this->db->select('p.*, u.identifiant')
				->from(PREFIX . 'page p')
				->left_join(PREFIX . 'user u', 'u.id = p.auteur_id')
				->where( array('p.id =' => $id))
				->get_one();
	}
	
}