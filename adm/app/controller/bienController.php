<?php

class bienController extends Controller{
	
	/**
	 * Affiche la liste des biens dans la base de donnees
	 * @return html
	 */
	public function indexAction(){

        $Years = array();

        $start = date('Y') - 5;

        while($start <= date('Y')):
            $Years[$start] = $start;
            $start++;
        endwhile;

        $Months = array(
            '01'    =>  '01',
            '02'    =>  '02',
            '03'    =>  '03',
            '04'    =>  '04',
            '05'    =>  '05',
            '06'    =>  '06',
            '07'    =>  '07',
            '08'    =>  '08',
            '09'    =>  '09',
            '10'    =>  '10',
            '11'    =>  '11',
            '12'    =>  '12',
        );

		$NbBienPrint = 30;

		$this->load_manager('bien','admin');
        
        if( $this->app->Http->getExists('ref') ):
            # Recuperation du bien par sa reference
            $Biens = $this->manager->bien->getByRef($this->app->Http->get('ref'));
            $NbBiens = count($Biens);
        elseif( $this->app->Http->getExists('seuil_mensuel') ):
            # Recuperation des dates
            $year = $this->app->Http->get('year_seuil');
            $month = $this->app->Http->get('month_seuil');
            # Envoie de la requete
            $Biens = $this->manager->bien->getSeuilMensuel( array('date' => $year . '-' . $month .'-', 'seuil' => $this->app->config['bien_seuil_visite_mensuel']) );
            $NbBiens = count($Biens);
        elseif( $this->app->Http->getExists('seuil_hebdomadaire') ):
            # Recuperation de la date
            $Date = getSemaineData($this->app->Http->get('dayweek'));
            # Requete de recuperation de bien
            $Biens = $this->manager->bien->getSeuilHebdomadaire( array('date_start' => $Date['first_day_US'], 'date_end' => $Date['last_day_US'], 'seuil' => $this->app->config['bien_seuil_visite_hebdomadaire']) );
            # Envoie a smarty des infos date
            $this->app->smarty->assign('Date_infos', $Date);
            $NbBiens = count($Biens);
        else:
        	$NbBiens = $this->app->db->count(PREFIX . 'bien b', array('b.delete =' => 0));
            $Biens = $this->manager->bien->getAll($NbBienPrint, getOffset($NbBienPrint) );
        endif;		
		
        $Pagination = new Zebra_Pagination();
        $Pagination->records($NbBiens);
        $Pagination->records_per_page($NbBienPrint);

		$this->app->smarty->assign(array(
			'Biens'			=>	$Biens,
            'Years'         =>  $Years,
            'Months'        =>  $Months,
            'Pagination'    =>  $Pagination
		));

		return $this->app->smarty->fetch( VIEW_PATH . 'bien' . DS . 'index.tpl');
	}
	
