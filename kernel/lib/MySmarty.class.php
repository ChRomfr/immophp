<?php
class MySmarty extends Smarty{
	
	private 	$container;
	
	protected	$_cache_tpl_db = 1;
	
	protected	$_use_tpl_perso = 1;
	
	protected	$_tpls;
	
	public		$tpls_used = array();
	
	public function __construct( $container ){

		$this->container = $container;
		parent::__construct();
		$this->debugging = false;
		$this->template_dir = VIEW_PATH;
		$this->compile_dir = CACHE_PATH; 	// Repertoire du cache compilé
		$this->cache_dir = CACHE_PATH;   	// Repertoire du cache
		$this->cache_lifetime = 3600; 		// Duree de vie du cache
		$this->caching = false;

		$this->php_handling = self::PHP_ALLOW;
		
		if( $this->_use_tpl_perso == 1 && $this->_cache_tpl_db == 1 ):
		
			if( !$this->_tpls = $this->container->cache->get("templates_in_db") ):	
			
				// Recuperation des templates en base
				$tmp = $this->container->db->get(PREFIX . 'view_template', array('active =' => 1) );
				
				// On boucle sur le resultat pour le mettre dans la viariable
				foreach( $tmp as $row ):
					$this->_tpls[''. $row['real_dir'] .''] = $row['tpl'];
				endforeach;
				
				// On sauvegarde le resultat en cache
				$this->container->cache->save( serialize($this->_tpls) );
			else:
				$this->_tpls = unserialize($this->_tpls);
			endif;
			
		endif;
		
	}
	
	/**
	*	Surcharge de la fonction FETCH pour verifier si le TPL existe en base de donnees
	*
	*/ 
	public function fetch( $template = null, $cache_id = null, $compile_id = null, $parent = null, $display = false, $merge_tpl_vars = true, $no_output_filter = false ){

		# On traite le cas particulier du previews depuis l administration
		if( isset($_GET['preview_template']) && isset($_GET['token']) ):
			$file_search = str_replace(ROOT_PATH,'',$template);
			$file_search = str_replace(DS,'_',$file_search);
		endif;
		
		if( isset($_GET['preview_template']) && isset($_GET['token']) && $file_search == $_GET['template']):

			$this->debugging = true;

			# Recuperation dans la base de la vue
			$Tpl = $this->container->db->get_one(PREFIX . 'view_template', array('token =' => $_GET['token'])) ;

			# On verifie que la requete retourne un resultat
			if( empty($Tpl) ):
				exit('Requete invalide');
			endif;
			
			# On genere le design et retourne et on l affiche
			return parent::fetch('string:' . $Tpl['tpl'], $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);

		endif;

		if( $this->_use_tpl_perso == 1 ):
		
			$file_search = str_replace(ROOT_PATH,'',$template);
			$file_search = str_replace(DS,'_',$file_search);
			
			if( IN_PRODUCTION == FALSE):
				$this->tpls_used[$template] = $file_search;
			endif;
				
			if( $this->_cache_tpl_db == 1 && isset($this->_tpls[$file_search]) ):
				return parent::fetch('string:' . $this->_tpls[$file_search], $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);
			elseif( !isset($this->_tpls[$file_search]) &&  $this->_cache_tpl_db == 1):
				goto normal_fetch;
			elseif( $this->_cache_tpl_db == 0 ):
				$_tpl = $this->container->db->get_one(PREFIX . 'view_template', array('real_dir =' => $file_search, 'active =' => 1) );
			endif;
			
			
			if( !empty($_tpl) && is_array($_tpl) ):
				return parent::fetch('string:' . $_tpl['tpl'], $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);
			endif;
		endif;
		
		normal_fetch:
		return parent::fetch($template, $cache_id, $compile_id, $parent, $display, $merge_tpl_vars, $no_output_filter);
		
	}
}
?>