<?php

abstract class AdmNewsManager extends BaseModel{
	
	public function getAll($limit, $offset){
		$News	=	$this->db->select('n.*, u.identifiant, c.name AS categorie, c.lft, c.rght')
					->from(PREFIX . 'news n')	
					->left_join(PREFIX . 'user u', 'u.id = n.auteur_id')
					->left_join(PREFIX . 'news_categorie c', 'c.id = n.categorie_id')
					->order('n.post_on DESC')
					->limit($limit)
					->offset($offset)
					->get();
					
		$i=0;		
		foreach( $News as $New):
			// On recupere les categories parents
			$News[$i]['categories_parent'] = $this->db->get(PREFIX . 'news_categorie', array('lft < ' => $New['lft'], 'rght > ' => $New['rght']));
			$i++;
		endforeach;
		return $News;
	}
	
	public function getById($id){
		return $this->db->get_one(PREFIX . 'news', array('id =' => $id));
	}
	
	public function count(){
		return $this->db->count(PREFIX . 'news');
	}
	
	public function insert(news $news){
		return $this->db->insert(PREFIX . 'news', $news);
	}
	
	public function update(news $news){
		return $this->db->update(PREFIX . 'news', $news, array('id =' => $news->id));
	}
}