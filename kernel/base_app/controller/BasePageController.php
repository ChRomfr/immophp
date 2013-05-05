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

abstract class BasepageController extends Controller{
	
	public function indexAction($id){

		$page = new Basepage();			
		$page->get($id); 
		
		if(empty($page) || $page['visible'] == 0):
			header('location:' . $this->app->Helper->getLink('index?error_html=404') );
			exit;
		endif;
		
		$this->app->smarty->assign(array(
			'ctitre'	=>	$page->titre,
			'page'		=>	$page,
		));
		
		# Si SH active
		if( $this->app->config['use_sh'] == 1 ):
			$this->app->addJS('sh/shCore.js');
			$this->app->addJS('sh/shBrushCss.js');
			$this->app->addJS('sh/shBrushPhp.js');
			$this->app->addJS('sh/shBrushSql.js');
			$this->app->addJS('sh/shBrushXml.js');
			$this->app->addJS('sh/shBrushJScript.js');
			$this->app->addCSS('sh/shCoreDefault.css');
		endif;

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'page' . DS . 'index.tpl');			
	}
	
}