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

class BasenewsManager extends BaseModel{
	
	public function getById($id){
		
		$this->db->select('n.*, u.identifiant, c.name AS categorie')
			->from(PREFIX . 'news n')
			->left_join(PREFIX . 'user u', 'u.id = n.auteur_id')
			->left_join(PREFIX . 'news_categorie c', 'c.id = n.categorie_id')
			->where(array('n.id =' => (int)$id))
			->limit(1);
		
		return $this->db->get_one();
	}
	
	public function getLast($limit = 10){
		
		$this->db->select('n.*, u.identifiant, c.name AS categorie, (SELECT COUNT(id) FROM '. PREFIX . 'news_commentaire WHERE model_id = n.id) AS nb_commentaire')
			->from(PREFIX . 'news n')
			->left_join(PREFIX . 'user u', 'u.id = n.auteur_id')
			->left_join(PREFIX . 'news_categorie c', 'c.id = n.categorie_id')
			->order('n.post_on DESC')
			->limit($limit);
			
		return $this->db->get();
	}
	
	public function getAll($limit, $offset = 0){
		
		$this->db->select('n.*, u.identifiant, c.name AS categorie')
			->from(PREFIX . 'news n')
			->left_join(PREFIX . 'user u', 'u.id = n.auteur_id')
			->left_join(PREFIX . 'news_categorie c', 'c.id = n.categorie_id')
			->order('n.post_on DESC')
			->limit($limit)
			->offset($offset);
			
		return $this->db->get();
	}
	
	/**
	 * Retourne le nombre de news dans la base
	 * @return int : nombre de news
	 */
	public function count(){
		return $this->db->count(PREFIX . 'news');
	}
}