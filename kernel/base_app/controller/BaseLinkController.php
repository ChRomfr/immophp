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

class Baselinkcontroller extends Controller{
	
	/**
	*	Affiche la liste des telechagements
	*	@param int $cid : Id de la categorie a afficher
	*	@return void
	*/
	public function indexAction(){
		$link_per_page = 10;
		
		//require_once ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Tree.class.php';
		$Tree = new Tree($this->app->db, PREFIX . 'download_categorie');
		
		$this->load_manager('link', 'base_app');
		
		if( $this->app->HTTPRequest->getExists('cid') ): 

			$categorie_id = $this->app->HTTPRequest->getData('cid');
			$Categorie = $this->app->db->get_one(PREFIX . 'link_categorie', array('id =' => $categorie_id));
			$Categories = $this->app->db->get(PREFIX . 'link_categorie', array('parent_id =' => $categorie_id), 'name');
			$Parents = $Tree->getParent($Categorie['lft'], $Categorie['rght']);
			
			$this->app->smarty->assign(array(
				'Parents'		=>	$Parents,
				'Categorie'		=>	$Categorie,
			));
			
		else:
			$categorie_id = 0;	
			$Categories = $this->app->db->get(PREFIX . 'link_categorie', array('parent_id =' => 0), 'name');
		endif;					
		

		$Links	= $this->manager->link->getAll( $link_per_page, getOffset($link_per_page), $categorie_id );
		$NbLink	= $this->manager->link->count($categorie_id);
		
		$Pagination = new Zebra_Pagination();
		$Pagination->records($NbLink);
		$Pagination->records_per_page($link_per_page);
		
		$this->app->smarty->assign(array(
			'Links'			=>	$Links,
			'Categories'	=>	$Categories,
			'ctitre'		=>	'Liens',
			'Pagination'	=>	$Pagination,
		));		
				
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'link' . DS . 'index.tpl');
	}

	public function detailAction($id){
		# Chargement du model
		$this->load_manager('link', 'base_app');

		# Recuperation du fichier
		$Link = new myObject( $this->manager->link->getById($id) );

		# Recuperation des categories parents
		$Tree = new Tree($this->app->db, PREFIX . 'link_categorie');
		$Categorie = $this->app->db->get_one(PREFIX . 'link_categorie', array('id =' => $Link->categorie_id));
		$Parents = $Tree->getParent($Categorie['lft'], $Categorie['rght']);

		# Envoie a smarty des donnees
		$this->app->smarty->assign(array(
			'Link'					=>	$Link,
			'Parents'				=>	$Parents,
			'Categorie'				=>	$Categorie,
			'ctitre'				=>	'Liens' . ' :: ' . $Link->name,
			'Description_this_page'	=>	strip_tags($Link->description)
		));
		
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'link' . DS . 'detail.tpl');
	}
	
	public function updateDownloadedAction($id){
		$Download = $this->app->db->get_one(PREFIX . 'download', array('id =' => $id));
		$Download['downloaded']++;
		$this->app->db->update(PREFIX . 'download', $Download);
		return true;
	}

	public function updateVueAction($id){
		$Download = $this->app->db->get_one(PREFIX . 'download', array('id =' => $id));
		$Download['vue']++;
		$this->app->db->update(PREFIX . 'download', $Download);
		return true;
	}
}