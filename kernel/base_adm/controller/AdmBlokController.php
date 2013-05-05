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
abstract class AdmBlokController extends Controller{

	public function indexAction(){
		$this->load_manager('blok','admin');
		
		$this->app->smarty->assign('bloks', $this->manager->blok->getAll());
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'blok' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'blok' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'blok' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function addAction(){
		
		$this->load_manager('blok');
		
		if( $this->app->HTTPRequest->postExists('blok') ){

			$blok = new AdmBlokModel($this->app->HTTPRequest->postData('blok'));
			
			if( $blok->type == 'MENU' ):
			
				// Recuperation du nom du menu pour le mettre en name
				$Menu = $this->app->db->get_one(PREFIX . 'menu', array('id =' => $blok->contenu));
				
				// Verification menu existe
				if( empty($Menu) ) goto printform;
				
				$blok->setName($Menu['name']);
				
			elseif( $blok->type == 'RSS'):
				
				$this->formatRss($blok);
				
			elseif( $blok->type == 'HTML' ):
				$blok->contenu = $this->app->HTTPRequest->postData('contenu_html');
			else:
				$Data = $this->app->db->get_one(PREFIX . 'blok_available', array('id =' => $blok->type) );
				
				$blok->type = 'ADDON';
				$blok->name = $Data['name'];
				$blok->fichier = $Data['file'];
				$blok->call_fonction = $Data['function_call'];
				
			endif;
			
			if( $blok->isValid() !== true) goto printform;
			
			if( isset($blok->only_index) ) 
				$blok->setOnlyIndex(1);
			else
				$blok->setOnlyIndex(0);
			
			$blok->setVisibleBy('all');

			$blok->save();
			
			return $this->redirect($this->app->Helper->getLinkAdm('blok/index'), 3, $this->lang['Blok_ajoute']);
		}
		
		printform:
		
		$this->app->smarty->assign(array(
			'Menus'		=>	$this->app->db->select('id, name')->from(PREFIX . 'menu')->order('name')->get(),
			'ctitre'	=>	$this->lang['Administration'] . '::' . $this->lang['Blok'] . '::' . $this->lang['Nouveau'],
			'Bloks'		=>	$this->app->db->get(PREFIX . 'blok_available', null, 'name'),
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'blok' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'blok' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'blok' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
		
	}
	
	public function editAction($id){
		
		$this->load_manager('blok');
		
		if( $this->app->HTTPRequest->postExists('blok') ){
			$blok = new AdmBLokModel($this->app->HTTPRequest->postData('blok'));
			
			// Traitement particulier du blok 
			if( $blok->type == 'RSS' ):
				$this->formatRss($blok);
			endif;
			
			if( $blok->isValid() !== true)
				goto printform;
				
			if( isset($blok->only_index) ) 
				$blok->setOnlyIndex(1);
			else
				$blok->setOnlyIndex(0);
			
			$blok->setVisibleBy('all');
				
			$blok->save();
			
			return $this->redirect($this->app->Helper->getLinkAdm('blok/index'), 3, $this->lang['Blok_modifie']);
		}
		
		printform:
		
		$blok = $this->manager->blok->getById($id);
		
		if( $blok['type'] == 'RSS' ):
			$blok['contenu'] = unserialize($blok['contenu']);
		endif;
		
		$this->app->smarty->assign(array(
			'blok'		=>	$blok,
			'Menus'		=>	$this->app->db->select('id, name')->from(PREFIX . 'menu')->order('name')->get(),
		));
				
		# Generation de la page
		if( is_file( VIEW_PATH . 'blok' . DS . 'edit.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'blok' . DS . 'edit.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'blok' . DS . 'edit.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function deleteAction($id){
		$this->registry->db->delete(PREFIX . 'blok', $id);
		return $this->redirect($this->app->Helper->getLinkAdm('blok'), 3, $this->lang['Blok_supprime']);
	}
	
	private function formatRss($blok){
		$Data = $this->app->HTTPRequest->postData('blok');
		
		$Tmp = array(
			'nameflux1'		=>	$Data['nameflux1'],
			'flux1'			=>	$Data['flux1'],
			'nameflux2'		=>	isset($Data['nameflux2']) ? $Data['nameflux2'] : '',
			'flux2'			=>	isset($Data['flux2']) ? $Data['flux2'] : '',
			'nb_links'		=>	$Data['nb_links'],	
		);
		
		$blok->contenu = serialize($Tmp);
		
		$blok->setName($Data['name_flux']);
		
		return true;
	}

}