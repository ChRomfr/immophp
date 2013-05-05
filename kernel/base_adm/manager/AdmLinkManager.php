<?php

class AdmLinkManager extends BaseModel{
		
	public function getAll(){
		
		$Links	=	$this->db->select('l.*, lc.name AS categorie, lc.lft, lc.rght, u.identifiant as utilisateur')
						->from(PREFIX . 'link l')
						->left_join(PREFIX . 'link_categorie lc', 'lc.id = l.categorie_id')
						->left_join(PREFIX . 'user u','l.auteur_id = u.id')
						->order('l.name')
						->get();
		
		$i=0;		
		foreach( $Links as $Link):
			// On recupere les categories parents
			$Links[$i]['categories_parent'] = $this->db->get(PREFIX . 'link_categorie', array('lft < ' => $Link['lft'], 'rght > ' => $Link['rght']));
			$i++;
		endforeach;
		return $Links;
	}
	
	public function getById($id){
		
			return 	$this->db->select('d.*, dc.name AS categorie')
					->from(PREFIX . 'download d')
					->left_join(PREFIX . 'download_categorie dc', 'dc.id = d.categorie_id')
					->where( array('d.id =' => $id) )
					->get_one();
		
	}
	
	public function getAllForLink($exclusion = array() ){
		
		$this->db->select('d.*, dc.name AS categorie')
			->from(PREFIX . 'download d')
			->left_join(PREFIX . 'download_categorie dc', 'dc.id = d.categorie_id');
			
			if( !empty($exclusion) ):
				foreach($exclusion as $k => $v):
					$this->db->where(array('d.id !=' => $v));
				endforeach;
			endif;
		$this->db->order('d.name');
		return $this->db->get();
		
	}
}