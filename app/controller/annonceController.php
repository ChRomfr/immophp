<?php

class annonceController extends Controller{
    
    /**
    *   Affiche la liste des annonces, plusieurs criteres de tri peuvent etre passe,
    *   Plusieurs Parametres peuvent etre passer par @var $_GET
    *   @return string Code HTML de la page
    */
    public function indexAction(){
        # Init de var de prix
        $Param = null;
        $Order = 'b.add_on DESC';

        # On traite les parametre d ordre
        if( $this->app->HTTPRequest->getExists('order') ):
            $Order = $this->app->HTTPRequest->getData('order');
            
            switch ($Order):
                case 'pc':
                    $Order = 'b.prix ASC';
                    break;

                case 'pd':
                    $Order = 'b.prix DESC';
                    break;

                case 'dc':
                    $Order = 'b.add_on ASC';
                    break;

                default:
                    $Order = 'b.add_on DESC';
                    break;

            endswitch;
        endif;

        # On recupere les parametres de recherche
        if( $this->app->HTTPRequest->getExists('criteres') ):
            $Param = $this->getParamSearch( $this->app->HTTPRequest->getData('criteres') );

            # Construction lien pour XML
            $xml_param = null;
            foreach($this->app->HTTPRequest->getData('criteres') as $k => $v):
                $xml_param .= '&amp;criteres['. $k .']='.$v;
            endforeach;
           $this->app->smarty->assign('xml_param',$xml_param);
        endif;
        
        # On charge le manager
        $this->load_manager('bien');
        
        # On compte le nombre d annonce que peut non retourner la requete avec les criteres
        $NbAnnoncesInDb = $this->manager->bien->count($Param);
        
        # On recupere les annonces et on traite la pagination si necesaire
        if( $this->app->config['annonce_per_page'] < $NbAnnoncesInDb ):
           $Biens = $this->manager->bien->getAll($Param, $Order, $this->app->config['annonce_per_page'], getOffset($this->app->config['annonce_per_page']));
            $url_pagination = $this->app->config['url'] . $this->app->config['url_dir'] . str_replace('/'.$this->app->config['url_dir'],'' , $_SERVER['REQUEST_URI']);
        else:
            $Biens = $this->manager->bien->getAll($Param, $Order);            
        endif;    
        
        # On recupere la photos des annonces
        $i=0;
        foreach( $Biens as $Bien):
            $Biens[$i]['photos'] = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $Bien['id']);
            $y=1;
            foreach ($Biens[$i]['photos'] as $k => $v):
               $Biens[$i]['photo'] = $v; 
               if( $y == 1):
                   break;
               endif;
            endforeach;         
            $i++;
        endforeach;
        
        # Envoie a smarty des vars
        $this->app->smarty->assign(array(
            'ctitre'        =>  $this->lang['Annonces'],
            'Annonces'      =>  $Biens,
            'Pagination'    =>  $NbAnnoncesInDb > $this->app->config['annonce_per_page']  ? getPagination( array('perPage'=>$this->app->config['annonce_per_page'] , 'fileName'=>$url_pagination . '&page=%d', 'totalItems'=>$NbAnnoncesInDb) ) : '',
        ));
        
