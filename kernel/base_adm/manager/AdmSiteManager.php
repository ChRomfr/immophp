<?php

class AdmSiteManager extends BaseModel{
	
	public function getAll($param = null, $limit = 10, $offset = 0){
		
		$Sites	=		$this->db->select('d.*, dc.name AS categorie, dc.lft, dc.rght')
						->from(PREFIX . 'annuaire_site d')
						->left_join(PREFIX . 'annuaire_categorie dc', 'dc.id = d.categorie_id')
						->where($param)
						->order('d.name')
						->limit($limit)
						->offset($offset)						
						->get();
		
		$i=0;		
		foreach( $Sites as $Site):
			// On recupere les categories parents
			$Sites[$i]['categories_parent'] = $this->db->get(PREFIX . 'annuaire_categorie', array('lft < ' => $Site['lft'], 'rght > ' => $Site['rght']));
			$i++;
		endforeach;

		return $Sites;
	}
	
	/**
	 * Recupere les informations pour un site
	 * @param  int $id Identifiant du site
	 * @return array $Site Tableau contenant les informations sur le site
	 */
	public function getById($id){
		
		$Site =	$this->db->select('d.*, dc.name AS categorie, dc.lft, dc.rght')
					->from(PREFIX . 'annuaire_site d')
					->left_join(PREFIX . 'annuaire_categorie dc', 'dc.id = d.categorie_id')
					->where( array('d.id =' => $id) )
					->get_one();

		$Site['categories_parent'] = $this->db->get(PREFIX . 'annuaire_categorie', array('lft < ' => $Site['lft'], 'rght > ' => $Site['rght']));

		return $Site;		
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