	public function addAction(){
		
		if( $this->app->HTTPRequest->postExists('bien') ):
			$this->load_manager('bien','admin');
			$this->load_model('bien','admin');
            $this->load_model('bien_prix','admin');
			
			$Bien = new bien($this->registry->Http->post('bien'));
			
			if( $Bien->checkData() !== true):
                $this->tpl->assign('FlashMessage','Bien invalide');
				goto printform;
			endif;
			
            $Bien->prepareForSave();

			$Bien->id = $this->manager->bien->save($Bien);
            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $Bien->id, 'log' => 'Ajout du bien dans la base') );
            $Log->save();
			
			$this->savePhoto('photo1', $Bien->id);
			$this->savePhoto('photo2', $Bien->id);
			$this->savePhoto('photo3', $Bien->id);

            $prix = new bien_prix( array('bien_id' => $Bien->id, 'prix' => $Bien->prix) );
            $prix->save();

            isInDbCpVille($Bien->code_postal, $Bien->ville);
			
			return "<script>window.top.window.endUpload('ok');</script>";
		endif;
		
		// Affichage du formulaire
		printform:
		
		if( $this->app->HTTPRequest->postExists('bien') ):
			return "<script>window.top.window.endUpload('echec');</script>";
		endif;
		
        $this->load_manager('prospect');
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('bien');
		$this->load_manager('agence','admin');

		$this->getFormValidatorJs();
        $this->app->load_web_lib('chosen/chosen.css','css');
        $this->app->load_web_lib('chosen/chosen.jquery.min.js','js');
        $this->app->load_web_lib('markitup/skins/simple/style.css','css');
        $this->app->load_web_lib('markitup/sets/default/style.css','css');
        $this->app->load_web_lib('markitup/jquery.markitup.js','js');
        $this->app->load_web_lib('markitup/sets/default/set.js','js');

		$this->app->smarty->assign(array(
			'Categories'	=>	$this->manager->categorie->getAll(),
			'Agences'		=>	$this->manager->agence->getAll(),
			'DEP'			=>	$this->app->getListe('DEP'),
			'TRANS'			=>	$this->app->getListe('TRANS'),
            'Vendeurs'     =>  $this->manager->prospect->getVendeurs(),
            //'exclusif_select'   =>  $Helper->formSelect("array('label' => 'Explusif', 'name' => 'bien[exclusif]', 'lists' => 'yn', 'id' => "exclusif", 'value' => 0")),
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'bien' . DS . 'add.tpl');		
	}
    
    /**
     * Affiche et traite le formulaire d edition
     * @param type $bien_id
     * @return string
     */
    public function editAction($bien_id){
        
        $this->load_manager('bien','admin');
        $this->load_model('bien','admin');
               
        if( $this->app->HTTPRequest->postExists('bien') ):
            
			$Bien = new bien($this->app->HTTPRequest->postData('bien'));
			
			if( $Bien->checkData() !== true):
				goto printform;
			endif;
            
			$Bien->prepareForSave();

			$this->manager->bien->save($Bien);

            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $Bien->id, 'log' => 'Modification du bien') );
            $Log->save();
           
            isInDbCpVille($Bien->code_postal, $Bien->ville);

            # Verification si le prix a ete modifier
            if( $Bien->prix != $this->app->HTTPRequest->postData('old_prix') ):
                $this->load_model('bien_prix','admin');
                $prix = new bien_prix( array('bien_id' => $Bien->id, 'prix' => $Bien->prix) );
                $prix->save();
            endif;
           
			return "<script>window.top.window.endUpload('ok');</script>";
		endif;
        
        // Affichage du formulaire
		printform:
		
		if( $this->app->HTTPRequest->postExists('bien') ):
			return "<script>window.top.window.endUpload('echec');</script>";
		endif;

        $Bien = new bien($this->manager->bien->getById($bien_id));

        $this->load_manager('prospect','admin');
		$this->load_manager('categorie');
		$this->manager->categorie->setTable('bien');
		$this->load_manager('agence','admin');
		$this->getFormValidatorJs();
        $this->app->load_web_lib('chosen/chosen.css','css');
        $this->app->load_web_lib('chosen/chosen.jquery.min.js','js');
        $this->app->load_web_lib('markitup/skins/simple/style.css','css');
        $this->app->load_web_lib('markitup/sets/default/style.css','css');
        $this->app->load_web_lib('markitup/jquery.markitup.js','js');
        $this->app->load_web_lib('markitup/sets/default/set.js','js');
		
		$this->app->smarty->assign(array(
			'Categories'	=>	$this->manager->categorie->getAll(),
			'Agences'		=>	$this->manager->agence->getAll(),
			'DEP'			=>	$this->app->getListe('DEP'),
			'TRANS'			=>	$this->app->getListe('TRANS'),
            'Bien'          =>  new bien($this->manager->bien->getById($bien_id)),
            'Vendeurs'      =>  $this->manager->prospect->getVendeurs(),
            'Achateurs'     =>  $this->manager->prospect->getAcheteurs(),
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'bien' . DS . 'edit.tpl');
    }
    
    public function deleteAction($bien_id){
        
        $this->load_manager('bien','admin');
        
        $this->manager->bien->setDelete($bien_id);

        $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $Bien->id, 'log' => 'Suppression du bien') );
        $Log->save();
        
        return $this->redirect( getLinkAdm('bien'), 3, $this->lang['Bien_supprime'] );
        
    }
    
    public function addPhotoAction($bien_id){

        $this->savePhoto('photo1', $bien_id);
        $this->savePhoto('photo2', $bien_id);
        $this->savePhoto('photo3', $bien_id);

        return $this->redirect( getLinkAdm('bien/fiche/' . $bien_id), 3, 'Photos ajoutees');
    }

    public function photoDeleteAction($bien_id){
        
        @unlink(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $bien_id . DS . $this->app->HTTPRequest->getData('photo') );
        
        $this->app->smarty->assign(array(
           'bien_id'        =>  $bien_id,
           'Photos'         => getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $bien_id . DS),
        ));

        $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $bien_id, 'log' => 'Suppression de la photo : ' . $this->app->HTTPRequest->getData('photo')) );
        $Log->save();
        
        return $this->app->smarty->fetch( VIEW_PATH . 'bien' . DS . 'ajax_reload_photo_form_edit.tpl');
    }
	
    public function ficheAction($id){
        
        $this->load_manager('bien','admin');
        $this->load_model('bien','admin');
        $this->load_manager('prospect','admin');
        $this->load_manager('visite','admin');

        $this->app->load_web_lib('chosen/chosen.css','css');
        $this->app->load_web_lib('chosen/chosen.jquery.min.js','js');
        
        $Bien = new myObject($this->manager->bien->getById($id));
        
        $this->getFormValidatorJs();
        
        $this->app->smarty->assign(array(
            'Bien'      =>  $Bien,
            'Acheteurs' =>  $this->manager->prospect->getAcheteurs(),
            'Visites'   =>  $this->manager->visite->getByBienId($id),
            'Photos'    =>  getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $Bien->id . DS),
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'bien' . DS . 'fiche.tpl' );
    }
    
    public function visiteAddAction($bien_id){
        
        if( $this->app->HTTPRequest->postExists('visite') ):
            $Visite = $this->app->HTTPRequest->postData('visite');
            $Visite['date_visite'] = formatDateToMySql($Visite['date_visite']);
            $this->app->db->insert(PREFIX . 'visite', $Visite);
            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $bien_id, 'log' => 'Ajout d une visite') );
            $Log->save();
            return $this->redirect( getLinkAdm("bien/fiche/" . $bien_id), 3, $this->lang['Visite_ajoutee']);
        endif;
        
        return $this->ficheAction($bien_id);
        
    }

    public function ajaxGetDataForVenduByAgenceAction($bien_id){

    	# Recuperation de la liste des collab
    	$Colabs = $this->app->db->get(PREFIX . 'user', array('actif =' => 1), 'identifiant' );

    	# Prospect
    	$Prospects = $this->app->db->get(PREFIX . 'prospect', array('acheteur =' => 1),'nom, prenom');

    	# On assigne a smarty
    	$this->app->smarty->assign(array(
    		'Colabs'		=>	$Colabs,
    		'Prospects'		=>	$Prospects,
    	));

    	# Generation du code HTML et envoie
    	return $this->app->smarty->fetch( VIEW_PATH . 'bien' . DS . 'ajax_data_form_vendu_by_agence.tpl');
    }
    
    public function setVenduAction($bien_id){

    	if( !$this->app->HTTPRequest->postExists('bien') ):
    		return $this->indexAction();
    	endif;

    	$Bien = new myObject($this->app->HTTPRequest->postData('bien') );

    	$Bien->id = $bien_id;

    	if( $Bien->vendu == 1):
    		$Date_vendu = $this->app->HTTPRequest->postData('date_vente');

    		$Bien->vendu_on = FormatDateToTimestamp($Date_vendu);
    		$Bien->vendu_on_sql = FormatDateToMySql($Date_vendu);
    		$Bien->prix_vente = $this->app->HTTPRequest->postData('prix_vente');
    		$Bien->montant_frais_agence = $this->app->HTTPRequest->postData('montant_frais_agence');
    		$Bien->montant_com_vendeur = $this->app->HTTPRequest->postData('montant_com_vendeur');

            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $Bien->id, 'log' => 'Bien marque comme vendu') );
            $Log->save();

    	else:
    		$Bien->vendu_on = '';
    		$Bien->vendu_on_sql = '';
    		$Bien->vendu_by = '';
    		$Bien->vendu_by_agence = 0;
    		$Bien->acheteur_id = '';

            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $Bien->id, 'log' => 'Bien marque comme non vendu') );
            $Log->save();
    	endif;

    	$this->app->db->update(PREFIX . 'bien', $Bien, array('id =' => $Bien->id));

    	return $this->redirect( getLinkAdm('bien/fiche/'. $Bien->id),3, 'Information enregistrees' );

    }

    public function getHistoriqueAction($bien_id){

        # Recuperation de l historique et envoie via du JSON
        $Logs   =   $this->app->db->select('l.*, u.identifiant')
                    ->from(PREFIX . 'logs l')
                    ->left_join(PREFIX . 'user u','l.log_by = u.id')
                    ->where(array('model =' => 'bien', 'model_id =' => $bien_id))
                    ->order('l.log_on DESC')
                    ->get();

        return json_encode($Logs);
    }

    public function getPrixHistoriqueAction($bien_id){
        # Recuperation de l historique et envoie via du JSON
        $Logs   =   $this->app->db->select('bp.*')
                    ->from(PREFIX . 'bien_prix bp')
                    ->where(array('bien_id =' => $bien_id))
                    ->order('prix_on DESC')
                    ->get();

        return json_encode($Logs);
    }

	private function savePhoto($file, $bien_id){
		$Dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $bien_id;
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php';
		
		if( !is_dir($Dir) ):
			@mkdir($Dir);
		endif;
		
		$Image = new Upload($_FILES[''.$file.'']);
        if($Image->uploaded):
			$Image->allowed = 'image/*';
            $Image->file_overwrite = true;
            $Image->file_new_name_body  = microtime(true);
			$Image->image_resize          = true;
			$Image->image_ratio_y         = true;
			$Image->image_x               = 1024;
            $Image->process($Dir);

            $Log = new log( array('log_by' => $_SESSION['utilisateur']['id'], 'model' => 'bien', 'model_id' => $bien_id, 'log' => 'Ajout photo' ) );
            $Log->save();

		endif;
	}

}