<?php

class agenceManager extends BaseModel{
	
	public function save(agence $Agence){
		if( empty($Agence->id) ):
			return $this->insert($Agence);
		else:
			return $this->update($Agence);
		endif;
	}
	
	private function insert($Agence){
		return $this->db->insert(PREFIX . 'agence', $Agence);
	}
	
	private function update($Agence){
		return $this->db->update(PREFIX . 'agence', $Agence);
	}
    
    public function delete($agence_id){
        return $this->db->delete(PREFIX . 'agence', $agence_id);
    }
	
	public function getAll(){
		
		return	$this->db->select('ag.*')
					->from(PREFIX . 'agence ag')
					->order('nom, code_postal, ville')
					->get();
		
	}
	
    public function getAllExludeById($agence_id){
        return	$this->db->select('ag.*')
					->from(PREFIX . 'agence ag')
                    ->where(array('id <>' => $agence_id))
					->order('nom, code_postal, ville')
					->get();
    }
    
    public function getById($agence_id){
        return $this->db->get_one(PREFIX . 'agence', array('id =' => $agence_id));
    }
}