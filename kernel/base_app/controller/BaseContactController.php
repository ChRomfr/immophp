<?php if( !defined('IN_VA') ) exit;
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

class Basecontactcontroller extends Controller{

	/**
	*	Affiche et traite le formulaire de contact
	*
	*/
	public function indexAction(){

		if( $this->app->HTTPRequest->postExists('contact') ):
			
			# Verification de Captcha
			/*if( Captcha::verif_captcha($this->app->HTTPRequest->postData('captcha_code')) !== TRUE):
				goto printform;
			endif;		*/
			
			$contact = new Basecontact($this->app->HTTPRequest->postData('contact'));
			
			# On verifie que tout le champ soit remplie
			if( $contact->isValid() !== TRUE ):
				goto printform;
				echo $contact->error;
			endif;
			
			# On sauvegarde dans la base
			$contact->save();

			# On envoie un email a l admin du site
			if( !empty($this->app->config['email']) ):
				sendEmail($this->app->config['email'], $contact->email, 'Contact depuis ' . $this->app->config['titre_site'], $contact->message, nl2br($contact->message));
			endif;
			
			# On redirige l utilisateur vers l index du site
			return $this->redirect($this->app->Helper->getLink('index/index'), 3, $this->lang['Message_envoye']);
		endif;
		
		printform:
		
		$this->getFormValidatorJs();
		
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'contact' . DS . 'index.tpl');
	}
	
} // end class
