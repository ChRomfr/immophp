<?php

class MyCache extends Cache_Lite{
	
	private	$registry;
	
	private $_instance;
	
	public function __construct($registry){
		
		$this->registry = $registry;
		parent::__construct(array('cacheDir' =>	ROOT_PATH . 'cache'. DS));
	}
	
}