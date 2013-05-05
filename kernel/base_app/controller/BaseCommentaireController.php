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

class BasecommentaireController extends Controller{

	/**
	*	Traite le formulaire d envoie d un commentaire
	*	@return string code HTML de la page
	*/
	public function postAction(){
		
		# Verification utilisateur enregistrer
		if( $_SESSION['utilisateur']['id'] == 'Visiteur'):
			return $this->redirect($_SERVER['HTTP_REFERER'], 3, $this->lang['Vous_devez_etre_identifie']);
		endif;

		$this->load_manager('commentaire','base_app');
		
		# On dertime pour quel page le commentaire est poste
		if( $this->app->HTTPRequest->postExists('com_model') ):
			$this->manager->commentaire->setModel($this->app->HTTPRequest->postData('com_model'));
		else:
			return $this->redirect($_SERVER['HTTP_REFERER'], 0, '');
		endif;
				
		$commentaire = new Basecommentaire($this->registry->HTTPRequest->postData('com'));
		
		if( $commentaire->isValid() ):
			
			$commentaire->setPostOn(time());
			
			$this->manager->commentaire->save($commentaire);

			return $this->redirect($_SERVER['HTTP_REFERER'], 3, $this->lang['Commentaire_ajoute']);

		endif;
		
		return $this->redirect($_SERVER['HTTP_REFERER'], 3, $this->lang['Commentaire_invalide']);
	}
	
	/**
	*	Gerer la suppression d un commentaire
	*	@return string code HTML de la page
	*/
	public function deleteAction($id){
		if( $_SESSION['utilisateur']['isAdmin'] == 0) exit;
		
		$this->load_manager('commentaire','base_app');

		$this->manager->commentaire->setModel( $this->app->HTTPRequest->getData('com_model') );
		
		$this->manager->commentaire->delete($id);
		
		return $this->redirect($_SERVER['HTTP_REFERER'], 3, $this->lang['Commentaire_supprime']);
	}
	
}