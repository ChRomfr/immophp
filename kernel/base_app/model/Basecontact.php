<?php
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
                                                                               

*/

class Basecontact extends Record{

	# On defini la table qui va recevoir les enregistrements
	const Table = 'contact';

	public 	$id;

	public 	$name;

	public 	$email;

	public 	$message;

	public 	$ip;

	public 	$post_on;

	public 	$lu;

	/**
	*	Verifie la validite d un enregistrement
	*
	*/
	public function isValid(){
		$Message = null;

		if( empty($this->name) ):
			$Message .= '<p>Name not empty</p>';
		endif;

		if( empty($this->email) ):
			$Message .= '<p>Email not empty</p>';
		endif;

		if( VerifieAdresseMail($this->email) !== true ):
			$Message .= '<p>Email invalid</p>';
		endif;

		if( empty($this->message) ):
			$Message .= '<p>Message not empty</p>';
		endif;

		if( !is_null($Message) ):
			$this->error = $Message;
			return false;
		endif;

		return true;

	}

	/**
	*	Traite la sauvegarde du message
	*
	*/
	public function save(){

		# On complete les donnees
		$this->ip = $_SERVER['REMOTE_ADDR'];
		$this->post_on = time();
		$this->lu = 0;

		# Securisation des donnees envoyer
		$this->message = strip_tags($this->message);
		$this->message = htmlentities($this->message);
		
		# On sauvegarde dans la base
		return parent::save();
	}

}