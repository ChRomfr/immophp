<?php

abstract class Basexmlcontroller extends Controller{

    public function indexAction(){



    }

	/**
	 * Genere le flux des 10 dernieres news du site
	 * @return [type] [description]
	 */
	public function fluxRSSNewsAction(){

		$XML = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0">';
            $XML .='<channel>';
                $XML .= '<title>'. $this->app->config['titre_site'] .'</title>';
                $XML .= '<description>'. $this->app->config['description_site'] .'</description>';
                $XML .= '<link>'. $this->app->config['url'] . $this->app->config['url_dir'] . '</link>';
                $XML .= '<pubDate>'. date('r',time()) . '</pubDate>';
                $XML . '<lastBuildDate>'. date('r',time()) .'</lastBuildDate>';
                
        $Data = $this->app->db->get(PREFIX . 'news', null, 'post_on DESC', 10);
        
        foreach($Data as $Row):
            $XML .= '<item>';
                $XML .= '<title>' . $Row['sujet'] .'</title>';
                $XML .= '<link>' . $this->app->Helper->getLink("news/detail/". $Row['id'] ."/". urlencode($Row['sujet']) ." " ) .'</link>';
                $XML .= '<description><![CDATA[';
                $XML .= $Row['contenu'] . ']]></description>';
                $XML .= '<guid>'. $Row['id'] . '</guid>';
                $XML .= '<pubDate>'. date('r',$Row['post_on']) . '</pubDate>';
            $XML .= '</item>';
        endforeach;
        
        $XML .= '</channel></rss>';
        
        header("Content-Type: application/rss+xml");
        echo $XML;
        exit;
	}

	/**
	 * Genere le flux des 10 derniers articles du site
	 * @return [type] [description]
	 */
	public function fluxRSSArticleAction(){

		$XML = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0">';
            $XML .='<channel>';
                $XML .= '<title>'. $this->app->config['titre_site'] .'</title>';
                $XML .= '<description>'. $this->app->config['description_site'] .'</description>';
                $XML .= '<link>'. $this->app->config['url'] . $this->app->config['url_dir'] . '</link>';
                $XML .= '<pubDate>'. date('r',time()) . '</pubDate>';
                $XML . '<lastBuildDate>'. date('r',time()) .'</lastBuildDate>';
                
        $Data = $this->app->db->get(PREFIX . 'article', array('visible =' => 1), 'creat_on DESC', 10);
        
        foreach($Data as $Row):
            $XML .= '<item>';
                $XML .= '<title>' . $Row['title'] .'</title>';
                $XML .= '<link>' . $this->app->Helper->getLink("article/read/". $Row['id'] ."/". urlencode($Row['title']) ." " ) .'</link>';
                $XML .= '<description><![CDATA[';
                	if( isset($Row['image']) && !empty($Row['image']) ):
                    $XML .= '<img src="'. $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/article/'. $Row['id'] .'/'. $Row['image'] .'" style="width:150px;"/>';
                    endif;
                $XML .= $Row['article'] . ']]></description>';
                $XML .= '<guid>'. $Row['id'] . '</guid>';
                $XML .= '<pubDate>'. date('r',$Row['creat_on']) . '</pubDate>';
            $XML .= '</item>';
        endforeach;
        
        $XML .= '</channel></rss>';
        
        header("Content-Type: application/rss+xml");
        echo $XML;
        exit;

	}

	/**
	 * Genere le flux des 10 derniere telechargement
	 * @return [type] [description]
	 */
	public function fluxRSSDownloadAction(){
		$XML = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0">';
            $XML .='<channel>';
                $XML .= '<title>'. $this->app->config['titre_site'] .'</title>';
                $XML .= '<description>'. $this->app->config['description_site'] .'</description>';
                $XML .= '<link>'. $this->app->config['url'] . $this->app->config['url_dir'] . '</link>';
                $XML .= '<pubDate>'. date('r',time()) . '</pubDate>';
                $XML . '<lastBuildDate>'. date('r',time()) .'</lastBuildDate>';
                
        $Data = $this->app->db->get(PREFIX . 'download', array('visible =' => 1), 'add_on DESC', 10);
        
        foreach($Data as $Row):
            $XML .= '<item>';
                $XML .= '<title>' . $Row['name'] .'</title>';
                $XML .= '<link>' . $this->app->Helper->getLink("download/detail/". $Row['id'] ."/". urlencode($Row['name']) ." " ) .'</link>';
                $XML .= '<description><![CDATA[';
                	if( isset($Row['apercu']) && !empty($Row['apercu']) ):
                    $XML .= '<img src="'. $this->app->config['url'] . $this->app->config['url_dir'] . 'web/upload/download/'. $Row['id'] .'/'. $Row['apercu'] .'" style="width:150px;"/>';
                    endif;
                $XML .= $Row['description'] . ']]></description>';
                $XML .= '<guid>'. $Row['id'] . '</guid>';
                $XML .= '<pubDate>'. $Row['add_on'] .'</pubDate>';
            $XML .= '</item>';
        endforeach;
        
        $XML .= '</channel></rss>';
        
        header("Content-Type: application/rss+xml");
        echo $XML;
        exit;
	}

