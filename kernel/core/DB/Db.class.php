<?php if( !defined('IN_VA') ) exit;
/**
 * Edit on 2013 03 14
 * */
class Db{

	public $num_queries = 0;

	public $prepare_query = true;
	
	/**
	*	Requete courante
	*/
	public $query = '';
	
	/**
	*	Array contenant toute les requetes
	*/
	public $queries = array();
	
	/**
	*	Nombre de condition dans le Where pour la requete courante
	*/
	protected $count_where = 0;
	
	/**
	*	Nombre de condition dans Having de la requete courante
	*/
	protected $count_having = 0;
	
	/**
	*	Contient l instance de conexion
	*/
	protected static $instance = null;
    
	/**
	*	Sortie explain des requetes
	*	@inop
	*/
    public $explain = true;
    
	/**
	*	Sortie explain des requetes
	*	@inop
	*/
    public $explain_result = array();
	
		
	public function get_one($table = NULL, $param = NULL, $order = NULL, $limit = NULL, $offset = NULL){
		
		$Rows = $this->get($table, $param, $order, 1, $offset);
		
		if( !empty($Rows) )
			return $Rows[0];
		else
			return false;		
	}
	
	public function select($str){
		$this->query = '';
		$this->count_where = 0;
		$this->count_having = 0;
		
		$this->query = 'SELECT '. $str . ' ';
		return $this;
	}
	
	public function from($table){
		$this->query .= ' FROM '. $table .' ';
		return $this;
	}
	
	/**
	 * Effectue une jointure
	 * @param string $table : table � joindre
	 * @param string $param : parametre de la jointure
	 * @return mixed $this : instance de la class
	 */
	public function join($table, $param){
		$this->query .= ' JOIN ' . $table . ' ON ' . $param . ' ';
		return $this;
	}
	
	public function left_join($table, $param){
		$this->query .= ' LEFT JOIN ' . $table . ' ON ' . $param . ' ';
		return $this;
	}
    
    public function  right_join($table, $param){
        $this->query .= ' RIGHT JOIN ' . $table . ' ON ' . $param . ' ';
        return $this;
    }
	
	public function where($param){
	   
		if( !is_null($param) ):

	        if( !is_array($param)){
	            if( $this->count_where == 0) $this->query .= ' WHERE ' . $param . ' ';
	            else $this->query .= ' AND ' . $param . ' ';
	            $this->count_where ++;
	        }else{
	            foreach($param as $k => $v){
	                if( $this->count_where == 0){ 
						if( strstr($k,'IN') !== FALSE)
							$this->query .= ' WHERE ' . $k . ' "' . $v . '"" ';
						else
							$this->query .= ' WHERE ' . $k . ' "' . $this->quote($v) . '" ';
	                }else{ 
						if( strstr($k,'IN') !== FALSE)
							$this->query .= ' AND ' . $k . ' "' . $v . '" ';
						else
							$this->query .= ' AND ' . $k . ' "' . $this->quote($v) . '" ';
	                
					}
					$this->count_where ++;
	            }// foreach
	        }// else

       	endif;
		
		return $this;
	}// function
    
	public function having($param){
		if( !is_array($param)){
            if( $this->count_having == 0) $this->query .= ' HAVING ' . $param . ' ';
            else $this->query .= ' AND ' . $param . ' ';
            $this->count_having ++;
        }else{
            foreach($param as $k => $v){
                if( $this->count_having == 0){ 
					if( strstr($k,'IN') !== FALSE)
						$this->query .= ' HAVING ' . $k . ' ' . $v . ' ';
					else
						$this->query .= ' HAVING ' . $k . ' ' . $this->quote($v) . ' ';
                }else{ 
					if( strstr($k,'IN') !== FALSE)
						$this->query .= ' AND ' . $k . ' ' . $v . ' ';
					else
						$this->query .= ' AND ' . $k . ' ' . $this->quote($v) . ' ';
                
				}
				$this->count_having ++;
            }// foreach
        }// else
		
		return $this;
	}

    public function where_or($param){
        $this->query .= ' OR ' . $param . ' ';
		return $this;
    }
	
	/**
	 * where_free
	 * Permet l'ajout de paramtre dans la requete de maniere libre
	 *
	 * @param string $str : paramtre a ajouter dans la requete
	 * */
	public function where_free($str){
		if( $this->count_where == 0)
			$this->query .= ' WHERE ' . $str . ' ';
		else
			$this->query .= ' AND ' . $str . ' ';
			
		$this->count_where ++;
		return $this;
	}
    
    public function group_by($str){
        $this->query .= ' GROUP BY ' . $str;
        return $this;
    }
	
	public function order($order){
		$this->query .= ' ORDER BY '. $order . ' ';
		return $this;
	}
	
	public function limit($limit){
		if( is_numeric($limit) ) $this->query .= ' LIMIT ' . $limit . ' ';
		return $this;
	}
	
	public function offset($offset){
		if( is_numeric($offset) ) $this->query .= ' OFFSET ' . $offset . ' ';
		return $this;
	}
	
	
	/*
	public function insert($table, $data){
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
	*/
	
    /**
     * Execute une requete DELETE en passant en paramtre soit l ID ou un array
     * @param string table
     * @param string|int id 
     * @param array
     * @return int nombre de ligne affecte par la requete
     * */
	public function delete($table, $id = NULL , $param = NULL){
		$count_param = 0;
		
		$query = "DELETE FROM ". $table . " ";
		
		if( is_null($param) ){
			$query .= " WHERE id = ". $this->quote($id) . " ";
		}else{
			foreach($param as $k => $v){
			     if($count_param == 0){
			     	 if( is_numeric($v) )$query .= " WHERE ". $k . $v ." ";
			     	else $query .= " WHERE ". $k . $this->quote($v) ." ";
			     } else {
			     	if( is_numeric($v) ) $query .= " AND ". $k . $v . " ";
			     	else $query .= " AND ". $k . $this->quote($v) . " ";
			     } 
				 $count_param++;
			} // foreach
		} // else
		if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
        $Sql = $this->prepare($query);
        
        return $Sql->execute();
	}
	
    /**
     * Execute une requete de type UPDATE
     * @param string $table Table
     * @param array $data Tableau contenant les donn�es array('champ' => 'valeur'). Si Id present dans $data, $param est inutile
     * @param array $param Tableau contenant les paramtre de la clause WHERE array('id = ' => 3)
     * @return int Nombre d element affect� par la requete.
     * */
	public function update($table, $data, $param = NULL){

        // Initialisation des variables
		$set = '';
		$count_param = 0;
		
        // Contruction des donn�es a modifier
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
		$Sql = $this->prepare($Query);
    
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
	*	Execute une requete creer a l aide des select/from/where ... pour recupere le PDOSTATEMENT
	*/
	public function execute(){
		
		return parent::query($this->query);
		
	}
	
	/**
	*	Execute la requete passer en paremetre
	*	Dans le cas d'un select retourne un PDO Statement
	*/
	/*public function query($query){
		if( stripos($query , 'SELECT') === false){
            if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
			return $this->exec($query);
		}else{
            if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
			return parent::query($query);
        }
	}	*/
	
	public function getParamWhere( $Param ){
		$count_param = 0;
		$Where = null;
		foreach($param as $k => $v){
			if( $count_param == 0) $Where = " WHERE ". $k . $this->quote($v) ." ";
			else $Where .= " AND ". $k . $this->quote($v) ." ";
		
			$count_param++;
		}
		return $Where;
	}
}