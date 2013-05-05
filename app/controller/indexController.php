<?php

class indexController extends Controller{

	public function indexAction(){
        
        # Derniere annonce en page d accueil
		if( $this->app->config['index_last_annonce'] == 1):

			$this->load_manager('bien');
	        
	        $Biens = $this->manager->bien->getAll(null,'b.add_on DESC',3);	        
	        
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

	        $this->app->smarty->assign('Annonces',$Biens);

        endif;

        # Verification si page HTML en accueil
        if( !empty($this->app->config['index_page']) ):
        	$Page = new Basepage();
        	# On recupere la page
        	$Page->get( $this->app->config['index_page'] );

        	# Verification qu'une page est retourne et envoie a smarty
        	if( !empty($Page) ):
        		$this->app->smarty->assign('Page', $Page);
        	endif;

        endif;

        # Traitement avec la cache de la carte des agences
        if( $this->app->config['index_carte_agence'] == 1):
        	$this->load_manager('agence');
        	$Agences = $this->manager->agence->getAll();
	        if( !$CarteAgence = $this->app->cache->get('carte_agence_index') ):
	    		$Carte = $this->getMapAgences($Agences);    	
	        	$CarteAgence = $Carte->getGoogleMap();
	        	$this->app->cache->save($CarteAgence);
	        endif;
	        $this->app->smarty->assign('CarteAgence',$CarteAgence);
        endif;
        
		return $this->app->smarty->fetch(VIEW_PATH . 'index' . DS . 'index.tpl');
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