<?php
if( !defined('IN_VA')) exit;
/*

                                                                               
                                     _,,                                   ,dW 
                                   ,iSMP                                  JIl; 
                                  sPT1Y'                                 JWS:' 
                                 sIl:l1                                 fWIl?  
                                dIi:Il;                                fW1"    
                               dIi:l:I'                               fWI:     
                              dIli:l:I;                              fWI:      
                            .dIli:I:S:S                     .       fWIl`      
                          ,sWSSIIIiISIIS w,_             .sMW     ,MWIl;       
                     _.,sWWW*"'*" , SWW' MWWMm mu,,._  .iSYISb, ,MM*SI!:       
                 _,s YMMWW'',sd,'MM WMMi "*MW* WWWMWMb MMS WWP`,MW' S1!`       
            _,os,'MMi YW' m,'WW; WWb`SWM Im,,  SIS ISW SISIP*  WSi  II!.       
         .osSMWMW,'WSi ',MMP SSb WSW ISII`SYYi III !Il lIi,ui:,*1:li:l1!       
      ,sSMMWWWSSSS,'SWbdWW*  *YSbiSS:'IlI 7llI il1: l! 'l:+'+l; `''+1i:1i      
   ,sYSMWMWY**"""'` 'WWSSIIiu,'**Y11';IIIb ?!li ?l:i,         `      `'l!:     
  sPITMWMW'`.M.wdWWb,'YIi `YT" ,u!1",ISIWWm,'+?+ `'+Ili                `'l:,   
  YIi1lTYfPSkyLinedI!i`I!" .,:!1"',iSWWMMMMMmm,                                
    "T1l1lI**"'`.2006? ',o?*'``  ```""**YSWMMMWMm,                             
         "*:iil1I!I!"` '                 ``"*YMMWWM,                           
               ii!                             '*YMWM,                         
               I'                                  "YM                         

Cette class gere les sessions sur sharkphp                                                                               

*/

class Session {

	private 	$registry;
	
	public 		$session;
	
	private 	$db;
	
	public 		$user_id;
	
	public 		$_session;
	
	public function __construct($registry){
		$this->registry = $registry;
		$this->session = $_SESSION;
		$this->db = $this->registry->db;
	}
	
	public function check(){

		if( !isset($_SESSION['session_id']) || empty($_SESSION['session_id']) ):
			return false;
		endif;
		
		if( !isset($_SESSION['utilisateur']) || !is_array($_SESSION['utilisateur']) || empty($_SESSION['utilisateur']) ):
			return false;
		endif;

		if( !isset($_SESSION['token']) || empty($_SESSION['token']) ):
			return false;
		endif;


		if( SESSION_IN_DB ):
			$Result = $this->db->count(PREFIX . 'sessions', array('session_id = ' => $_SESSION['session_id']), 'session_id'); 
			if($Result == 0):
				return false;
			endif;
		endif;	

		# Si session en base on met a jout
		if( SESSION_IN_DB ):
			$this->update();
		endif;

		return true;
	}
	
	public function update(){
		if( SESSION_IN_DB ):
			$this->db->update(PREFIX . 'sessions', array('session_id' => $this->session['session_id'], 'last_used' => time()) , array('session_id =' => $this->session['session_id']) );
		endif;
	}
	
	public function clearSession($delay = 86400 ){
		if( SESSION_IN_DB ):
			$delay = time() - $delay;
			$this->db->delete(PREFIX . 'sessions', null, array('create_on <' => $delay) );
		endif;
	}
	
	public function checkTime(){
		if( $this->session['creat_on'] + 600 < time() ):
			session_regenerate_id();
			$this->session['creat_on'] = time();
		endif;
	}
	
	public function create($user){

		# On detruit la session actuel
		if( isset($_SESSION['utilisateur']) ):
			$this->destroy();
			session_start();
		endif;

		if( $user == 'Visiteur'):
			$this->createVisiteurSession();
			if( SESSION_IN_DB ):
				$this->storeInDb();
			endif;
		endif;

		if( is_object($user) || is_array($user) ):
			$this->creatSession($user);
			if( SESSION_IN_DB ):
				$this->storeInDb();
			endif;
		endif;
	}

	private function createVisiteurSession(){

		$_SESSION['utilisateur'] 				= array();
		$_SESSION['session_id'] 				= getUniqueId();
		$_SESSION['token'] 						= getUniqueId();
		$_SESSION['creat_on'] 					= time();
		$_SESSION['ip'] 						= $_SERVER['REMOTE_ADDR'];
		$_SESSION['utilisateur']['actif'] 		= 1;
		$_SESSION['utilisateur']['id'] 			= 'Visiteur';
		$_SESSION['utilisateur']['identifiant']	= 'Visiteur';
		$_SESSION['utilisateur']['isAdmin'] 	= 0;

		return true;
	}

	private function creatSession($user){

		foreach($user as $k => $v):
			if( $k != 'password' ):
				$_SESSION['utilisateur'][$k] = $v;
			endif;
		endforeach;
		
		$_SESSION['session_id'] = getUniqueId();
		$_SESSION['token'] = getUniqueId();
		$_SESSION['creat_on'] = time();
		$_SESSION['ip'] = $_SERVER['REMOTE_ADDR']; 		
	}
	
	private function updateSession($user){
		
		foreach($user as $k => $v){
			if( $k != 'password' )
				$_SESSION['utilisateur'][$k] = $v;
		}
		
		$_SESSION['session_id'] = $_SESSION['session_id'];
		$_SESSION['token'] = $_SESSION['token'];
		$_SESSION['creat_on'] = time();
		$_SESSION['ip'] = $_SERVER['REMOTE_ADDR']; 		
	}
	
	public function checkToken(){
		$token = $_REQUEST['token'];

		if( $_SESSION['token'] == $token):
			return true;
		endif;
		
		return false;
	}
	
	public function destroy(){

		if( SESSION_IN_DB ):
			$this->deleteBySessionId();
		endif;

		# On detruit la session
		session_destroy();
	}
	
    /**
     * Verifie si un utilisateur est identifié.
     * @return bool true:identifié false:visiteur
     * */
	public function isIdentified(){
		if( $_SESSION['utilisateur']['id'] != 'Visiteur') return true;
		
		return false;
	}
	
	public function isAdmin(){
		if( isset($_SESSION['utilisateur']['isAdmin']) && $_SESSION['utilisateur']['isAdmin'] > 0) return true;
		else return false;
	}

	private function deleteBySessionId(){
		$this->db->query( 'DELETE FROM '. PREFIX .'sessions WHERE session_id = "'. $_SESSION['session_id'] .'" ');
	}
	
	private function deleteByUserId(){
		$this->db->query( 'DELETE FROM '. PREFIX .'sessions WHERE user_id = "'. $_SESSION['utilisateur']['id'] .'" ');
	}
	
	private function storeInDb(){
		return $this->db->query( 'INSERT INTO '. PREFIX . 'sessions (session_id, user_id, ip, create_on, last_used) VALUES ("'. $_SESSION['session_id'] .'", "'. $_SESSION['utilisateur']['id'] .'", "'. $_SESSION['ip'] .'", "'. $_SESSION['creat_on'] .'", "'. time() .'" ) ');
	}		
}