    public function fluxRSSForumAction($forum_id){

        $this->load_manager('forum', 'base_app');

        # Recuperation des 10 derniers topics du forum
        $Topics = $this->manager->forum->getThreadByForumId($forum_id);

        # On boucle sur le topic pour recuperer le 1er message
        $i = 0;
        foreach( $Topics as $Topic ):
            $Topics[$i]['message'] = $this->app->db->get_one(PREFIX . 'forum_message', array('thread_id =' => $Topic['id']), 'add_on ASC');
            $i++;
        endforeach;

        $XML = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0">';
            $XML .='<channel>';
                $XML .= '<title>'. $this->app->config['titre_site'] .'</title>';
                $XML .= '<description>'. $this->app->config['description_site'] .'</description>';
                $XML .= '<link>'. $this->app->config['url'] . $this->app->config['url_dir'] . '</link>';
                $XML .= '<pubDate>'. date('r',time()) . '</pubDate>';
                $XML . '<lastBuildDate>'. date('r',time()) .'</lastBuildDate>';

         foreach($Topics as $Row):
            $XML .= '<item>';
                $XML .= '<title>' . $Row['titre'] .'</title>';
                $XML .= '<link>' . $this->app->Helper->getLink("forum/viewtopic/". $Row['id'] ."/". urlencode($Row['titre']) ." " ) .'</link>';
                $XML .= '<description><![CDATA[';
                $XML .= BBCode2Html($Row['message']['message']) . ']]></description>';
                $XML .= '<guid>'. $Row['id'] . '</guid>';
                $XML .= '<pubDate>'. $Row['add_on'] .'</pubDate>';
            $XML .= '</item>';
        endforeach;
        
        $XML .= '</channel></rss>';
        
        header("Content-Type: application/rss+xml");
        echo $XML;
        exit;

    }

