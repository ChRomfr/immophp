<?php


class MyLog{
	
	protected	$app;
	
	protected	$table;
	
	public function __construct( $param ){
		$this->setApp($param['app']);
		$this->setTable($param['table']);
	}
	
	public function setApp( $app ){
		$this->app = $app;
	}
	
	public function setTable($table){
		$this->table = $table;
	}
	
	public function write(array $Log){
		$this->app->db->insert($this->table, $Log);
	}
	
	
	public function getLastLog( $limit ){
		
		return	$this->app->db->select('l.*, u.identifiant')
				->from($this->table . ' l')
				->left_join(PREFIX . 'user u','l.log_by = u.id')
				->order('l.id DESC')
				->limit($limit)
				->get();
		
	}
}