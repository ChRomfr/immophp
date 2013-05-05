<?php

class blokManager extends BaseModel{

	public function save(blok $blok){
		if( empty($blok->id) ):
			return $this->db->insert(PREFIX . 'blok', $blok);
		else:
			return $this->db->update(PREFIX . 'blok', $blok, array('id =' => $blok->id));
		endif;
	}
	
	public function getAll(){
		return $this->db->get(PREFIX . 'blok', null, 'position,ordre');
	}
	
	public function getByid($id){
		return $this->db->get_one(PREFIX . 'blok', array('id =' => $id));
	}


}