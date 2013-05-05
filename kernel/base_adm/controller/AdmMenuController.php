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
                                                                               

*/

abstract class AdmMenuController extends Controller{

	/**
	*	@desc Affiche la liste des menus
	*	@return mixed code HTML
	*/
	public function indexAction(){
	
		$Menu = new AdmMenuModel();
		
		# Recuperation de la liste des menus
		$Menus = $Menu->get();	
		
		$this->app->smarty->assign(array(
			'Menus'		=>	$Menus,
			'ctitre'	=>	$this->lang['Administration'] . '::' . $this->lang['Menu'],
		));

		# Generation de la page
		if( is_file( VIEW_PATH . 'menu' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'menu' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'menu' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
				
	}
	
	/**
	*	@desc Affiche le formulaire pour ajouter un menu
	*	@return mixed code HTML
	*/
	public function addAction(){
		
		if( $this->app->HTTPRequest->postExists('menu') ):
			
			$Menu = new AdmMenuModel( $this->app->HTTPRequest->postData('menu') );
			
			if( $Menu->isValid() === false ) goto printform;
			
			// Enregistrement
			$Menu->id = $Menu->save();
						
			return $this->redirect( $this->app->Helper->getLinkAdm("menu/edit/" . $Menu->id), 3, $this->lang['Menu_ajoute'] );
			
		endif;
		
		printform:
		$this->getFormValidatorJs();
		
		$this->app->smarty->assign(array(
			'ctitre'	=>	$this->lang['Administration'] . '::' . $this->lang['Menu'] . '::' . $this->lang['Nouveau'],
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'menu' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'menu' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'menu' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);		
	}
	
	public function editAction( $menu_id ){

		
		if( $this->app->HTTPRequest->postExists('menu') ):
		
			$Menu = new AdmMenuModel($this->app->HTTPRequest->postData('menu') );
			
			// Recuperations des links et traitements
			$Links = $this->app->HTTPRequest->postData('link');
			
			// Init de la var qui va recevoir les liens formaté
			$Liens = array();
			
			// On parcours les liens pour verifié qu il soit correctement remplie et mettre les bonnes valeurs
			foreach( $Links as $Link ):
				if( !empty($Link['name']) ):
					$Link['enabled'] = isset($Link['enabled']) ? 1 : 0;
					$Link['new_page'] = !isset($Link['new_page']) ? 0 : 1;
					$Link['internal'] = stristr($Link['link'], 'http://') === false ? 1 : 0;
					$Liens[] = $Link;
				endif;
			endforeach;
			
			// On serialise le tableau pour enregistrement
			$Menu->setLinks( serialize($Liens) );
			
			// On sauvegarde le menu dans la base
			$Menu->save();
			
			// On redirige l utilisateur
			return $this->redirect( $this->app->Helper->getLinkAdm('menu'), 3, $this->lang['Menu_modifie']);
		
		endif;

		$Menu = new AdmMenuModel();
		$Menu->get($menu_id);		
		
		$this->getFormValidatorJs();
		
		if( !empty($Menu->links) ):
			$Menu->links = unserialize($Menu->links);
		endif;
		
		$this->app->smarty->assign(array(
			'Menu'		=>	$Menu,
			'ctitre'	=>	$this->lang['Administration'] . '::' . $this->lang['Menu'] . '::' . $this->lang['Edition'],
			'nb_links'	=>	!empty($Menu->links) ? count($Menu->links) : 0,
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'menu' . DS . 'edit.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'menu' . DS . 'edit.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'menu' . DS . 'edit.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function deleteAction( $menu_id ){
		$this->app->db->delete(PREFIX . 'menu', $menu_id);
		return $this->redirect( $this->app->Helper->getLinkAdm('menu'), 3, $this->lang['Menu_supprime']);
	}
	
	public function getNewLinkAction(){
		$this->app->smarty->assign('link_id', $this->app->HTTPRequest->getData('id_for_link'));

		# Generation de la page
		if( is_file( VIEW_PATH . 'menu' . DS . 'ajax_ligne_link.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'menu' . DS . 'ajax_ligne_link.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'menu' . DS . 'ajax_ligne_link.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function getLinkListAction(){
		$str = $this->app->HTTPRequest->getData('term');
		if( $str == '*'):
			$Links = $this->app->db->get(PREFIX . 'link_available', null, 'name');
		else:
			$Links = $this->app->db->select('*')->from(PREFIX . 'link_available')->where_free('name LIKE "%'. $str .'%"')->order('name')->get();
		endif;
		
		return json_encode($Links);
	}
}