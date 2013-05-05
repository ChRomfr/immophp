<?php

class agenceController extends Controller{

    public function indexAction(){

        $this->load_manager('agence');

        $Agences = $this->manager->agence->getAll();

        $Carte = $this->getMapAgences( $Agences );

        # Recuperation des photos
       /* $i=0;
        foreach($Agences as $Agence):
            $Tmp = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'agence' . DS . $Agence['id']);
            if(count($Tmp) > 0):
                foreach($Tmp as $k => $v):
                    $Agences[$i]['photo'] = $v;
                    break;
                endforeach;
            else:
                $Agences[$i]['photo'] = null;
            endif;
            $i++;
        endforeach;
*/
        $this->app->smarty->assign(array(
            'Agences'       =>  $Agences,
            'ctitre'        =>  $this->lang['Agences'],
            'CarteAgence'   =>  $Carte->getGoogleMap(),
        ));

        return $this->app->smarty->fetch( VIEW_PATH . 'agence' . DS . 'index.tpl' );
    }
    
    public function detailAction($id){
        $this->load_manager('agence');
        $this->load_manager('bien');
        
        $Agence = $this->manager->agence->getById($id);
        
        // Recuperation photos agence
        /*$Tmp = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'agence' . DS . $id);
        if(count($Tmp) > 0):
            foreach($Tmp as $k => $v):
                $Agence['photo'] = $v;
                break;
            endforeach;
        else:
            $Agence['photo'] = null;
        endif;
        */
        // Generation de la carte google
        if( !$CarteAgence = $this->app->cache->get('agence_detail_carte_' . $id) ):
            $Map = $this->getMapAgence($Agence);
            $CarteAgence = $Map->getGoogleMap();
            $this->app->cache->save($CarteAgence);
        endif;

        
        $Biens = $this->manager->bien->getAll(array('b.agence_id =' => $id), 'b.add_on DESC', 3 );
        
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
        
        $this->app->smarty->assign(array(
            'Agence'                =>  $Agence,
            'ctitre'                =>  $Agence['nom'],
            'Map'                   =>  $CarteAgence,
            'Annonces'              =>  $Biens,
            'Description_this_page' =>  $Agence['description']
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'agence' . DS . 'detail.tpl' );
    }
    
    public function contactAction($agence_id){
        
        if( $this->app->HTTPRequest->postExists('contact') ):
            // Recuperation des donnees envoyer
            $Contact = $this->app->HTTPRequest->postData('contact');
            
            // Verification que tout les champs sont remplis
            if( empty($Contact['nom']) || empty($Contact['telephone']) || empty($Contact['email']) || empty($Contact['message']) ):
                return $this->detailAction($agence_id);
            endif;
            
            // Securation des donnees
            $Contact['nom'] = htmlentities($Contact['nom']);
            $Contact['telephone'] = htmlentities($Contact['telephone']);
            $Contact['message'] = htmlentities($Contact['message']);
            $Contact['ip_visiteur'] = $_SERVER['REMOTE_ADDR'];
            $Contact['add_on'] = time();
            $Contact['agence_id'] = $agence_id;
            $Contact['read'] = 0;
            
            // Enregistrement dans la base
            $this->app->db->insert(PREFIX . 'agence_contact',$Contact);
            
            // Recuperation email agence pour envoie
            $this->load_manager('agence');
            $Agence = $this->manager->agence->getById($agence_id);
            
            if( !empty($Agence) && !empty($Agence['email']) ):
                sendEmail($Agence['email'], $Contact['email'], 'Contact depuis le site internet ', $Contact['message'],nl2br($Contact['message']));
            endif;
            
            // On redirige l utilisateur une fois le mail envoyer
            return $this->redirect( getLink('agence/detail/'. $agence_id .'/'. urlencode($Agence['nom'])),3, $this->lang['Message_envoye']);
            
        endif;
        
        return $this->indexAction();
        
    }
    
    private function getMapAgence($Agence){
        //Generation map
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'GoogleMapAPIv3.class.php';
		$gmap = new GoogleMapApi();
		$gmap->setLang('fr');
		$gmap->setSize('400px;', '250px;');
		$gmap->setZoom(8);
		$gmap->setIconSize(25, 25);
		$gmap->setCenter($Agence['code_postal'] . ' ' . $Agence['ville']);
		
        $linkDetail = getLink('agence/detail/'. $Agence['id']);
        $htmlicone = $Agence['nom'] . '<br/>' . $Agence['adresse'] . '<br/>' .$Agence['code_postal'] . ' ' . $Agence['ville'] . '<br/>' . $Agence['pays'] . '<br/><a href=\''.$linkDetail .'\'>Detail</a>';
        $coord = $gmap->geocoding($Agence['adresse'] . ' ' . $Agence['code_postal'] . ' ' . $Agence['ville'] . ' ' . $Agence['pays']);
        $gmap->addMarkerByCoords($coord[2], $coord[3],$htmlicone  , $htmlicone, '');
            
		$gmap->generate();
		
		return $gmap;
    }

    private function getMapAgences($Agences){
        //Generation map
        require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'GoogleMapAPIv3.class.php';
        $gmap = new GoogleMapApi();
        $gmap->setLang('fr');
        $gmap->setSize('350px;', '350px;');
        $gmap->setZoom(5);
        $gmap->setIconSize(25, 25);
        
        foreach( $Agences as $Row ):
            $linkDetail = getLink('agence/detail/'. $Row['id']);
            $htmlicone = $Row['nom'] . '<br/>' . $Row['adresse'] . '<br/>' .$Row['code_postal'] . ' ' . $Row['ville'] . '<br/>' . $Row['pays'] . '<br/><a href=\''.$linkDetail .'\'>Detail</a>';
            /*if( isset($Row['lat']) && isset($Row['lon']) && !empty($Row['lat']) && !empty($Row['lon']) ):
                // Ajout du lieu par coordonnee GPS
                $gmap->addMarkerByCoords($Row['lat'], $Row['lon'], $htmlicone , $htmlicone, '');
            else:*/
                // Ajout du lieu par adresse
                $coord = $gmap->geocoding($Row['adresse'] . ' ' . $Row['code_postal'] . ' ' . $Row['ville'] . ' ' . $Row['pays']);
                $gmap->addMarkerByCoords($coord[2], $coord[3],$htmlicone  , $htmlicone, '');
            //endif;
            
        endforeach;
        
        $gmap->generate();
        
        return $gmap;
    }
    
}
