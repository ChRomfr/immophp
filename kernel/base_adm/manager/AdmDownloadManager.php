<?php

class AdmDownloadManager extends BaseModel{
	
	public function save(download $download){
		
		if( empty($download->id) )
			return $this->db->insert(PREFIX . 'download', $download);
		else
			return $this->db->update(PREFIX . 'download', $download, array('id =' => $download->id));
			
	}
	
	public function getAll(){
		
		$Downloads	=	$this->db->select('d.*, dc.name AS categorie, dc.lft, dc.rght, u.identifiant as utilisateur')
						->from(PREFIX . 'download d')
						->left_join(PREFIX . 'download_categorie dc', 'dc.id = d.categorie_id')
						->left_join(PREFIX . 'user u','d.add_by = u.id')
						->order('d.name')
						->get();
		
		$i=0;		
		foreach( $Downloads as $Download):
			// On recupere les categories parents
			$Downloads[$i]['categories_parent'] = $this->db->get(PREFIX . 'download_categorie', array('lft < ' => $Download['lft'], 'rght > ' => $Download['rght']));
			$i++;
		endforeach;
		return $Downloads;
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