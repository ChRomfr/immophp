<?php

class xmlController extends Basexmlcontroller{
    
    public function rssAction(){
        
        $XML = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0">';
            $XML .='<channel>';
                $XML .= '<title>'. $this->app->config['titre_site'] .'</title>';
                $XML .= '<description>'. $this->app->config['description_site'] .'</description>';
                $XML .= '<link>'. $this->app->config['url'] . $this->app->config['url_dir'] . '</link>';
                $XML .= '<pubDate>'. date('r',time()) . '</pubDate>';
                $XML . '<lastBuildDate>'. date('r',time()) .'</lastBuildDate>';
                
        $Biens = $this->GiveMeBiens();
        
        foreach($Biens as $Row):
            $XML .= '<item>';
                $XML .= '<title>' . $Row['nom'] .'</title>';
                $XML .= '<link>' . getLink("annonce/detail/". $Row['id'] ."/". urlencode($Row['nom']) ." " ) .'</link>';
                $XML .= '<description><![CDATA[';
                    if( isset($Row['photo']) ):
                    $XML .= '<img src="'. $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/bien/'. $Row['id'] .'/'. $Row['photo'] .'" style="width:150px;"/>';
                    endif;
                $XML .= $Row['description'] . ']]></description>';
                $XML .= '<guid>'. $Row['id'] . '</guid>';
                $XML .= '<pubDate>'. date('r',$Row['add_on']) . '</pubDate>';
            $XML .= '</item>';
        endforeach;
        
        $XML .= '</channel></rss>';
        
        header("Content-Type: application/rss+xml");
        echo $XML;
        exit;
    }
    
    public function sitemapAction(){
        
    }
    
    private function GiveMeBiens(){
        $Param = null;
        
        if( $this->app->HTTPRequest->getExists('criteres') ):
            $Criteres = $this->app->HTTPRequest->getData('criteres');
        
            // On constuit les parametres de recherche
            $Param = array();
            
            if( isset($Criteres['transaction']) || !empty($Criteres['transaction']) ):
                $Param['transaction ='] = $Criteres['transaction'];
            endif;            
            
            if( !empty($Criteres['agence']) && is_numeric($Criteres['agence']) ):
                $Param['b.agence_id ='] = $Criteres['agence'];
            endif;
            
            if( !empty($Criteres['categorie']) && is_numeric($Criteres['categorie']) ):
                $Param['b.categorie_id ='] = $Criteres['categorie'];
            endif;
            
            if( !empty($Criteres['prix_min']) && is_numeric($Criteres['prix_min']) ):
                $Param['b.prix >='] = $Criteres['prix_min'];
            endif;
            
             if( !empty($Criteres['prix_max']) && is_numeric($Criteres['prix_max']) ):
                $Param['b.prix <='] = $Criteres['prix_max'];
            endif;
            
            if( !empty($Criteres['surface_min']) && is_numeric($Criteres['surface_min']) ):
                $Param['b.surface >='] = $Criteres['surface_min'];
            endif;
            
             if( !empty($Criteres['surface_max']) && is_numeric($Criteres['surface_max']) ):
                $Param['b.surface <='] = $Criteres['surface_max'];
            endif;
            
        endif;
        
        $this->load_manager('bien');
        
        $Biens = $this->manager->bien->getAllForXML($Param);              
        
        $i=0;
        foreach( $Biens as $Bien):
            $Biens[$i]['photos'] = getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'bien' . DS . $Bien['id']);
            $y=1;
            foreach ($Biens[$i]['photos'] as $k => $v):
               $Biens[$i]['photo'] = $v; 
               if( $y == 1):
                   break;
               endif;
            endforeach;         
            $i++;
        endforeach;
        
        return $Biens;
    }
    
}