        # On genere le template
        return $this->app->smarty->fetch(VIEW_PATH . 'annonce' . DS . 'index.tpl');
    }
    
    public function detailAction($annonce_id){

        $this->load_manager('bien');  

        if( $annonce_id == 'ID' ):
            $Tmp = $this->manager->bien->getAll(null,'b.add_on DESC', '1');
            $annonce_id = $Tmp[0]['id'];
        endif;

        $Bien = new myObject($this->manager->bien->getById($annonce_id));

        # Update du compteur
        $this->app->db->update(PREFIX . 'bien', array('view' => $Bien->view+1), array('id =' => $Bien->id) );
        
        $Bien->photos = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $Bien['id']);

        if( empty($Bien->video_code) ):
            $y=1;
            foreach ($Bien['photos'] as $k => $v):
               $Bien->photo = $v; 
               if( $y == 1):
                   break;
               endif;
            endforeach;
        endif;
        
        $this->getFormValidatorJs();
        
        $this->app->smarty->assign(array(
            'ctitre'                =>  $Bien['nom'],
            'Annonce'               =>  $Bien,
            'Description_this_page' =>  $Bien['description'],
        ));
        
        if( $this->app->HTTPRequest->getExists('print') ):
            return $this->app->smarty->fetch(VIEW_PATH . 'annonce' . DS . 'detail_print.tpl');
        endif;
        
        return $this->app->smarty->fetch(VIEW_PATH . 'annonce' . DS . 'detail.tpl');
    }
    
    public function contactAction($bien_id){
        
        if( $this->app->HTTPRequest->postExists('contact') ):
            // Recuperation des donnees envoyer
            $Contact = $this->app->HTTPRequest->postData('contact');
            
            // Verification que tout les champs sont remplis
            if( empty($Contact['nom']) || empty($Contact['telephone']) || empty($Contact['email']) || empty($Contact['message']) ):
                return $this->detailAction($bien_id);
            endif;
            
            // Securation des donnees
            $Contact['nom'] = htmlentities($Contact['nom']);
            $Contact['telephone'] = htmlentities($Contact['telephone']);
            $Contact['message'] = htmlentities($Contact['message']);
            $Contact['ip_visiteur'] = $_SERVER['REMOTE_ADDR'];
            $Contact['add_on'] = time();
            $Contact['bien_id'] = $bien_id;
            $Contact['read'] = 0;
            
            // Enregistrement dans la base
            $this->app->db->insert(PREFIX . 'bien_contact',$Contact);
            
            // Recuperation email agence pour envoie
            $this->load_manager('agence');
            $Agence = $this->manager->agence->getEmailByBienId($bien_id);
            
            if( !empty($Agence) && !empty($Agence['email']) ):
                // Envoie notification et message à la boite mail de l'agence
                $this->load_manager('bien');
                $Bien = $this->manager->bien->getById($bien_id);
                if( !empty($Bien) ):
                    sendEmail($Agence['email'], $Contact['email'], 'Contact bien : ' . $Bien['nom'], $Contact['message'],nl2br($Contact['message']));
                endif;
            endif;
            
            // On redirige l utilisateur une fois le mail envoyer
            return $this->redirect( getLink('annonce/detail/'. $bien_id .'/'. urlencode($Bien['nom'])),3, $this->lang['Message_envoye']);
            
        endif;
        
        return $this->indexAction();
    }

    /**
    *   Genere une carte avec les villes ou sont les annonces
    *
    */
    public function carteAction(){

        $Param = null;
        
        if( $this->app->HTTPRequest->getExists('criteres') ):
            $Param = $this->getParamSearch( $this->app->HTTPRequest->getData('criteres') );         
        endif;

        $Param['b.delete ='] = 0;
        $Param['b.visible ='] = 1;

        $this->load_manager('bien');  

        # Recuperation des villes/cp et du nombres d'annonces
        $Result =   $this->app->db
                        ->select('ville, code_postal, COUNT(id)')
                        ->from(PREFIX . 'bien b')
                        ->where($Param)
                        ->group_by('ville')
                        ->get();       
  
                
        // Generation de la carte
        $Carte = $this->generateCarte($Result);

        $this->app->smarty->assign(array(
            'Carte'         =>  $Carte->getGoogleMap(),
            'Agences'       =>  $this->app->db->get(PREFIX . 'agence',null,'nom'),
            'Categories'    =>  $this->app->db->get(PREFIX . 'bien_categorie', array('level =' => 0), 'name')
        ));

        return $this->app->smarty->fetch( VIEW_PATH . 'annonce' . DS . 'carte.tpl');
    }

    public function pdfAction($bien_id){

        require ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'mpdf' . DS . 'mpdf.php';
        $CSS = file_get_contents(ROOT_PATH . 'themes' . DS . 'bootstrap' . DS . 'css' . DS . 'bootstrap.css');

        $this->load_manager('bien');

        $Bien = new myObject($this->manager->bien->getById($bien_id));

        # Envoie des donnees a smarty
        $this->app->smarty->assign('Bien',$Bien);

        $Bien->photos = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $Bien['id']);

        $y=1;
        foreach ($Bien->photos as $k => $v):
           $Bien->photo = $v; 
           if( $y == 1):
               break;
           endif;
        endforeach;

        # Generation du template        
        $html = $this->app->smarty->fetch( VIEW_PATH . 'annonce' . DS . 'pdf.tpl');
    
        $pdf = new mpdf();
        //$pdf->debug = true;
        $pdf->SetHeader($this->app->config['titre_site']);
        $pdf->SetFooter($this->app->config['url'] . $this->app->config['url_dir'] . 'annonce/detail/' . $Bien->id);
        $pdf->WriteHTML($CSS,1);
        $pdf->WriteHTML($html,2);
        $pdf->Output();
        exit;
    }

    private function getParamSearch($Criteres){

        $Param = array();

        if( isset($Criteres['transaction']) || !empty($Criteres['transaction']) ):
                $Param['transaction ='] = $Criteres['transaction'];
        endif;            
        
        if( !empty($Criteres['agence']) && is_numeric($Criteres['agence']) ):
            $Param['b.agence_id ='] = $Criteres['agence'];
        endif;
        
        if( !empty($Criteres['categorie']) && is_numeric($Criteres['categorie']) ):
            $Param['b.categorie_id ='] = $Criteres['categorie'];
        endif;
        
        if( !empty($Criteres['prix_min']) && is_numeric($Criteres['prix_min']) ):
            $Param['b.prix >='] = $Criteres['prix_min'];
        endif;
        
         if( !empty($Criteres['prix_max']) && is_numeric($Criteres['prix_max']) ):
            $Param['b.prix <='] = $Criteres['prix_max'];
        endif;
        
        if( !empty($Criteres['surface_min']) && is_numeric($Criteres['surface_min']) ):
            $Param['b.surface >='] = $Criteres['surface_min'];
        endif;
        
         if( !empty($Criteres['surface_max']) && is_numeric($Criteres['surface_max']) ):
            $Param['b.surface <='] = $Criteres['surface_max'];
        endif;

        if( !empty($Criteres['code_postal']) && is_numeric($Criteres['code_postal']) ):
            $Param['b.code_postal ='] = $Criteres['code_postal'];
        endif;
        

        return $Param;
    }

    /**
    *   genere une carte avec les annonces retournees
    *   @param array $Annonces
    *   @return object $gmap
    */
    private function generateCarte($Rows){

        require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'GoogleMapAPIv3.class.php';

        $gmap = new GoogleMapApi();
        $gmap->setLang('fr');
        $gmap->setSize('700px;', '400px;');
        $gmap->setZoom(5);
        $gmap->setIconSize(25, 25);
        
        foreach( $Rows as $Row ):
            $linkDetail = getLink('annonce?criteres[code_postal]='. $Row['code_postal']);

            $htmlicone = $Row['ville'] . '<small>('. $Row['code_postal'] .')</small><br/><br/><a href=\''.$linkDetail .'\'>Voir les annonces</a>';
        
            // Ajout du lieu par adresse
            $coord = $gmap->geocoding($Row['code_postal'] . ' ' . $Row['ville']);
            $gmap->addMarkerByCoords($coord[2], $coord[3],$htmlicone  , $htmlicone, '');
            
        endforeach;
        
        $gmap->generate();
        
        return $gmap;

    }
}