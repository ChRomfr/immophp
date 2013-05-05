<?php

class dbmysqli extends Db{

	protected $mysqli;

	public function __construct($serveur, $base, $utilisateur, $password){
		$this->mysqli = new mysqli($serveur, $utilisateur, $password, $base);

		if ($this->mysqli->connect_error) {
    			die('Erreur de connexion (' . $mysqli->connect_errno . ') ' . $mysqli->connect_error);
		}
		//return self::$instance = mysqli_connect();
	}

	public static function getInstance($server = null, $base = null, $username = null, $password = null){  
	
		if(is_null(self::$instance)):
			return self::$instance = new dbmysqli($server, $base, $username, $password);     
		endif;
		
		return self::$instance; 
	}
	
	public function quote($str){
		if( is_array($str) ):
		WriteInFile('MYSQLI : ' . serialize($str). " \n\n\n Requete : ". $this->query ."\n\n\n PAGE : ". $_SERVER['REQUEST_URI'] ."\n");
		endif;

		return $this->mysqli->real_escape_string($str);
	}
	
	/**
	*	Execute une requete simple et retourne un jeu de resultat
	*	@param string $query
	*	@return 
	*/
	public function query($query){
		if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
		$this->num_queries++;

		$Result = $this->mysqli->query($query);

		if( $Result === false):
			WriteInFile('Error mysqli : ' . $this->mysqli->error . ' Requete : ' . $query . "\n");
			print( 'Error mysqli : ' . $this->mysqli->error );
		endif;

		return $Result; 
	}
	
	public function get($table = NULL, $param = NULL, $order = NULL, $limit = NULL, $offset = NULL){
	
		if( is_null($table) && $this->query != ''){
			# On prepare la requete
			$Sql = $this->query($this->query);
			
			if(IN_PRODUCTION == FALSE){ $this->queries[] = $this->query; }
			
			# On vide la variable contenant la requete
			$this->query = null;
		}else{
	
			$Query = " SELECT * FROM ". $table ." ";
			
			$count_param = 0;
			
			if(!is_null($param) && is_array($param) ){
				foreach($param as $k => $v){
					if( $count_param == 0) $Query .= " WHERE ". $k .  "'" . $this->quote($v) ."' ";
					else $Query .= " AND ". $k . "'" . $this->quote($v) ."' ";
					
					$count_param++;
				}
			}
            
            if( !is_null($order) ) $Query .= ' ORDER BY ' . $order . ' ';
			
			if( !is_null($limit) ) $Query .= " LIMIT " . $limit . " ";
			if( !is_null($offset) ) $Query .= " OFFSET " . $offset . " ";

			if(IN_PRODUCTION == FALSE){ $this->queries[] = $Query; }

			$Sql = $this->query($Query);			
		}
		
		$Rows = $Sql->fetch_all(MYSQLI_ASSOC);
        
		return $Rows;
	}
	
	public function insert($table, $data){
		$champs = '';
		$valeurs = '';
		
		foreach($data as $k => $v):
			if($champs == '') $champs = ' `'. $k .'` '; else $champs .= ' , `'. $k .'` ';
			if($valeurs == '') $valeurs = '"'. $this->quote($v) .'"'; else $valeurs .= ',"'. $this->quote($v) .'"';
		endforeach;
		
		$Sql = $this->query('INSERT INTO '. $table .' (' . $champs . ' ) VALUES ( ' . $valeurs . ' ) ');

		if(IN_PRODUCTION == FALSE):
			$this->queries[] =  'INSERT INTO '. $table .' (' . $champs . ' ) VALUES ( ' . $valeurs . ' ) ';
		endif;
		
        if( !isset($data['id']) ):
			return $this->mysqli->insert_id;
        endif;
	}

	 /**
     * Execute une requete de type UPDATE
     * @param string $table Table
     * @param array $data Tableau contenant les données array('champ' => 'valeur'). Si Id present dans $data, $param est inutile
     * @param array $param Tableau contenant les paramtre de la clause WHERE array('id = ' => 3)
     * @return int Nombre d element affecté par la requete.
     * */
	public function update($table, $data, $param = NULL){

        // Initialisation des variables
		$set = '';
		$count_param = 0;
		
        // Contruction des données a modifier
		foreach($data as $k => $v):
			if( $set == ''):
				$set = ' SET `'. $k . '` = "'. $this->quote($v) .'" ';
			else:
				 $set .= ' , `'. $k . '` = "'. $this->quote($v) . '" ';
			endif;
		endforeach;
		
        // Construction des parametre de la requete
		if( is_null($param) ):
			$Query = 'UPDATE '. $table . ' ' . $set . ' WHERE id = "'. $this->quote($data['id']) .'" ';
		else:
			$Query = 'UPDATE '. $table . ' ' . $set . ' ';
			foreach($param as $k => $v){
				if( $count_param == 0) $Query .= " WHERE ". $k . "'". $this->quote($v) . "' ";
				else $Query .= " AND ". $k . "'". $this->quote($v) ."' ";
				
				$count_param++;
			}
		endif;

		if(IN_PRODUCTION == FALSE){ $this->queries[] = $Query; }
        // Preparation
		$Sql = $this->mysqli->query($Query);
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
		# Init compteur
		$count_where = 0;
	
		# Construction requete
		$query = 'SELECT COUNT('. $champ .') FROM '. $table .' ';
		
		if( !is_null($param) && is_array($param) ){
			foreach($param as $k => $v){
				if( $count_where == 0) $query .= ' WHERE '. $k .'"'. $this->quote($v) .'" ';
				else $query .= ' AND '. $k . '"'. $this->quote($v) .'" ';
                $count_where++;
			}			
		}elseif( !is_array($param) ){
			$count_where++;
			$query .= $param;
		}
		
		# Execution de la requete
		$Sql = $this->mysqli->query($query);
		
		# On stocke la requete
        if(IN_PRODUCTION == FALSE){ $this->queries[] = $query; }
        
        # On recupere les resultats
		$Row = $Sql->fetch_row();
		
		# On envoie les resultats
		return $Row[0];
	}

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
		
		if( is_null($param) ):
			$query .= " WHERE id = ". $this->quote($id) . " ";
		else:
			foreach($param as $k => $v):

			    if($count_param == 0):
			     	$query .= ' WHERE ' . $k .' "'. $this->quote($v) .'" ';
			    else:
			    	$query .= ' AND ' . $k .' "'. $this->quote($v) .'" ';
			    endif; 

				$count_param++;
			endforeach;
		endif;

		if(IN_PRODUCTION == FALSE):
			$this->queries[] = $query;
		endif;

        $this->query($query);
        
        return 1;
	}

	
}