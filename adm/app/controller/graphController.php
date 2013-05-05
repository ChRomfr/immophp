<?php

class graphController extends Controller{
	
	public function repartBienCatAction(){
		$Datas	=	$this->app->db
						->select( ' bc.name as label, COUNT(b.id) as data')
						->from(PREFIX . 'bien b')
						->left_join(PREFIX . 'bien_categorie bc','b.categorie_id = bc.id')
						->where(array('b.delete =' => 0))
						->group_by('b.categorie_id')
						->get();

		return json_encode($Datas,JSON_NUMERIC_CHECK);
	}

	public function bienVisibleAction(){
		$Datas = array();
		$Datas[] = array('label' => 'Visible', 'data' => $this->app->db->count(PREFIX . 'bien b', array('b.delete = ' => 0, 'b.visible =' => 1)));
		$Datas[] = array('label' => 'Non visible', 'data' => $this->app->db->count(PREFIX . 'bien b', array('b.delete = ' => 0, 'b.visible =' => 0)));
		
		return json_encode($Datas,JSON_NUMERIC_CHECK);
	}

}