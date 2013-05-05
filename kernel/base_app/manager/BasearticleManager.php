<?php

class BasearticleManager extends BaseModel{
	
	public function getById($article_id){
		return	$this->db->select('a.*, ac.name as categorie, u.identifiant as utilisateur, ac.lft, ac.rght')
				->from(PREFIX . 'article a')
				->left_join(PREFIX . 'article_categorie ac','a.categorie_id = ac.id')
				->left_join(PREFIX . 'user u','a.author = u.id')
				->where(array('a.id =' => $article_id))
				->get_one();
	}
	
	public function getAll($param = NULL){
		$this->db->select('a.*, ac.name as categorie, u.identifiant as utilisateur')
			->from(PREFIX . 'article a')
			->left_join(PREFIX . 'article_categorie ac','a.categorie_id = ac.id')
			->left_join(PREFIX . 'user u','a.author = u.id');
			
		if( !is_null($param) && is_array($param) )
			$this->db->where($param);
			
		$this->db->order('a.title, a.categorie_id');
		
		return $this->db->get();
	}

	public function getLast($limit = 10){
		return	$this->db->select('a.*, ac.name as categorie, u.identifiant as utilisateur, ac.lft, ac.rght')
				->from(PREFIX . 'article a')
				->left_join(PREFIX . 'article_categorie ac','a.categorie_id = ac.id')
				->left_join(PREFIX . 'user u','a.author = u.id')
				->where(array('a.visible =' => 1))
				->order('a.creat_on DESC')
				->limit($limit)
				->get(); 	
	}
	
}