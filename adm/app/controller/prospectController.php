<?php
/**
 * @description : Appel des page actions sur les prospects
 * @autor : Drouche Romain
 */
class prospectController extends Controller{
    
    /**
     * Affiche la liste des prospects non supprimé
     * @return type
     */
    public function indexAction(){
        $Param = array();

        $this->load_manager('prospect','admin');
        $this->load_manager('agence','admin');

        if( $this->app->HTTPRequest->getExists('filtre') ):
            
            $Filtres = $this->app->HTTPRequest->getData('filtre');

            foreach( $Filtres as $k => $v):
                if( !empty($v) ):
                    $Param['p.' . $k .'='] = $v;
                endif;
            endforeach;

        endif;
        
        $NbProspects = $this->app->db->count(PREFIX . 'prospect p', array('p.delete =' => 0));
        
        $Prospects = $this->manager->prospect->getAll( array_merge($Param ,array('p.delete =' => 0)), 20, getOffset(20));
        
        $this->app->smarty->assign(array( 
            'Prospects'     =>  $Prospects,
            'Pagination'    =>  $NbProspects > 1 ? getPagination( array('perPage'=>20, 'fileName'=> getLinkAdm('prospect') . '?page=%d', 'totalItems'=>$NbProspects) ) : '',
            'Agences'       =>  $this->manager->agence->getAll(),
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'prospect' . DS . 'index.tpl');
    }
    
    /**
     * Affiche la fiche d un prospect
     * @param type $id
     * @return type
     */
    public function ficheAction($id){
        $this->load_manager('prospect');
        $this->load_manager('visite');
        
        $Prospect = $this->manager->prospect->getById($id);
        
        if( !empty($Prospect['criteres']) ):
            $Prospect['criteres'] = unserialize($Prospect['criteres']);            
            // Recuperation de la catégorie de bien recherche
            $Prospect['criteres']['categorie_name'] = $this->app->db->get_one(PREFIX . 'bien_categorie', array('id =' => $Prospect['criteres']['categorie']));
        endif;
        
        $Visites = $this->manager->visite->getByProspectId($id);
        
        $this->app->smarty->assign(array(
            'Prospect'      =>  $Prospect, 
            'Visites'       =>  $Visites,
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'prospect' . DS . 'fiche.tpl');
    }
    
    /**
     * Formulaire et traitement d ajout un prospect
     * @return type
     */
    public function addAction(){
        
        if( $this->app->HTTPRequest->postExists('prospect') ):
            
            $Prospect = $this->app->HTTPRequest->postData('prospect');
            
            $Prospect['delete'] = 0;
            $Prospect['add_on'] = time();
            $Prospect['edit_on'] = time();
            $Prospect['add_by'] = $_SESSION['utilisateur']['id'];
            $Prospect['edit_by'] = $_SESSION['utilisateur']['id'];
            
            if( isset($Prospect['vendeur']) ):
                $Prospect['vendeur'] = 1;
            else:
                $Prospect['vendeur'] = 0;
            endif;
            
            if( isset($Prospect['acheteur']) ):
                $Prospect['acheteur'] = 1;
            else:
                $Prospect['acheteur'] = 0;
            endif;
            
            # Formatage des donnees
            $Prospect['criteres'] = serialize($_POST['criteres']);
            $Prospect['add_on_sql'] = date("Y-m-d");
            $Prospect['edit_on_sql'] = date("Y-m-d");
            
            # Enregistrement dans la base
            $Prospect['id'] = $this->app->db->insert(PREFIX . 'prospect', $Prospect);

            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'prospect', 'model_id' => $Prospect['id'], 'log' => 'Ajout du prospect dans la base.') );
            $Log->save();

            return $this->redirect(getLinkAdm('prospect/fiche/' . $Prospect['id']),3,$this->lang['Prospect_enregistre']);
            
        endif;
        $this->load_manager('agence');
        $this->getFormValidatorJs();
        
        $this->app->smarty->assign(array( 
            'Categories'    =>  $this->app->db->get(PREFIX . 'bien_categorie', array('level =' => 0), 'name'),
            'Agences'       =>  $this->manager->agence->getAll(),
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'prospect' . DS . 'add.tpl');
    }
    
    /**
     * Formulaire et traiement du formulaire d edition
     * @param type $id
     * @return type
     */
    public function editAction($id){
        if( $this->app->HTTPRequest->postExists('prospect') ):
            
            $Prospect = $this->app->HTTPRequest->postData('prospect');
            
            $Prospect['add_by'] = $_SESSION['utilisateur']['id'];
            $Prospect['edit_by'] = $_SESSION['utilisateur']['id'];
            
            if( isset($Prospect['vendeur']) ):
                $Prospect['vendeur'] = 1;
            else:
                $Prospect['vendeur'] = 0;
            endif;
            
            if( isset($Prospect['acheteur']) ):
                $Prospect['acheteur'] = 1;
            else:
                $Prospect['acheteur'] = 0;
            endif;
            
            $Prospect['criteres'] = serialize($_POST['criteres']);
            $Prospect['edit_on_sql'] = date("Y-m-d");


            # Enregistrement dans la base
            $this->app->db->update(PREFIX . 'prospect', $Prospect);

            # Log
            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'prospect', 'model_id' => $Prospect['id'], 'log' => 'Edition du prospect.') );
            $Log->save();
            
