<?php

class visiteManager extends BaseModel{
    
    /**
     * Recupere les visites d un bien en le nom/prenom du prospect et l identifiant utilisateur
     * @param int $bien_id
     * @return array
     */
    public function getByBienId($bien_id){
        return  $this->db
                    ->select('v.*, p.nom as p_nom, p.prenom as p_prenom, u.identifiant')
                    ->from(PREFIX . 'visite v')
                    ->left_join(PREFIX . 'prospect p','v.prospect_id = p.id')
                    ->left_join(PREFIX . 'user u','v.user_id = u.id')
                    ->where(array('bien_id =' => $bien_id))
                    ->order('v.date_visite DESC, v.heure_visite DESC')
                    ->get();
    }
    
    public function getFutureByUserId($user_id){
        return  $this->db
                    ->select('v.*, p.nom as p_nom, p.prenom as p_prenom, u.identifiant, vug.g_id')
                    ->from(PREFIX . 'visite v')
                    ->left_join(PREFIX . 'prospect p','v.prospect_id = p.id')
                    ->left_join(PREFIX . 'user u','v.user_id = u.id')
                    ->left_join(PREFIX . 'visite_user_gcalendar vug','vug.visite_id = v.id')
                    ->where(array('v.user_id =' => $user_id, 'v.date_visite >=' => ''. date('Y') . '-'. date('m') . '-'. date('d')))
                    ->order('v.date_visite DESC, v.heure_visite DESC')
                    ->get();
    }
    
    public function getFuture(){
        return  $this->db
                    ->select('v.*, p.nom as p_nom, p.prenom as p_prenom, u.identifiant')
                    ->from(PREFIX . 'visite v')
                    ->left_join(PREFIX . 'prospect p','v.prospect_id = p.id')
                    ->left_join(PREFIX . 'user u','v.user_id = u.id')
                    ->where(array('v.date_visite >=' => ''. date('Y') . '-'. date('m') . '-'. date('d')))
                    ->order('v.date_visite DESC, v.heure_visite DESC')
                    ->get();
    }
    
    public function getById($id){
        return  $this->db
                    ->select('v.*, p.nom as p_nom, p.prenom as p_prenom, u.identifiant, b.nom as bien, b.reference as b_reference')
                    ->from(PREFIX . 'visite v')
                    ->left_join(PREFIX . 'prospect p','v.prospect_id = p.id')
                    ->left_join(PREFIX . 'user u','v.user_id = u.id')
                    ->left_join(PREFIX . 'bien b','v.bien_id = b.id')
                    ->where(array('v.id =' => $id))
                    ->order('v.date_visite DESC, v.heure_visite DESC')
                    ->get_one();
    }
    
    public function getByProspectId($prospect_id){
        return  $this->db
                    ->select('v.*, p.nom as p_nom, p.prenom as p_prenom, u.identifiant, b.nom as bien, b.reference')
                    ->from(PREFIX . 'visite v')
                    ->left_join(PREFIX . 'prospect p','v.prospect_id = p.id')
                    ->left_join(PREFIX . 'user u','v.user_id = u.id')
                    ->left_join(PREFIX . 'bien b','v.bien_id = b.id')
                    ->where(array('v.prospect_id =' => $prospect_id))
                    ->order('v.date_visite DESC, v.heure_visite DESC')
                    ->get();
    }
    
    public function getNbVisiteByMonth($date){
        
        $Tmp =  $this->db
                    ->select('COUNT(id) as nb_visite')
                    ->from(PREFIX . 'visite')
                    ->where_free("date_visite LIKE '".$date."%' ")
                    ->get_one();
        
        return $Tmp['nb_visite'];
    }
    
    public function getByMonthAndYear($date){
        return  $this->db
                    ->select('v.*, p.nom as p_nom, p.prenom as p_prenom, u.identifiant, b.reference')
                    ->from(PREFIX . 'visite v')
                    ->left_join(PREFIX . 'prospect p','v.prospect_id = p.id')
                    ->left_join(PREFIX . 'user u','v.user_id = u.id')
                    ->left_join(PREFIX . 'bien b','v.bien_id = b.id')
                    ->where_free("v.date_visite LIKE '".$date."%' ")
                    ->order('v.date_visite DESC, v.heure_visite ASC')
                    ->get();
    }
}