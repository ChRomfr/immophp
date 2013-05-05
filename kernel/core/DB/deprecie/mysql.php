<?php

class Db_mysql extends Db{	
	
	public function __construct( $dsn = null, $username = null, $password = null, array $driver_options = array() ){
		return parent::getInstance( $dsn, $username, $password, $driver_options );		
	}
	
}