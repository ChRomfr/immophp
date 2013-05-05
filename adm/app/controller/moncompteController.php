<?php

class moncompteController extends Controller{
    
    public $MyGCalendrier;
    
    public function __construct($app){
		parent::__construct($app);
		
		set_include_path(ROOT_PATH . 'kernel' . DS . 'lib' . DS);
		
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'Zend' . DS . 'Loader.php';
		
		Zend_Loader::loadClass('Zend_Gdata');
		Zend_Loader::loadClass('Zend_Gdata_AuthSub');
		Zend_Loader::loadClass('Zend_Gdata_ClientLogin');
		Zend_Loader::loadClass('Zend_Gdata_Calendar');
		 
		$user = $_SESSION['utilisateur']['gmail_adr'];
		$pass = $_SESSION['utilisateur']['gmail_password'];
		$service = Zend_Gdata_Calendar::AUTH_SERVICE_NAME;
		 
		if( !empty($user) && !empty($pass) ): 
		try
		{
			$this->MyGCalendrier = Zend_Gdata_ClientLogin::getHttpClient($user,$pass,$service);			
		}
		catch(Exception $e)
		{
			// prevent Google username and password from being displayed
			// if a problem occurs
			echo "$e Could not connect to calendar.";
           echo "Erreur during connect to calendar !";
			//die();
		}
		endif;
	}
    
    public function indexAction(){
        $this->load_manager('visite','admin');
        
        $Visites = $this->manager->visite->getFutureByUserId($_SESSION['utilisateur']['id']);
        
        $this->app->smarty->assign(array(
           'Visites'        =>  $Visites, 
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'moncompte' . DS . 'index.tpl' );
    }
    
    /**
    *	Affiche et traite le formulaire d edition de profil ...
    *
	*/
    public function editAction(){
    	
    	if( $this->app->HTTPRequest->postExists('user') ):
    		
    		$User = $this->app->HTTPRequest->postData('user');  
        
    		// Sauvegarde dans la base
    		$this->app->db->update(PREFIX . 'user', $User, array('id =' => $_SESSION['utilisateur']['id']) );
    		
    		return $this->redirect( getLinkAdm('moncompte'), 3, $this->lang['Profil_modifie'] );
    		
    	endif;
    	
		print_form:    	
		$this->getFormValidatorJs();
    	return $this->app->smarty->fetch( VIEW_PATH . 'moncompte' . DS . 'edit_profil.tpl' );
    }
    
    /**
     * Affiche la calendrier GOOGLE
     */
    public function gcalendarAction(){
        
    }
    
    public function addGCalandarVisiteAction($visite_id){
        $this->load_manager('visite','admin');
        
        $Visite = $this->manager->visite->getById($visite_id);
        
        // On prepare les donnnes
        $title = "Visite avec ". $Visite['p_nom'] . " " . $Visite['p_prenom'];
        $description = "Visite avec ". $Visite['p_nom'] . " " . $Visite['p_prenom'] . " pour le bien ". $Visite['bien'] . " - Ref : " . $Visite['b_reference'];
        $start_date = $Visite['date_visite'] . ' ' . $Visite['heure_visite'];
        $where = "";
        
        $calendar_user = $_SESSION['utilisateur']['gmail_adr'];
		$tzOffset = '+00'; // timezone offset
        
        // build event
		$start_date = str_replace(' ', 'T', $start_date);
		//$end_date = str_replace(' ', 'T', $end_date);
		 
		$gdataCal = new Zend_Gdata_Calendar($this->MyGCalendrier);
		$newEvent = $gdataCal->newEventEntry();
		 
		$newEvent->title = $gdataCal->newTitle($title);
		$newEvent->where = array($gdataCal->newWhere($where));
		$newEvent->content = $gdataCal->newContent($description);
		 
		$when = $gdataCal->newWhen();
		$when->startTime = "{$start_date}.000{$tzOffset}:00";
		//$when->endTime = "{$end_date}.000{$tzOffset}:00";
		$newEvent->when = array($when);
		 
		// insert event
		$createdEvent = $gdataCal->insertEvent($newEvent, "http://www.google.com/calendar/feeds/$calendar_user/private/full");
		 
		// event id
		$event_id = $createdEvent->id->text;
        
        // Enregistement dans la base de l ID
        $this->app->db->insert(PREFIX . 'visite_user_gcalendar', array('visite_id' => $visite_id, 'user_id' => $_SESSION['utilisateur']['id'], 'g_id' => $event_id));
		
		return $this->redirect( getLinkAdm("moncompte"));
    }
}


