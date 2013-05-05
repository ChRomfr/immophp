<?php

class agenceController extends Controller{
	
	public function indexAction(){
		
		$this->load_manager('agence');
		
		$Agences = $this->manager->agence->getAll();
		
		$this->app->smarty->assign(array(
			'Agences'		=>	$Agences,
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'agence' . DS . 'index.tpl');
	}
	
	
	public function addAction(){
		
		if( $this->app->HTTPRequest->postExists('agence') ):
			
			$this->load_model('agence','admin');
			//$this->load_manager('agence','admin');
			
			$Agence = new agence( $this->app->HTTPRequest->postData('agence') );
			
			if($Agence->checkData() !== true):
				goto printform;
			endif;
			
			$Agence->id = $Agence->save();
			
			// Traitement de la photo
			$Agence->savePhoto();
			
			$Agence->save();
			
			return $this->redirect( getLinkAdm('agence'), 3, $this->lang['Agence_enregistree']);
		endif;
		
		printform:
		
		$this->load_manager('utilisateur','admin');
			
		$this->getFormValidatorJs();
		
		$this->app->smarty->assign(array(
			'Utilisateurs'		=>	$this->manager->utilisateur->getAll(),
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'agence' . DS . 'add.tpl');
		
	}
	
    public function deleteAction($agence_id){
        
        $this->load_manager('agence','admin');
        
        if( $this->app->HTTPRequest->postExists('agence') ):
            $Agence = $this->app->HTTPRequest->postData('agence');
            $this->load_manager('bien','admin');
            $this->manager->bien->transfereToAgence($agence_id, $Agence['agence_id_remplace']);
            $this->manager->agence->delete($agence_id);
            return $this->redirect( getLinkAdm('agence'), 3, $this->lang['Agence_supprimee']);
        endif;
        
        $this->getFormValidatorJs();
        
        $NbAgence = $this->app->db->count(PREFIX . 'agence');
        
        $this->app->smarty->assign(array(
           'NbAgence'       =>  $NbAgence,
           'Agences'        =>  $this->manager->agence->getAllExludeById($agence_id),
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'agence' . DS . 'delete.tpl');
    }
    
    public function editAction($agence_id){
        
        $this->load_model('agence','admin');
		$this->load_manager('agence','admin');
        
        if( $this->app->HTTPRequest->postExists('agence') ):			
			
			$Agence = new agence( $this->app->HTTPRequest->postData('agence') );
			
			if($Agence->checkData() !== true):
				goto printform;
			endif;
			
			// Traitement de la photo
			$Agence->savePhoto();
			
			$Agence->save();
			
			return $this->redirect( getLinkAdm('agence'), 3, $this->lang['Agence_enregistree']);
		endif;
		
		printform:
		
		$this->load_manager('utilisateur','admin');
			
		$this->getFormValidatorJs();
		
		$this->app->smarty->assign(array(
			'Utilisateurs'		=>	$this->manager->utilisateur->getAll(),
            'Agence'            =>  $this->manager->agence->getById($agence_id),
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'agence' . DS . 'edit.tpl');
    }
    

    public function detailAction($id){

    	$date_start = date('Y') . '-' . date('m') . '-01';
        $date_end = date('Y') . '-' . date('m') . '-' . date('d');
        
    	$this->load_manager('agence','admin');

    	$Agence = new myObject( $this->manager->agence->getByid($id) );
    	$NbBiens = $this->app->db->count(PREFIX . 'bien b', array('agence_id =' => $Agence->id, 'b.delete =' => 0));

    	$NbBienVenduMois = $this->app->db->count(PREFIX . 'bien b', array('b.agence_id =' => $Agence->id,  'b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end));
        $NbBienSaisieMois = $this->app->db->count(PREFIX . 'bien b', array('b.agence_id =' => $Agence->id,'b.delete =' => 0, 'b.add_on_sql >=' => $date_start, 'b.add_on_sql <=' => $date_end));

        $Tmp = $this->app->db->select('SUM(prix_vente) as total_vente')->from(PREFIX . 'bien b')->where( array('b.agence_id =' => $Agence->id, 'b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end) )->get_one();
        $TotalVente = $Tmp['total_vente'];

        $Tmp = $this->app->db->select('SUM(montant_frais_agence) as total_frais_agence')->from(PREFIX . 'bien b')->where( array('b.agence_id =' => $Agence->id, 'b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end) )->get_one();
        $TotalFraisAgence = $Tmp['total_frais_agence'];

        $Tmp = $this->app->db->select('SUM(montant_com_vendeur) as total_com_vendeur')->from(PREFIX . 'bien b')->where( array('b.agence_id =' => $Agence->id, 'b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end) )->get_one();
        $TotalComVendeur = $Tmp['total_com_vendeur'];

    	# Envoie a smarty des donnees
    	$this->app->smarty->assign(array(
    		'Agence'			=>	$Agence,
    		'NbBiens'			=>	$NbBiens,
    		'NbBienVenduMois'   =>  $NbBienVenduMois,
            'NbBienSaisieMois'  =>  $NbBienSaisieMois,
            'TotalVente'        =>  $TotalVente,
            'TotalFraisAgence'  =>  $TotalFraisAgence,
            'TotalComVendeur'   =>  $TotalComVendeur,
    	));

    	# Generation
    	return $this->app->smarty->fetch( VIEW_PATH . 'agence' . DS . 'detail.tpl');
    }

    /**
    *	Recupere la liste des biens d'une agence
    *	@param @int $agence_id
    *	@return json 
    */
    public function getBiensAction($agence_id){
    	$this->load_manager('bien','admin');
    	$Biens = $this->manager->bien->getAllWhithParam( array('b.agence_id =' => $agence_id) );
    	return json_encode($Biens);
    }

    public function getProspectsAction($agence_id){
    	$this->load_manager('prospect','admin');
    	$Prospects = $this->manager->prospect->getAll(array('p.agence_id =' => $agence_id));
    	return json_encode($Prospects);
    }

    public function getUtilisateursAction($agence_id){
    	$Utilisateurs 	= $this->app->db
    						->select('*')
    						->from(PREFIX . 'user')
    						->where(array('agence_id =' => $agence_id))
    						->get();

		return json_encode($Utilisateurs);
    }
}