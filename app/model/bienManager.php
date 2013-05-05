<?php

class bienManager extends BaseModel{
        
     /**
     * Recupere tout les biens non delete dans la base
     * @return type
     */
	public function getAll($param = null, $order = null, $limit = null, $offset = null){
		
		$this->db
            ->select('b.*, bc.name as categorie, u.identifiant, cl.libelle as transaction_type')
            ->from(PREFIX . 'bien b')
            ->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
            ->left_join(PREFIX . 'user u','b.add_by = u.id')
            ->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
            ->where(array('b.delete =' => 0, 'b.visible =' => 1));
            
            if( !is_null($param) && is_array($param) ):
                $this->db->where($param);
            endif;                
            
            $this->db->order($order);
            
            if( !is_null($limit) ):
                $this->db->limit($limit);
            endif;
            
            if( !is_null($offset) ):
                $this->db->offset($offset);
            endif;
            
        return $this->db->get();      
    }
    
    public function getAllForXML($param = null, $limit = 20, $offset = null){
        $this->db
            ->select('b.*, bc.name as categorie, u.identifiant, cl.libelle as transaction_type, a.nom as agence')
            ->from(PREFIX . 'bien b')
            ->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
            ->left_join(PREFIX . 'user u','b.add_by = u.id')
            ->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
            ->left_join(PREFIX . 'agence a','b.agence_id = a.id')
            ->where(array('b.delete =' => 0, 'b.visible =' => 1));
            
            if( !is_null($param) && is_array($param) ):
                $this->db->where($param);
            endif;                
            
            $this->db->order('b.add_on DESC');
            
            if( !is_null($limit) ):
                $this->db->limit($limit);
            endif;
            
            if( !is_null($offset) ):
                $this->db->offset($offset);
            endif;
            
        return $this->db->get();
    }
    
    public function count($param = null){
        if( is_null($param) ):
            return $this->db->count(PREFIX . 'bien b', array('b.delete =' => 0, 'b.visible =' => 1) );
        else:
            $param = array_merge($param, array('b.delete =' => 0, 'b.visible =' => 1));
            return $this->db->count(PREFIX . 'bien b', $param);
        endif;
        
    }
    
    public function getById($bien_id){
        return  $this->db
                    ->select('b.*, bc.name as categorie, u.identifiant, cl.libelle as transaction_type, a.nom as agence')
                    ->from(PREFIX . 'bien b')
                    ->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
                    ->left_join(PREFIX . 'user u','b.add_by = u.id')
                    ->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
                    ->left_join(PREFIX . 'agence a','b.agence_id = a.id')
                    ->where(array('b.delete =' => 0, 'b.visible=' => 1, 'b.id =' => $bien_id))
                    ->get_one();
    }
}