            return $this->redirect(getLinkAdm('prospect/fiche/' . $Prospect['id']),3,$this->lang['Prospect_enregistre']);
            
        endif;
        $this->load_manager('agence');
        $this->getFormValidatorJs();
        
        $Prospect = $this->app->db->get_one(PREFIX . 'prospect', array('id =' => $id));
        $Prospect['criteres'] = unserialize($Prospect['criteres']);
        
        $this->app->smarty->assign(array(
            'Prospect'      =>  $Prospect,
            'Categories'    =>  $this->app->db->get(PREFIX . 'bien_categorie', array('level =' => 0), 'name'),
            'Agences'       =>  $this->manager->agence->getAll(),
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'prospect' . DS . 'edit.tpl');
    }
    
    /**
     * Gere a la corbeille d une annonce
     * @param type $id
     * @return type
     */
    public function deleteAction($id){
        $this->app->db->update(PREFIX . 'prospect', array('delete' => 1), array('id =' => $id));

        # Log
        $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'prospect', 'model_id' => $Prospect['id'], 'log' => 'Suppression du prospect.') );
        $Log->save();

        return $this->redirect(getLinkAdm('prospect'), 3, $this->lang['Prospect_supprime']);
    }
    
    /**
     * Retourne une liste de bien en fonction des criteres de recherche du prospect
     * @param type $prospect_id
     */
    public function ajaxFindBiensAction($prospect_id){
        $this->load_manager('prospect');
        
        $Prospect = $this->manager->prospect->getById($prospect_id);
        
        if( !empty($Prospect['criteres']) ):
            $Criteres = unserialize($Prospect['criteres']);
        else:
            return "Need more criteres !";
        endif;
        
        $Param = array();
              
        $Param['transaction ='] = 'vente';                    

            
        if( !empty($Criteres['categorie']) && is_numeric($Criteres['categorie']) ):
            $Param['b.categorie_id ='] = $Criteres['categorie'];
        endif;
            
        if( !empty($Criteres['prix_max']) && is_numeric($Criteres['prix_max']) ):
           $Param['b.prix <='] = $Criteres['prix_max'];
        endif;
            
        if( !empty($Criteres['piece']) ):
            $Param['b.piece ='] = $Criteres['piece'];
        endif;
        
        if( !empty($Criteres['chambre']) ):
            $Param['b.chambre ='] = $Criteres['chambre'];
        endif;
        
        if( !empty($Criteres['ville']) ):
            $Param['b.ville ='] = $Criteres['ville'];
        endif;
        
        if( !empty($Criteres['departement']) && empty($Criteres['ville'])):
            $Param['b.code_postal LIKE '] = ''.$Criteres['departement'].'%';
        endif;
        
        $this->load_manager('bien','admin');
        
        $Biens = $this->manager->bien->getAllWhithParam($Param);
        
        $this->app->smarty->assign(array(
           'Biens'      =>  $Biens, 
        ));

        # Log
        $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'prospect', 'model_id' => $Prospect['id'], 'log' => 'Recherche de bien pouvant intereser le prospect. La recherche a retourne '. count($Biens) .'') );
        $Log->save();
        
        return $this->app->smarty->fetch( VIEW_PATH . 'prospect' . DS . 'ajax_find_biens.tpl');
    }
    
    public function ajaxSearchByNomAction($Nom){
        $this->load_manager('prospect','admin');
        
        if(!empty($Nom)):
            $Prospects = $this->manager->prospect->searchByNom($Nom);
        else:
            $Prospects = $this->manager->prospect->getAll(array('p.delete =' => 0));
        endif;
            
        
        $this->app->smarty->assign(array(
            'Prospects'     =>  $Prospects,
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'prospect' . DS . 'ajax_search_by_nom.tpl');
    }

    /**
    *   Recupere l'historique dans la base
    *   @param int $prospect_id
    *   @return json liste des suivis encode en JSON
    */
    public function getHistoriqueAction($prospect_id){

        # Recuperation de l historique et envoie via du JSON
        $Logs   =   $this->app->db->select('l.*, u.identifiant')
                    ->from(PREFIX . 'logs l')
                    ->left_join(PREFIX . 'user u','l.log_by = u.id')
                    ->where(array('model =' => 'prospect', 'model_id =' => $prospect_id))
                    ->order('l.log_on DESC')
                    ->get();

        return json_encode($Logs);
    }

    /**
    *   Recupere les suivis dans la base
    *   @param int $prospect_id
    *   @return json liste des suivis encode en JSON
    */
    public function getSuiviAction($prospect_id){

        $Suivis =   $this->app->db->select('ps.*, u.identifiant')
                        ->from(PREFIX . 'prospect_suivi ps')
                        ->left_join(PREFIX . 'user u','ps.user_id = u.id')
                        ->where(array('prospect_id =' => $prospect_id))
                        ->order('ps.add_on DESC')
                        ->get();

        return json_encode($Suivis);
    }  

    /**
    *   Recupere les biens dans la base si le prospects est vendeur et retourne le resultat
    *   en json
    *   @param int $prospect_id
    *   @return json
    */
    public function getBiensAction($prospect_id){
        $this->load_manager('bien','admin');

        $Biens = $this->manager->bien->getAllWhithParam( array('vendeur_id =' => $prospect_id) );

        return json_encode($Biens);
    }  

    public function suiviAddAction($prospect_id){
        $this->load_model('prospect_suivi');

        $Suivi = new prospect_suivi($this->app->HTTPRequest->postData('suivi') );
        $Suivi->user_id = $_SESSION['utilisateur']['id'];
        $Suivi->prospect_id = $prospect_id;
        $Suivi->id = $Suivi->save();

        # Log
        $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'prospect', 'model_id' => $prospect_id, 'log' => 'Ajout d un suivi #'. $Suivi->id) );
        $Log->save();

        # redirection de l utilisateur
        return $this->redirect( getLinkAdm('prospect/fiche/'. $prospect_id),3, 'Suivi ajoute' );
    }

    public function suiviDeleteAction($suivi_id){
        $prospect_id = $this->app->HTTPRequest->getData('prospect_id');

        $this->app->db->delete(PREFIX . 'prospect_suivi', null, array('id =' => $suivi_id, 'prospect_id =' => $prospect_id) );

        # Log
        $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'prospect', 'model_id' => $prospect_id, 'log' => 'Suppression du suivi #'. $suivi_id) );
        $Log->save();

        # redirection de l utilisateur
        return $this->redirect( getLinkAdm('prospect/fiche/'. $prospect_id),3, 'Suivi supprime' );
    }

}