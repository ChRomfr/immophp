<?php

class agenceManager extends BaseModel{
    
    public function getAll(){
        return  $this->db->get(PREFIX . 'agence');
    }
    
    public function getById($id){
        return  $this->db
                    ->select('a.*')
                    ->from(PREFIX . 'agence a')
                    ->where(array('a.id =' => $id))
                    ->get_one();
    }
    
    public function getEmailByBienId($bien_id){
        return  $this->db
                    ->select('a.email')
                    ->from(PREFIX . 'agence a')
                    ->left_join(PREFIX . 'bien b','b.agence_id = a.id')
                    ->where(array('b.id =' => $bien_id))
                    ->get_one();
    }
}