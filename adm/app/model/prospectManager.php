<?php

class prospectManager extends BaseModel{
    
    public function getAll($param = null, $limit = null, $offset = null){
        
       $this->db
               ->select('p.*, u1.identifiant as user_add, a.nom as agence')
               ->from(PREFIX . 'prospect p')
               ->left_join(PREFIX . 'user u1','p.add_by = u1.id')
               ->left_join(PREFIX . 'agence a','p.agence_id = a.id');
               
       if( !is_null($param) ):
           if( is_array($param) ):
               $this->db->where($param);
           else:
               $this->db->where_free($param);
           endif;
       endif;
       
       $this->db->order('p.nom, p.prenom');
       
       if( !empty($limit) ):
           $this->db->limit($limit);
       endif;
       
       if( !empty($offset) ):
           $this->db->offset($offset);
       endif;
       
       return $this->db->get();        
    }
    
    public function getById($id){
        
        return  $this->db
                    ->select('p.*, u1.identifiant as user_add, u2.identifiant as user_edit, a.nom as agence')
                    ->from(PREFIX . 'prospect p')
                    ->left_join(PREFIX . 'user u1','p.add_by = u1.id')
                    ->left_join(PREFIX . 'user u2','p.edit_by = u2.id')
                    ->left_join(PREFIX . 'agence a','p.agence_id = a.id')
                    ->where(array('p.id =' => $id))
                    ->get_one();
        
    }
    
    public function getVendeurs(){
        return  $this->db
                    ->select('p.*')
                    ->from(PREFIX . 'prospect p')
                    ->where(array('p.vendeur =' => 1, 'p.delete =' => 0))
                    ->order('p.nom, p.prenom')
                    ->get();
    }
    
     public function getAcheteurs(){
        return  $this->db
                    ->select('p.*')
                    ->from(PREFIX . 'prospect p')
                    ->where(array('p.acheteur =' => 1, 'p.delete =' => 0))
                    ->order('p.nom, p.prenom')
                    ->get();
    }
    
    public function searchByNom($Nom){
        return  $this->db
                   ->select('p.*, u1.identifiant as user_add')
                   ->from(PREFIX . 'prospect p')
                   ->left_join(PREFIX . 'user u1','p.add_by = u1.id')
                   ->where(array('p.delete =' => 0))
                   ->where_free("p.nom LIKE '%". $Nom ."%'")
                   ->order('p.nom,p.prenom')
                   ->get();
    }
}