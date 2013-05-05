<?php
abstract class Record implements ArrayAccess{

	const Table = NULL;
	
	public function __construct(array $donnees = array()){
		if (!empty($donnees)){
	    	$this->hydrate($donnees);
		}
	}	
	
	public function hydrate(array $donnees){

		foreach($donnees as $k => $v){
			if( property_exists($this, $k) ){
				$this->$k = $v;
			}
		}

        # On recupere son schema
        $Properties = $this->buildSchema();
        
        # On parcourt le schema pour verifier si des fonctions
        # doivent etre appelle
        foreach( $Properties as $key => $values ):
            if( isset($values['CallFunction']) ):
                $Call = $values['CallFunction'];
                $f = $Call->function;
                $this->$f();
            endif;
        endforeach;

	}
	
	public function offsetGet($offset) {
		if( isset($this->$offset) )
			return $this->$offset;
    }
	
	public function offsetSet($var, $value)
	{
	$method = 'set'.ucfirst($var);
	
	if (isset($this->$var) && is_callable(array($this, $method)))
	{
	    $this->$method($value);
	}
	}
	
	public function offsetExists($var)
	{
	return isset($this->$var) && is_callable(array($this, $var));
	}
	
	public function offsetUnset($var)
	{
		throw new Exception('Impossible de supprimer une quelconque valeur');
	}
	
	public function buildSchema()
    {
        $class_name = get_class($this);
        $class_vars = get_class_vars($class_name);

        $class_reflection = new ReflectionClass($this);
        //echo $class_reflection->getDocComment();

        $schema = array();

        foreach($class_vars as $var_name => $var_value)
        {
            $prop_reflection = $class_reflection->getProperty($var_name);
            $comment = $prop_reflection->getDocComment();

            $comment = preg_replace(',\/\*\*(.*)\*\/,', '$1', $comment);
            $comments = preg_split(',\n,', $comment);

            $key = $val = NULL;
            $schema[$var_name] = array();

            foreach($comments as $comment_line)
            {
                if(preg_match(',@(.*?): (.*),i', $comment_line, $matches))
                {
                    $key = $matches[1];
                    $val = $matches[2];

                    if( json_decode($val) ):
                    	$val = json_decode($val);
                    else:
                    	$val = trim($val);
                   	endif;

                    $schema[$var_name][trim($key)] = $val;
                }
            }
        }

        return $schema;
    }

    /**
    *	Definie la table courante
    *	@param string $table nom de la table
    *	@return void
    */
    public function setTable($table){
    	//self::Table = PREFIX . $table;
    }

     /**
    *	Retourne la table courante
    *	@return string|
    */
    public function getTable(){
    	$c = get_called_class();
    	return PREFIX . $c::Table;
    }

    public function save(){
    	global $db;

        # On stocke l object dans var tmp
        $Obj = $this;

        # On recupere son schema
        $Properties = $this->buildSchema();

        # On parcourt le schema pour supprimer la var NoDb
        foreach( $Properties as $key => $values ):
            if( isset($values['NoDb']) ):
                unset($Obj->$key);
            endif;
        endforeach;
        
    	if( empty($Obj->id) ):
    		return $db->insert( $this->getTable(), $Obj);
    	else:
            # Pour eviter la suppression de donnees et passer des object partiellement remplie
            # ce qui peut etre le cas si le formulaire ne permet que la modification en partie
            # On supprimer toutes proprietes empty
            
            foreach( $Obj as $k => $v ):
                if( empty($v) ):
                    unset($Obj->$k);
                endif;
            endforeach;
            # On sauvegarde en base
    		return $db->update( $this->getTable(), $Obj, array('id =' => $Obj->id));
    	endif;
    }

    public function get($id = null){
    	global $db;

    	if( empty($id) ):
    		return $db->get($this->getTable());
    	else:
    		$Result = $db->get_one($this->getTable(), array('id =' => $id));
    		$this->hydrate($Result);
    	endif;
    }

    public function delete($id){
    	global $db;
    	return $db->delete( $this->getTable(), $id );
    }

    /**
    *	Permet la creation automatique de la table
    *	@param bool $execute Determine si la requete est executer ou retourner
    *	@return mixed
    */
    public function createTable($execute = 0) {
    	global $db;

    	# Recuperation du schema
    	$Datas = $this->buildSchema();

    	# Initialisation des variables
    	$Primary = null;
    	$Index = null;

    	# Construction de la requete
    	$Query = "CREATE TABLE ". $this->getTable() ." (";

		# On boucles les annotations
    	foreach($Datas as $property):

    		# Si instruction de creation de table existe on rentre dedans
    		if( isset($property['Db']) ):

    			$champ = $property['Db'];

				$Query .= " `" . $champ->name . "` ". $champ->type ."";

				# LONGUEUR DU CHAMP
				if( isset($champ->length) ):
					$Query .= "(". $champ->length .")";
				endif;

				# NOT NULL
				if( isset($champ->notnull) && $champ->notnull == 1):
					$Query .= " NOT NULL ";
				endif;

				# VALEUR PAR DEFAULT
				if( isset($champ->default) ):
					$Query .= " DEFAULT ". $champ->default . " ";
				endif;

				# AUTOINCREMENT
				if( isset($champ->autoincrement) && $champ->autoincrement == 1):
					$Query .= " AUTO_INCREMENT ";
				endif;

				# CLE PRIMAIRE
				if( isset($champ->primary) && $champ->primary == 1):
					$Primary .= " PRIMARY KEY (`". $champ->name . "`)";
				endif;

				$Query .= ",";

    		endif;

		endforeach;
		
		# On verifie les cle primaire et index
		if( !is_null($Primary) ):
			$Query .= $Primary . ",";
		endif;

		# Supprimer la derniere virgule
		$Query = substr($Query, 0, -1);

		$Query .= ');';
		echo $Query;
		if( $execute == 0):
			return $Query;
		else:
			$db->query($Query);
		endif;
    }
}

class myObject extends Record{

	public function __construct(array $donnees = array()){
		if (!empty($donnees)){
	    	$this->hydrate($donnees);
		}
	}	
	
	public function hydrate(array $donnees){
		foreach($donnees as $k => $v){
			$this->$k = $v;			
		}
	}

}