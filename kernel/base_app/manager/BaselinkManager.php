<?php

class BaselinkManager extends BaseModel{
	
	public function getAll($limit = 20, $offset = 0, $categorie = null){
		
		$this->db->select('d.*, dc.name AS categorie')
		->from(PREFIX . 'link d')
		->left_join(PREFIX . 'link_categorie dc', 'dc.id = d.categorie_id');
				
		if( !is_null($categorie) )
			$this->db->where( array('categorie_id =' => $categorie, 'd.actif =' => 1) );	
				
		return	$this->db->order('d.name')
				->limit($limit)
				->offset($offset)
				->get();
		
	}
	
	public function getById($id){
		
		return 	$this->db->select('d.*, dc.name AS categorie')
				->from(PREFIX . 'link d')
				->left_join(PREFIX . 'link_categorie dc', 'dc.id = d.categorie_id')
				->where( array('d.id =' => $id, 'd.actif =' => 1) )
				->get_one();
		
	}
	
	public function count($cid = null){
		if( is_null($cid) ) return $this->db->count(PREFIX . 'link');
		
		return $this->db->count(PREFIX . 'link', array('categorie_id =' => $cid) ); 
	}
	
	public function getLast($limit = 10){
		return 	$this->db->select('d.*, dc.name AS categorie')
				->from(PREFIX . 'download d')
				->left_join(PREFIX . 'download_categorie dc', 'dc.id = d.categorie_id')
				->order('d.id DESC')
				->limit($limit)
				->get();

	}
	
}