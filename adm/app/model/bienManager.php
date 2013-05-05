<?php
 
class bienManager extends BaseModel{
	
    /**
     * Recupere tout les biens non delete dans la base
     * @return type
     */
	public function getAll($limit = 50, $offset = 0){
		
		return	$this->db->select('b.*, bc.name as categorie, u.identifiant, cl.libelle as transaction_type, a.nom as agence')
					->from(PREFIX . 'bien b')
					->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
					->left_join(PREFIX . 'user u','b.add_by = u.id')
					->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
                    ->left_join(PREFIX . 'agence a','b.agence_id = a.id')
                    ->where(array('b.delete =' => 0))
					->order('b.add_on DESC')
                    ->limit($limit)
                    ->offset($offset)
					->get();
		
	}
	
    /**
     * Recupere un bien par son id
     * @param type $bien_id
     * @return type
     */
    public function getById($bien_id){
		
		return	$this->db->select('b.*, bc.name as categorie, u.identifiant, cl.libelle as transaction_type, pa.nom as acheteur_nom, pa.prenom as acheteur_prenom, uv.identifiant as vendeur_identifiant')
					->from(PREFIX . 'bien b')
					->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
					->left_join(PREFIX . 'user u','b.add_by = u.id')
					->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
                    ->left_join(PREFIX . 'user uv','b.vendu_by = uv.id')
                    ->left_join(PREFIX . 'prospect pa','b.acheteur_id = pa.id')
					->where( array('b.id =' => $bien_id) )
					->get_one();
		
	}
    
     /**
     * Recupere un bien par son id
     * @param type $bien_id
     * @return type
     */
    public function getByRef($ref){
		
		return	$this->db->select('b.*, bc.name as categorie, u.identifiant, cl.libelle as transaction_type')
					->from(PREFIX . 'bien b')
					->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
					->left_join(PREFIX . 'user u','b.add_by = u.id')
					->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
					->where( array('b.reference =' => $ref) )
					->get();
		
	}
    
    /**
     * Traite les enregistrement dans la base de donnees
     * @param bien $Bien
     * @return int
     */
	public function save(bien $Bien){
		
		if( empty($Bien->id) ):
			return $this->db->insert(PREFIX . 'bien', $Bien);
        else:
            return $this->db->update(PREFIX . 'bien', $Bien);
		endif;		
	}
	
    /**
     * Marque un bien supprimer
     * @param int $bien_id
     * @return int
     */
    public function setDelete($bien_id){
        return $this->db->update(PREFIX . 'bien', array('delete' => 1, 'id' => $bien_id) );
    }
    
    /**
     * Transfere les biens d une agence à une autre
     * @param type $agence_depart
     * @param type $agence_destination
     * @return type
     */
    public function transfereToAgence($agence_depart, $agence_destination){
        return $this->db->update(PREFIX . 'bien', array('agence_id' => $agence_destination), array('agence_id =' => $agence_depart) );
    }
    
    public function getAllWhithParam($param){
        $this->db
            ->select('b.*, bc.name as categorie, u.identifiant, cl.libelle as transaction_type')
            ->from(PREFIX . 'bien b')
            ->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
            ->left_join(PREFIX . 'user u','b.add_by = u.id')
            ->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
            ->where(array('b.delete =' => 0));
            
        if( !is_null($param) && is_array($param) ):
            $this->db->where($param);
        endif;                

        $this->db->order('b.add_on DESC');
        
        return $this->db->get(); 
    }

    public function getSeuilHebdomadaire($param){

        return  $this->db
                    ->select('b.*, (SELECT COUNT(v.id) FROM va_visite v WHERE v.bien_id = b.id AND v.date_visite >= "'. $param['date_start'] .'" AND v.date_visite <= "'. $param['date_end'] .'") as nbVisite, bc.name as categorie, u.identifiant, cl.libelle as transaction_type, a.nom as agence')
                    ->from(PREFIX . 'bien b')
                    ->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
                    ->left_join(PREFIX . 'user u','b.add_by = u.id')
                    ->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
                    ->left_join(PREFIX . 'agence a','b.agence_id = a.id')
                    ->where( array('b.delete =' => 0) )
                    ->having( array('nbVisite <=' => $param['seuil']) )
                    ->order('b.add_on DESC')
                    ->get();

    }

    public function getSeuilMensuel($param){

        return  $this->db
                    ->select('b.*, (SELECT COUNT(v.id) FROM va_visite v WHERE v.bien_id = b.id AND v.date_visite LIKE "'. $param['date'] .'%" ) as nbVisite , bc.name as categorie, u.identifiant, cl.libelle as transaction_type, a.nom as agence')
                    ->from(PREFIX . 'bien b')
                    ->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
                    ->left_join(PREFIX . 'user u','b.add_by = u.id')
                    ->left_join(PREFIX . 'commun_liste cl','cl.value = b.transaction')
                    ->left_join(PREFIX . 'agence a','b.agence_id = a.id')
                    ->where( array('b.delete =' => 0) )
                    ->having( array('nbVisite <=' => $param['seuil']) )
                    ->order('b.add_on DESC')
                    ->get();

    }

}
