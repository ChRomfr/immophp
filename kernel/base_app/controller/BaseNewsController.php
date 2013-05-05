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

class Basenewscontroller extends Controller{

	public function indexAction(){
		
		# Chargement du manager
		$this->load_manager('news','base_app');

		# On compte le nombre de news dans la base
		$NewsInDb = $this->manager->news->count();

		# On recuperes les news dans la base
		$news = $this->manager->news->getAll($this->app->config['news_per_page'], getOffset($this->app->config['news_per_page']));

		# On envoie a smarty les donnees et on verifie la pagination
		$this->app->smarty->assign(array( 
			'news'			=>	$news,
			'pagination'	=>	$NewsInDb > $this->app->config['news_per_page'] ? getPagination( array('perPage'=>$this->app->config['news_per_page'], 'fileName'=>$this->app->Helper->getLink('news') .'?page=%d', 'totalItems'=>$NewsInDb) ) : null
		));

		# Generation du design
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'news' . DS . 'index.tpl');
	}

	public function viewAction($id){
		
		$this->load_manager('news','base_app');
		
		$new = $this->manager->news->getById($id);
		
		$this->app->addJS('mustache.js');
		
		$this->registry->smarty->assign(array(
			'new'			=>	$new,
			'ctitre'		=>	$new['sujet'],
		));
		
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'news' . DS . 'view.tpl');
	}

	public function getCommentairesAction($id){

		$this->load_manager('commentaire','base_app');
		$this->manager->commentaire->setModel('news');
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
		if( ADM_NEWS_LEVEL < $_SESSION['utilisateur']['isAdmin']){
			$this->registry->db->update(PREFIX . 'news', array('commentaire' => 0), array('id =' => $id));
			header('location:'. $this->app->Helper->getLink("news/view/". $id) );
			exit;
		}
		
		return '';
	}
	
	public function unlockCommentaireAction($id){
		if( ADM_NEWS_LEVEL < $_SESSION['utilisateur']['isAdmin']){
			$this->registry->db->update(PREFIX . 'news', array('commentaire' => 1), array('id =' => $id));
			header('location:'. $this->app->Helper->getLink("news/view/". $id) );
			exit;
		}
		
		return '';
	}

}