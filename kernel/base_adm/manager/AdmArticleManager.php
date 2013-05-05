<?php

abstract class AdmArticleManager extends BaseModel{
	
	public function getAll(){
		return	$this->db->select('a.*, ac.name as categorie, u.identifiant as utilisateur')
				->from(PREFIX . 'article a')
				->left_join(PREFIX . 'article_categorie ac','a.categorie_id = ac.id')
				->left_join(PREFIX . 'user u','a.author = u.id')
				->order('a.title, a.categorie_id')
				->get();
	}
	
	public function getById($article_id){
		return	$this->db->select('a.*, ac.name as categorie, u.identifiant as utilisateur')
				->from(PREFIX . 'article a')
				->left_join(PREFIX . 'article_categorie ac','a.categorie_id = ac.id')
				->left_join(PREFIX . 'user u','a.author = u.id')
				->where(array('a.id =' => $article_id))
				->get_one();
	}
	
	public function save( article $Article ){
		if( empty($Article->id) ) return $this->insert($Article);
		else return $this->update($Article);
	}
	
	
	private function insert( article $Article ){
		return $this->db->insert(PREFIX . 'article', $Article);
	}
	
	private function update( article $Article ){
		return $this->db->update(PREFIX . 'article', $Article, array('id =' => $Article->id));
	}
	
	public function delete( $article_id ){
		return $this->db->delete(PREFIX . 'article', $article_id);
	}
	
}