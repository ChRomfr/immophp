<?php

abstract class Basefeedrsscontroller extends Controller{
	

	public function indexAction(){

		# Categorie
		$Tree = new Tree($this->app->db, PREFIX . 'feed_rss_link_categorie');

		if( $this->app->HTTPRequest->getExists('cid') ): 
			$categorie_id = $this->app->HTTPRequest->getData('cid');
			$Categorie = $this->app->db->get_one(PREFIX . 'feed_rss_link_categorie', array('id =' => $categorie_id));
			$Categories = $this->app->db->get(PREFIX . 'feed_rss_link_categorie', array('parent_id =' => $categorie_id), 'name');
			$Parents = $Tree->getParent($Categorie['lft'], $Categorie['rght']);
			
			$this->app->smarty->assign(array(
				'Parents'		=>	$Parents,
				'Categorie'		=>	$Categorie,
			));
		else:
			$categorie_id = 0;	
			$Categories = $this->app->db->get(PREFIX . 'feed_rss_link_categorie', array('parent_id =' => 0), 'name');
		endif;

		$Where = array('frl.actif =' => 1);

		if( $categorie_id != 0 ):
			$Where['frl.categorie_id ='] = $categorie_id;

			$Result = $this->app->db
						->select('count(fri.id) as NbItems')
						->from(PREFIX . 'feed_rss_item fri')
						->left_join(PREFIX . 'feed_rss_link frl', 'fri.feed_rss_link_id = frl.id')
						->where($Where)
						->get_one();

			$NbItems = $Result['NbItems'];
		else:
			$NbItems = $this->app->db->count(PREFIX . 'feed_rss_item');
		endif;

		$item_by_page = 10;

		$Items =	$this->app->db
						->select('fri.*, frl.name as source, frl.link as source_link')
						->from(PREFIX . 'feed_rss_item fri')
						->left_join(PREFIX . 'feed_rss_link frl', 'fri.feed_rss_link_id = frl.id')
						->where($Where)
						->order('fri.date DESC')
						->limit($item_by_page)
						->offset( getOffset($item_by_page) )
						->get();

		$Pagination = new Zebra_Pagination();
		$Pagination->records($NbItems);
		$Pagination->records_per_page($item_by_page);

		$this->app->smarty->assign(array(
			'Items'			=>	$Items,
			'Pagination'	=>	$Pagination,
			'Categories'	=>	$Categories,
		));

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'feedrss' . DS . 'index.tpl');

	}

	public function burnAction(){

		ignore_user_abort(true);
		set_time_limit(0);

		/*if( $this->app->config['feedrss_last_time'] > time() - 3600 ):
			# On arrete le script 
			exit;
		endif;*/

		# Recuperation des flux dans la base
		$Flux = $this->app->db->get(PREFIX . 'feed_rss_link');

		foreach( $Flux as $Row ):
			# On lit le flux
			$Data = new Feed($Row['link']);	

			# On verifie si le flux est en base de donnees
			foreach ($Data->find(10) as $item):
				# On verifie si l url deja dans la base
				$Result = $this->app->db->count(PREFIX . 'feed_rss_item', array('link =' => isset($item->link) ? trim($item->link) : trim($item->url) ));

				# On enregistre le lien dans la base
				if($Result == 0):
					$Array = array(
						'title'				=>	trim($item->title),
						'link'				=>	isset($item->link) ? trim($item->link) : trim($item->url),
						'description'		=>	$item->description,
						'feed_rss_link_id'	=>	$Row['id'],
						'date'				=>	$item->date,
						'image'				=>	$item->image,
					);
					$this->app->db->insert(PREFIX . 'feed_rss_item', $Array);
				endif;
			endforeach;
		endforeach;
	}

}