<?php

class pdomysql extends dbpdo{


	public static function getInstance($dsn = null, $username = null, $password = null, array $driver_options = array()){  

		if(is_null(self::$instance)){
			return self::$instance = new pdomysql($dsn, $username, $password, $driver_options);;    
		}  

		return self::$instance; 
	}
	
	public function query($query){
		
		if( stripos($query , 'SELECT') === false):
            if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
  			$this->num_queries++;
			return parent::exec($query);
		else:
            if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
        	$this->num_queries++;
			return parent::query($query);
        endif;
	}

	public function get($table = NULL, $param = NULL, $order = NULL, $limit = NULL, $offset = NULL){
		$this->num_queries++;
	
		if( is_null($table) && $this->query != ''):
			# On prepare la requete
			$Sql = parent::prepare($this->query);
			
			if(IN_PRODUCTION == FALSE){ $this->queries[] = $this->query; }
			
			# On vide la variable contenant la requete
			$this->query = '';	
		else:	
			$Query = " SELECT * FROM ". $table ." ";
			
			$count_param = 0;
			
			if(!is_null($param) && is_array($param) ){
				foreach($param as $k => $v){
					if( $count_param == 0) $Query .= " WHERE ". $k . $this->quote($v) ." ";
					else $Query .= " AND ". $k . $this->quote($v) ." ";
					
					$count_param++;
				}
			}
            
            if( !is_null($order) ) $Query .= ' ORDER BY ' . $order . ' ';
			
			if( !is_null($limit) ) $Query .= " LIMIT " . $limit . " ";
			if( !is_null($offset) ) $Query .= " OFFSET " . $offset . " ";

			$Sql = $this->prepare($Query);	

			if(IN_PRODUCTION == FALSE){ $this->Db->queries[] = $Query; }			
		endif;
		
		# Execute query
		$Sql->execute();
		
		# Recuperation des resultats
		$Rows = $Sql->fetchAll(PDO::FETCH_ASSOC);
        
		# On retourne le resultats
		return $Rows;
	}
	
	public function insert($table, $data){
		$this->num_queries++;

		$champs = '';
		$valeurs = '';
		
		foreach($data as $k => $v){
			if($champs == '') $champs = ' `'. $k .'` '; else $champs .= ' , `'. $k .'` ';
			if($valeurs == '') $valeurs = ' :'. $k .' '; else $valeurs .= ' , :'. $k .' ';
		}
		
		$Sql = $this->prepare('INSERT INTO '. $table .' (' . $champs . ' ) VALUES ( ' . $valeurs . ' ) ');
		
		foreach($data as $k => $v){
			if( is_numeric($v) ) $Sql->bindValue($k, $v, PDO::PARAM_INT); 
			else $Sql->bindValue($k, $v);			
		}

		if(IN_PRODUCTION == FALSE){ $this->queries[] =  'INSERT INTO '. $table .' (' . $champs . ' ) VALUES ( ' . $valeurs . ' ) ';}
		
        if( isset($data['id']) ) return $Sql->execute();
        else{
            $Sql->execute();
            return $this->LastInsertId();
        }		
	}

	public function update($table, $data, $param = NULL){
		$this->num_queries++;

        // Initialisation des variables
		$set = '';
		$count_param = 0;
		
        // Contruction des données a modifier
		foreach($data as $k => $v){
			if( $set == '') $set = ' SET `'. $k . '` = :'. $k .' ';
			else $set .= ' , `'. $k . '` = :'. $k . ' ';
		}
		
        // Construction des parametre de la requete
		if( is_null($param) ) $Query = 'UPDATE '. $table . ' ' . $set . ' WHERE id = :id ';
		else{
			$Query = 'UPDATE '. $table . ' ' . $set . ' ';
			foreach($param as $k => $v){
				if( $count_param == 0) $Query .= " WHERE ". $k . $this->quote($v) ." ";
				else $Query .= " AND ". $k . $this->quote($v) ." ";
				
				$count_param++;
			}
		}
		if(IN_PRODUCTION == FALSE){ $this->queries[] = $Query; }
        // Preparation
		$Sql = parent::prepare($Query);
    
        // Assignation des valeur
		foreach($data as $k => $v){
			if( is_numeric($v) ) $Sql->bindValue($k, $v, PDO::PARAM_INT); 
			else $Sql->bindValue($k, $v);			
		}
		
		// Traitement de l ID passe en $data
		if( is_null($param) ){
			if( is_numeric($data['id']) ) $Sql->bindValue('id', $data['id'], PDO::PARAM_INT); 
			else $Sql->bindValue('id', $data['id']);
		}
		
        // Execution des requetes
		return $Sql->execute();	
	}

	/**
	*	count
	*	Retourne la valeur de fonctin COUNT() SQL. 
	*	@param string $table
	*	@param array parametre de tri
	*	@param string $champ colone pour effectuer le COUNT()
	*	@return int $Row valeur de COUNT()
	*
	*/
	public function count($table, $param = NULL, $champ = 'id'){
		$this->num_queries++;
		
		$count_where = 0;
	
		$query = 'SELECT COUNT('. $champ .') FROM '. $table .' ';
		
		if( !is_null($param) && is_array($param) ){
			foreach($param as $k => $v){
				if( $count_where == 0) $query .= ' WHERE '. $k . $this->quote($v) .' ';
				else $query .= ' AND '. $k . $this->quote($v) .' ';
                $count_where++;
			}			
		}elseif( !is_array($param) ){
			$count_where++;
			$query .= $param;
		}
		
		$Sql = $this->query($query);
		
        if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
        
		$Row = $Sql->fetchColumn();
		$Sql->closeCursor();
		return $Row;
	}
	
}