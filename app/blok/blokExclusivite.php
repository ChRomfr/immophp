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
function blokExclusivite($app){
	
	// Recuperation d un coup de coeur aleatoire dans base
	$Annonce	=	$app->db
						->select('b.id, b.nom, b.reference, b.prix')
						->from(PREFIX . 'bien b')
						->where(array('b.visible =' => 1, 'b.vendu =' => 0, 'b.delete =' => 0, 'b.exclusif =' => 1))
						->order('RAND()')
						->get_one();

	// On traite le cas 0 exclusivite dans la base
	// On recupere une annonce aleatoire dans la base
	if( empty($Annonce) ):
		$Annonce	=	$app->db
						->select('b.id, b.nom, b.reference, b.prix')
						->from(PREFIX . 'bien b')
						->where(array('b.visible =' => 1, 'b.vendu =' => 0, 'b.delete =' => 0))
						->order('RAND()')
						->get_one();
	endif;

	// On recupere une photo pour l'annonce
	$Tmp = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $Annonce['id'] . DS);

	$y=1;
	foreach( $Tmp as $key => $value ):
		$Annonce['photo'] = $value;
		if($y==1):
			break;
		endif;
	endforeach;

	// envoie des vars au template et generation du code HTML
	$app->smarty->assign('Annonce',$Annonce);

	return $app->smarty->fetch( VIEW_PATH . 'blok' . DS . 'blokExclusivite.tpl' );

}