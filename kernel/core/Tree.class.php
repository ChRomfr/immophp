<?php

class Tree {
	
	private $Db;
	
	private $Table;
	
	public function __construct($Db, $Table){
		$this->Db = $Db;
		$this->Table = $Table;
	}

	public function add($data){
		
		//Ajout racine
		if( $data['parent_id'] == 0){
			
			// Recuperation des valeurs Max gauche et droite
			$Query = 'SELECT MAX(lft) AS lft, MAX(rght) AS rght FROM '. $this->Table .' ';
			$SQL = $this->Db->query($Query);
			$Result = $SQL->fetch(PDO::FETCH_ASSOC);
			$SQL->closeCursor();
			
			// Cas Table vide
			if( is_null($Result['lft']) && is_null($Result['rght']) ){
				$Query = 'INSERT INTO '. $this->Table .' (`name`, lft, rght, level, parent_id, description, image) VALUES ("'. $data['name'] .'", 1,2,0,0,"'.  $data['description'].'","'. $data['image'] .'")';
				$this->Db->query($Query);
			}else{
				$this->Db->insert($this->Table, array('name' => $data['name'], 'lft' => $Result['rght']+1, 'rght' => $Result['rght']+2, 'parent_id' => 0, 'level' => 0, 'description' => $data['description'], 'image' => $data['image']) );
			}
						
		}else{
			//
			// Ajout d un element dans l arbre
			//
			
			// Recuperation des bords du parent directe.
			$Parent = $this->Db->get_one($this->Table, array('id =' => $data['parent_id']) );
			
			$data['lft'] = $Parent['rght'];
			$data['rght'] = $data['lft'] + 1;		
			$data['level'] = $Parent['level'] + 1;
			
			$this->Db->query("UPDATE ". $this->Table ." SET lft = lft + 2 WHERE lft >= ". $Parent['rght'] ." ");
			$this->Db->query("UPDATE ". $this->Table ." SET rght = rght + 2 WHERE rght >= ". $Parent['rght'] ." ");	// Mise a jour des bords categories ayant un bord superieure ou egalement au bord droit du parent
			$this->Db->insert($this->Table, $data);	// Insert de la categorie
			
			//var_dump($Parent);
		}
		
	}
	
	public function remove($id){
		$categorie = $this->Db->get_one($this->Table, array('id =' => $id) );
		if( $categorie['rght'] - $categorie['lft'] == 1 ){
			$this->Db->delete($this->Table, null, array('id =' => $id));
			$this->Db->query("UPDATE ". $this->Table ." SET lft = lft - 2 WHERE lft >= ". $categorie['lft'] ." ");
			$this->Db->query("UPDATE ". $this->Table ." SET rght = rght - 2 WHERE rght >= ". $categorie['lft'] ." ");
		}
	}
	
	public function getParent($left, $right){
		return $this->Db->get($this->Table, array('lft < ' => $left, 'rght > ' => $right));
	}
	
	public function getChid($left, $right){
		return $this->Db->get($this->Table, array('lft > ' => $left, 'rght < ' => $right));
	}
	
	public function getById($id){
		return $this->Db->get_one($this->Table, array('id =' => $id));
	}
	
	public function getAll(){
		return $this->Db->get($this->Table, null, 'lft ASC');
	}
	
}