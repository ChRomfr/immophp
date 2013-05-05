<?php
class BasecommentaireManager extends BaseModel{
	
	protected $model;
	
	public function __construct($model = NULL){
		parent::__construct();
		if( !is_null($model) )$this->model = $model;
	}
	
	public function setModel($model){
		$this->model = $model;
	}
	
	public function getByModelId($id){
	
		$this->db->select('c.*, u.identifiant')
			->from(PREFIX . $this->model .'_commentaire c')
			->left_join(PREFIX . 'user u', 'u.id = c.auteur_id')
			->where(array('model_id =' => $id))
			->order('c.post_on');
		
		return $this->db->get();
	}
	
	public function save(Basecommentaire $commentaire){
		$this->db->insert(PREFIX . $this->model . '_commentaire', $commentaire);
	}
	
	public function delete($id){
		$this->db->delete(PREFIX . $this->model . '_commentaire', $id);
	}
	
}