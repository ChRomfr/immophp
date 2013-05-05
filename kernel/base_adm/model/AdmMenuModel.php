<?php


final class AdmMenuModel extends Record{

	const Table = 'menu';

	public	$id;
	
	public	$name;
	
	public	$creat_on;
	
	public	$creat_by;
	
	public	$links;
	
	public function setCreatOn($str){
		$this->creat_on = $str;
	}
	
	public function setCreatBy($str){
		$this->creat_by = $str;
	}
	
	public function setLinks( $data ){
		$this->links = $data;
	}
	
	public function isValid(){
		
		if( empty($this->name) ) return false;
		
		if( empty($this->id) ):
			$this->setCreatOn(time());
			$this->setCreatBy($_SESSION['utilisateur']['id']);
		endif;
		
		return true;
	}

}