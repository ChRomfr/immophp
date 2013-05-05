<?php
/**
*	SHARKPHP VA
*	CMS FOR VIRTUAL AIRLINE
*	@author ChRom
*	@url http://va.sharkphp.com
*/

class menuManager extends BaseModel{
	
	public function getAll(){		
		return $this->db->get(PREFIX . 'menu' );		
	}
	
	public function getById($mid){
		return	$this->db->get_one(PREFIX . 'menu', array('id =' => $mid) );
	}
	
	public function save(menu $menu){
		
		if( empty($menu->id) )
			return $this->insert($menu);
		else
			return $this->update($menu);
		
	}
	
	private function insert(menu $menu){
		return	$this->db->insert(PREFIX . 'menu', $menu);
	}
	
	private function update(menu $menu){
		return	$this->db->update(PREFIX . 'menu', $menu, array('id =' => $menu->id) );
	}
	
}
