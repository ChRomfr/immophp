<?php

class Config {

	protected $db;

	protected $config = array();

	public function __construct(){
		global $db;

		$this->db = $db;
	}

	public function set(array $config){
		$this->config = $config;
	}

	public function save(){

		# On boucle sur le tableau
		foreach($this->config as $k => $v):
			# On verifie si le parametre existe en base
			if( $this->db->count(PREFIX . 'config', array('cle =' => $k), 'cle' ) == 0  ):
				$this->db->insert(PREFIX . 'config', array('cle' => $k, 'valeur' => $v) );
			else:
				$this->db->update(PREFIX . 'config', array('valeur' => $v), array('cle =' => $k) );
			endif;
		endforeach;
	}

	public function get($param=null){

		if( empty($this->config) ):

			if( is_null($param) ):
				$tmp = $app->db->get(PREFIX . 'config');
				
				foreach($tmp as $data):
					$this->config[$data['cle']] = $data['valeur'];
				endforeach;

			else:
				$tmp = $this->db->select('cle, valeur')->from(PREFIX . 'config')->where_free('cle LIKE "'. $param .'_%"')->get();

				foreach($tmp as $data):
					$this->config[$data['cle']] = $data['valeur'];
				endforeach;
			endif;
		endif;

		return $this->config;
	}

}