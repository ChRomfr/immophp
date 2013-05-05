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

class Basearticlecontroller extends Controller{
	
	public function indexAction(){		
		
		require_once ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Tree.class.php';
		$Tree = new Tree($this->app->db, PREFIX . 'article_categorie');
		
		$this->load_manager('article', 'base_app');
		
		if( $this->app->HTTPRequest->getExists('cid') ): 
			$categorie_id = $this->app->HTTPRequest->getData('cid');
			$Categorie = $this->app->db->get_one(PREFIX . 'article_categorie', array('id =' => $categorie_id));
			$Categories = $this->app->db->get(PREFIX . 'article_categorie', array('parent_id =' => $categorie_id), 'name');
			$Parents = $Tree->getParent($Categorie['lft'], $Categorie['rght']);
			
			$this->app->smarty->assign(array(
				'Parents'		=>	$Parents,
				'Categorie'		=>	$Categorie,
			));
			
		else:
			$categorie_id = '';	
			$Categories = $this->app->db->get(PREFIX . 'article_categorie', array('parent_id =' => 0), 'name');
		endif;					
		
		$Articles = $this->manager->article->getAll( array('categorie_id =' => $categorie_id) );
		
		
		$this->app->smarty->assign(array(
			'Articles'		=>	$Articles,
			'Categories'	=>	$Categories,
			'ctitre'		=>	$this->lang['Article'],
		));
		
		return $this->registry->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'article' . DS . 'index.tpl');
	}
	
	public function readAction($article_id){

		if( empty($article_id) ):
			return $this->app->Http->error404();
		endif;
		
		$this->load_manager('article', 'base_app');
		
		$Article = $this->manager->article->getById( $article_id );
		
		// Recuperation de la branche des catégories
		if( !empty($Article['categorie_id']) ):
			require_once ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Tree.class.php';
			$Tree = new Tree($this->app->db, PREFIX . 'article_categorie');
			$Categories = $Tree->getParent($Article['lft'], $Article['rght']);
			$this->app->smarty->assign('Parents', $Categories);
		endif;
		
		if( empty($Article) ) return $this->redirect( $this->app->Helper->getLink('index/index'), 0, '');
		
		$this->app->addJS('mustache.js');
		
		if( $this->app->config['use_sh'] == 1 ):
			$this->app->addJS('sh/shCore.js');
			$this->app->addJS('sh/shBrushCss.js');
			$this->app->addJS('sh/shBrushPhp.js');
			$this->app->addJS('sh/shBrushSql.js');
			$this->app->addJS('sh/shBrushXml.js');
			$this->app->addJS('sh/shBrushJScript.js');
			$this->app->addCSS('sh/shCoreDefault.css');
		endif;

		$this->app->smarty->assign(array(
			'Article'				=>	$Article,
			'ctitre'				=>	$Article['title'],
			'Description_this_page'	=>	substr(strip_tags($Article['article']),0,250),
		));
		
		return $this->registry->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'article' . DS . 'read.tpl');
	}
	
	public function getCommentairesAction($id){

		$this->load_manager('commentaire','base_app');
		$this->manager->commentaire->setModel('article');
		$commentaires = $this->manager->commentaire->getByModelId($id);
		
		$i=0;
		foreach( $commentaires as $commentaire):

			if( isset($_SESSION['utilisateur']['isAdmin']) && $_SESSION['utilisateur']['isAdmin'] > 1):
				$commentaires[$i]['administrateur'] = '1';
			else:
				$commentaires[$i]['administrateur'] = null;
			endif;

			$commentaires[$i]['date_commentaire'] = date('d/m/Y H:i',$commentaire['post_on']);

			$i++;
		endforeach;

		return json_encode($commentaires);
	}

	public function lockCommentaireAction($id){
		if( ADM_ARTICLE_LEVEL < $_SESSION['utilisateur']['isAdmin']):
			$this->app->db->update(PREFIX . 'article', array('commentaire' => 0), array('id =' => $id));
			header('location:'. $this->app->Helper->getLink("article/read/". $id) );
			exit;
		endif;
		
		return '';
	}
	
	public function unlockCommentaireAction($id){
		if( ADM_ARTICLE_LEVEL < $_SESSION['utilisateur']['isAdmin']):
			$this->app->db->update(PREFIX . 'article', array('commentaire' => 1), array('id =' => $id));
			header('location:'. $this->app->Helper->getLink("article/read/". $id) );
			exit;
		endif;
		
		return '';
	}
}