    /**
     * Genere le site map sur les modules de base
     * @return [type] [description]
     */
	public function sitemapAction(){

        $XML = '<url><loc>'. $this->app->config['url'] . $this->app->config['url_dir'] . '</loc></url>';
        $XML .= '<url><loc>'. $this->app->Helper->getLink("contact") . '</loc></url>';
        $XML .= '<url><loc>'. $this->app->Helper->getLink("connexion") . '</loc></url>';
        $XML .= '<url><loc>'. $this->app->Helper->getLink("utilisateur") . '</loc></url>';

        # News
        $XML .= '<url><loc>'. $this->app->Helper->getLink("news") . '</loc></url>';

        $Data = $this->app->db->get(PREFIX . 'news');

        foreach( $Data as $Row ):
            $XML .= '<url><loc>'. $this->app->Helper->getLink("news/view/" . $Row['id']) . '</loc></url>';
        endforeach;

        # Articles
        $XML .= '<url><loc>'. $this->app->Helper->getLink("article") . '</loc></url>';

        $Data = $this->app->db->get(PREFIX . 'article');

        foreach( $Data as $Row ):
            $XML .= '<url><loc>'. $this->app->Helper->getLink("article/read/" . $Row['id']) . '</loc></url>';
        endforeach;

        $Data = $this->app->db->get(PREFIX . 'article_categorie');

        foreach( $Data as $Row ):
            $XML .= '<url><loc>'. $this->app->Helper->getLink("article/index?cid=" . $Row['id']) . '</loc></url>';
        endforeach;

        # Telechargement
        $XML .= '<url><loc>'. $this->app->Helper->getLink("download") . '</loc></url>';

        $Data = $this->app->db->get(PREFIX . 'download');

        foreach( $Data as $Row ):
            $XML .= '<url><loc>'. $this->app->Helper->getLink("download/detail/" . $Row['id']) . '</loc></url>';
        endforeach;

        $Data = $this->app->db->get(PREFIX . 'download_categorie');

        foreach( $Data as $Row ):
            $XML .= '<url><loc>'. $this->app->Helper->getLink("download/index?cid=" . $Row['id']) . '</loc></url>';
        endforeach;

        # Page
        $Data = $this->app->db->get(PREFIX . 'page');

        foreach( $Data as $Row ):
            $XML .= '<url><loc>'. $this->app->Helper->getLink("page/index/" . $Row['id']) . '</loc></url>';
        endforeach;

        # mod_feed_rss
        if( $this->app->config['mod_feed_rss'] == 1):
            
            $XML .= '<url><loc>'. $this->app->Helper->getLink("feedRss") . '</loc></url>';

            # Liste des categories
            $Data = $this->app->db->get(PREFIX . 'feed_rss_link_categorie');

            foreach( $Data as $Row ):
                $XML .= '<url><loc>'. $this->app->Helper->getLink("feedRss/index?cid=" . $Row['id']) . '</loc></url>';
            endforeach;

            # On compte le nombre de liens pour la pagination
            $NbItems = $this->app->db->count(PREFIX . 'feed_rss_item');

            # On divise par 10 pour avoir le nombre de page
            $NbPage = round( ($NbItems/10), 0, PHP_ROUND_HALF_DOWN );

            for($i = 0; $i <= $NbPage; $i++):
                if( $i > 0):
                    $XML .= '<url><loc>'. $this->app->Helper->getLink("feedRss/index?page=" . $i) . '</loc></url>';
                endif;
            endfor;

        endif;

        # Annuaire
        if( $this->app->config['mod_annuaire'] == 1):

            $XML .= '<url><loc>'. $this->app->Helper->getLink("annuaire") . '</loc></url>';

            # Liste des categories
            $Data = $this->app->db->get(PREFIX . 'annuaire_categorie');

            foreach( $Data as $Row ):
                $XML .= '<url><loc>'. $this->app->Helper->getLink("annuaire/index?cid=" . $Row['id']) . '</loc></url>';
            endforeach;

            # On recuperer les sites et on boucle
            $Data = $this->app->db->get(PREFIX . 'annuaire_site', array('visible =' => 1, 'status =' => 'valid') );

            foreach( $Data as $Row ):
                $XML .= '<url><loc>'. $this->app->Helper->getLink("annuaire/detail/" . $Row['id']) . '</loc></url>';
            endforeach;

        endif;

        # Link
        if( $this->app->config['mod_link'] == 1):

            $XML .= '<url><loc>'. $this->app->Helper->getLink("link") . '</loc></url>';

            # Liste des categories
            $Data = $this->app->db->get(PREFIX . 'link_categorie');

            foreach( $Data as $Row ):
                $XML .= '<url><loc>'. $this->app->Helper->getLink("link/index?cid=" . $Row['id']) . '</loc></url>';
            endforeach;

            # On recuperer les sites et on boucle
            $Data = $this->app->db->get(PREFIX . 'link', array('actif =' => 1) );

            foreach( $Data as $Row ):
                $XML .= '<url><loc>'. $this->app->Helper->getLink("link/detail/" . $Row['id']) . '</loc></url>';
            endforeach;

        endif;

        # Forum
        if( $this->app->config['mod_forum'] == 1):
            # Recuperation des forums
            $Data = $this->app->db->get(PREFIX . 'forum', array('visible =' => 1));

            foreach( $Data as $Row ):
                $XML .= '<url><loc>'. $this->app->Helper->getLink("forum/viewforum/" . $Row['id']) . '</loc></url>';
            endforeach;

            # Topic
            $Data = $this->app->db->select('id')->from(PREFIX . 'forum_thread')->order('add_on DESC')->get();

            foreach( $Data as $Row ):
                $XML .= '<url><loc>'. $this->app->Helper->getLink("forum/viewtopic/" . $Row['id']) . '</loc></url>';
            endforeach;

        endif;

        return $XML;

    }

}