<?php

abstract class AdmCategorieManager extends BaseModel{

	protected $table;
	
	public function setTable($controller){
		$this->table = PREFIX . $controller .'_categorie';
	}
	
	public function getAll(){
		return	$this->db->select('c.*')
				->from($this->table . ' c')
				->order('c.lft ASC')
				->get();
	}
	
	public function insert($categorie){
		return $this->db->insert($this->table, $categorie);
	}
	
	public function update($categorie){
		return $this->db->update($this->table, $categorie, null, array('id =' => $categorie['id']));
	}
	
	public function delete($id){
		return $this->db->delete($this->table, $id);
	}
	
}