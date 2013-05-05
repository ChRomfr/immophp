<?php if(!defined('IN_VA')) exit;

abstract class BaseModel {
	
	protected $db;
	
	protected $cache;
	
	public function  __construct() {
		global $db;
		$this->db = $db;
	}
}