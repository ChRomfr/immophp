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
abstract class AdmMailingController extends Controller{
	
	public function indexAction(){

		$this->app->smarty->assign(array(
			'Mailings'		=>	$this->app->db->get(PREFIX . 'mailing',null,'date_mailing DESC'),
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'mailing' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'mailing' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'mailing' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function addAction(){
		
		if( $this->app->HTTPRequest->postExists('mailing') ):
			set_time_limit(0);
			$Mailing = $this->app->HTTPRequest->postData('mailing');
			
			// Recuperation des utilisateurs pour le mailing
			$Users = $this->app->db->get(PREFIX . 'user');
			
			$Emails = array();
			
			foreach( $Users as $Row):
				$Emails[] = $Row['email'];				
			endforeach;
			
			// Enregistrement du mailing dans la base
			$Mailing['creat_on'] = time();
			$Mailing['auteur_id'] = $_SESSION['utilisateur']['id'];
			$Mailing['destinataires'] = serialize($Emails);
			$Mailing['date_mailing'] = date("Y") . '-' . date('m') . '-' . date('d');
			
			$this->app->db->insert(PREFIX . 'mailing',$Mailing);
			
			// Envoie du mail
			sendEmail($Emails , $this->app->config['email'], $Mailing['sujet'], strip_tags($Mailing['message']), $Mailing['message']);
			
			return $this->redirect( $this->app->Helper->getLinkAdm("mailing",3,'Mailing envoyer'));
		endif;
		
		printform:
			
		$this->getFormValidatorJs();

		$this->app->addJS('ckeditor/ckeditor.js');	

		# Generation de la page
		if( is_file( VIEW_PATH . 'mailing' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'mailing' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'mailing' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);		
	}
	
	public function editAction(){
		
	}
	
	public function deleteAction(){
		
	}
	
}