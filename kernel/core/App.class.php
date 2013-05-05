<?php

abstract class App{
	
	public $tpl;

	public $smarty;

	public $Http;

	public $db;

	public $Helper;

	public $cache;

	public function __construct($Registry){

		// On passe les services
		$this->tpl = $Registry->smarty;
		$this->smarty = $Registry->smarty;
		$this->Http = $Registry->Http;
		$this->db = $Registry->db;
		$this->cache = $Registry->cache;
		$this->Helper = $Registry->Helper;

	}

}