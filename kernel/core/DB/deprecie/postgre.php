<?php

class Db_postgre extends Db{
	
	protected $Schema;
	private static $instance = null;
	
	public function __construct($dsn = null, $username = null, $password = null, $schema, array $driver_options = array()){
		if(is_null(self::$instance)){
			self::$instance = parent::__construct($dsn, $username, $password, $driver_options);
		}    
	}
	
	public static function getInstance( $dsn = null, $username = null, $password = null, $schema, array $driver_options = array() ){
		if(is_null(self::$instance)){
			return self::$instance = parent::__construct($dsn, $username, $password, $driver_options);    
		}    
		return self::$instance;
	}
	
	public function setSchema(  $Str ){
		$this->Schema = $Str;
	}
	
	public function get( $table = NULL, $param = NULL, $order = NULL, $limit = NULL, $offset = NULL ){
		
		if( is_null($table) && $this->query != ''){
			// On prepare la requete
			$Sql = $this->prepare($this->query);
			
			if(IN_PRODUCTION == FALSE){ $this->queries[] = $this->query; }
			
			// On vide la variable contenant la requete
			$this->query = '';	
		}else{
	
			$Query = ' SELECT table1.* FROM '. $this->Schema . '.' . $table .' table1 ';
			
			$count_param = 0;
			
			if(!is_null($param) && is_array($param) ){
				$Query .= $this->getParamWhere( $param );
			}
            
            if( !is_null($order) ) $Query .= ' ORDER BY ' . $order . ' ';
			
			if( !is_null($limit) ) $Query .= " LIMIT " . $limit . " ";
			if( !is_null($offset) ) $Query .= " OFFSET " . $offset . " ";

			$Sql = $this->prepare($Query);	

			if(IN_PRODUCTION == FALSE){ $this->queries[] = $Query; }			
		}
		
		$Sql->execute();

		$Rows = $Sql->fetchAll(PDO::FETCH_ASSOC);
            
		return $Rows;		
	}
	
	public function from( $table ){
		$this->query .= ' FROM '. $this->Schema . '.' . $table .' ';
		return $this;
	}
	
	public function insert($table, $data){
		$champs = '';
		$valeurs = '';
		
		foreach($data as $k => $v){
			if($champs == '') $champs = ' '. $k .' '; else $champs .= ' , '. $k .' ';
			if($valeurs == '') $valeurs = ' :'. $k .' '; else $valeurs .= ' , :'. $k .' ';
		}
		
		$Sql = $this->prepare('INSERT INTO '. $this->Schema .'.'. $table .' (' . $champs . ' ) VALUES ( ' . $valeurs . ' ) RETURNING id');
		
		foreach($data as $k => $v){
			if( is_numeric($v) ) $Sql->bindValue($k, $v, PDO::PARAM_INT); 
			else $Sql->bindValue($k, $v);			
		}

		if(IN_PRODUCTION == FALSE){ $this->queries[] =  'INSERT INTO '. $table .' (' . $champs . ' ) VALUES ( ' . $valeurs . ' ) ';}
		
        if( isset($data['id']) ) return $Sql->execute();
        else{
            $Sql->execute();
			$Result = $Sql->fetch(PDO::FETCH_ASSOC); 
			$Sql->closeCursor();
			return $Result['id'];
        }		
	}
}