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

function MyAutoload($class){

# Definition d un table avec le nom de la class et son chemin
$ClassList = array(

	'App'					=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'App.class.php',
	'Config'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Config.class.php',

	// Kernel / core
	'EPO'					=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'DB' . DS . 'EPDO.php',
	'EPOStatement'			=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'DB' . DS . 'EPDO.php',
	'Db'					=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'DB' . DS . 'Db.class.php',
	'Controller'			=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Controller.class.php',
	'HTTPRequest'			=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'HTTPRequest.class.php',
	'BaseModel'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Model.class.php',
	'Record'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Record.class.php',
	'myObject'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Record.class.php',
	'Registry'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Registry.class.php',
	'Router'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Router.class.php',
	'Session'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Session.class.php',
	'Tree'					=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Tree.class.php',
	'Captcha'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Captcha.class.php',
	'Helper'				=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Helper.class.php',
	'Http'					=>	ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Http.class.php',
	
	// Kernel / lib
	'Smarty'				=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'smarty' . DS . 'smarty.php',
	'MySmarty'				=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'MySmarty.class.php',
	'MyCache'				=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'MyCache.class.php',
	'Cache_Lite'			=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'PEAR' . DS . 'Lite.php',
	'Form'					=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'Form.class.php',	
	'GoogleMapAPI'			=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'GoogleMapAPIv3.class.php',
	'PHPMailer'				=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'class.phpmailer.php',
	'Pager'					=>	ROOT_PATH .	'kernel' . DS . 'lib' . DS . 'PEAR'. DS .'Pager.php',
	'Upload'				=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php',
	'Zebra_Pagination'		=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'zebra' . DS . 'Zebra_Pagination.php',
	'Feed'					=>	ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'FeedReader.php',
	
	// Kernel / base_app
	'Basearticlecontroller'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseArticleController.php',
	'Baseconnexioncontroller'	=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseConnexionController.php',
	'Baseutilisateurcontroller'	=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseUtilisateurController.php',
	'Basedownloadcontroller'	=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseDownloadController.php',
	'Basecontactcontroller'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseContactController.php',
	'Basenewscontroller'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseNewsController.php',
	'Basecommentairecontroller'	=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseCommentaireController.php',
	'Basexmlcontroller'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseXmlController.php',
	'Basepagecontroller'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BasePageController.php',
	'Basefeedrsscontroller'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseFeedRssController.php',
	'Baselinkcontroller'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseLinkController.php',
	'Baseannuairecontroller'	=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseAnnuaireController.php',
	'Baseforumcontroller'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'controller' . DS . 'BaseForumController.php',
	'AdmNewsController'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmNewsController.php',
	'AdmPageController'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmPageController.php',
	'AdmArticleController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmArticleController.php',
	'AdmCategorieController'	=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmCategorieController.php',
	'AdmDownloadController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmDownloadController.php',
	'AdmUtilisateurController'	=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmUtilisateurController.php',
	'AdmSystemeController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmSystemeController.php',
	'AdmMenuController'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmMenuController.php',
	'AdmBlokController'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmBlokController.php',
	'AdmMailingController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmMailingController.php',
	'AdmViewEditorController'	=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmViewEditorController.php',
	'AdmContactController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmContactController.php',
	'AdmFeedRssController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmFeedRssController.php',	
	'AdmFilemanagerController'	=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmFilemanagerController.php',
	'AdmLinkController'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmLinkController.php',
	'AdmAnnuaireController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmAnnuaireController.php',
	'AdmForumController'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'controller' . DS.  'AdmForumController.php',

	'Baseutilisateurmanager'	=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'manager' . DS . 'BaseutilisateurManager.php',
	'Basedownloadrmanager'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'manager' . DS . 'BasedownloadManager.php',
	'Basearticlemanager'		=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'manager' . DS . 'BasearticleManager.php',
	'Basenewsmanager'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'manager' . DS . 'BasenewsManager.php',
	'Baselinkmanager'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'manager' . DS . 'BaselinkManager.php',
	'Baseforummanager'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'manager' . DS . 'BaseforumManager.php',
	'AdmNewsManager'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmNewsManager.php',
	'AdmPageManager'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmPageManager.php',
	'AdmArticleManager'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmArticleManager.php',
	'AdmCategorieManager'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmCategorieManager.php',
	'AdmDownloadManager'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmDownloadManager.php',
	'AdmUtilisateurManager'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmUtilisateurManager.php',
	'AdmBlokManager'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmBlokManager.php',
	'AdmLinkManager'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmLinkManager.php',
	'AdmSiteManager'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'manager' . DS . 'AdmSiteManager.php',

	'Baseconfig'				=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Baseconfig.php',
	'Baseutilisateur'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Baseutilisateur.php',
	'Basecontact'				=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basecontact.php',
	'Basecommentaire'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basecommentaire.php',
	'Basepage'					=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basepage.php',
	'Basesite'					=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basesite.php',
	'Basethread'				=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basethread.php',
	'Basemessage'				=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basemessage.php',
	'Baselogmoderation'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Baselogmoderation.php',
	'Basemessagealerte'			=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basemessagealerte.php',
	'Basegroupe'				=>	ROOT_PATH . 'kernel' . DS . 'base_app' . DS . 'model' . DS . 'Basegroupe.php',
	'AdmNewsModel'				=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmNewsModel.php',
	'AdmPageModel'				=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmPageModel.php',
	'AdmArticleModel'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmArticleModel.php',
	'AdmDownloadModel'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmDownloadModel.php',
	'AdmUtilisateurModel'		=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmUtilisateurModel.php', 
	'AdmMenuModel'				=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmMenuModel.php', 
	'AdmBlokModel'				=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmBlokModel.php', 
	'AdmFluxLinkModel'			=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmFluxLinkModel.php',
	'AdmLinkModel'				=>	ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'model' . DS . 'AdmLinkModel.php',
);	

foreach( $ClassList as $k => $v ):
	if( $class = $k ):
		//if( is_file($v) ):
			require_once $v;
		//endif;
	endif;
endforeach;
	
}

spl_autoload_register('MyAutoload');