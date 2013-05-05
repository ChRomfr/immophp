<?php


class BaseannuaireManager extends BaseModel{
	
		public function getAll($limit = 20, $offset = 0, $categorie = null, $order = 'asi.add_on DESC'){
		
		$this->db
			->select('asi.*, ac.name AS categorie')
			->from(PREFIX . 'annuaire_site asi')
			->left_join(PREFIX . 'annuaire_categorie ac', 'ac.id = asi.categorie_id');
				
		if( !is_null($categorie) ):
			$this->db->where( array('categorie_id =' => $categorie) );
		endif;

			$this->db
				->where(array(
					'status ='	=>	'valid',
					'visible ='	=>	1,
				));

				
		return	$this->db
					->order($order)
					->limit($limit)
					->offset($offset)
					->get();
		
	}
	
	public function getById($id){
		
		return 	$this->db->select('asi.*, ac.name AS categorie')
				->from(PREFIX . 'annuaire_site asi')
				->left_join(PREFIX . 'annuaire_categorie ac', 'ac.id = asi.categorie_id')
				->where( array('asi.id =' => $id, 'asi.visible =' => 1) )
				->get_one();
		
	}
	
	public function count($cid = null){

		if( is_null($cid) ):
			return $this->db->count(PREFIX . 'annuaire_site');
		endif;
		
		return $this->db->count(PREFIX . 'annuaire_site', array('categorie_id =' => $cid) ); 
	}
		
}