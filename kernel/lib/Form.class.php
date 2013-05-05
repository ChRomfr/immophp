<?php

class Form{
	
	protected $app;
	
	private $form;
	
	private $champs_in_db;
	
	public function __construct($registry){		
		$this->app = $registry;		
	}
	
	public function get($code_formulaire, $data_id = null){
		$this->form = '';	// On vide la var qui va recevoir le code
		$this->getChampInTable($code_formulaire, $data_id );
		$this->constructForm();
		return $this->form;
	}
	
	/**
	 * Restitue les données pour lecture
	 * 
	 */
	public function getData($code_formulaire, $data_id, $presentation = 'table'){
		$HTML = '<table>';
        
		$champs_in_db = $this->app->db->select('DISTINCT(cf.id),cf_name, (SELECT cfd_value FROM '. PREFIX . 'commun_form_data cfd WHERE cfd_id = '. $data_id .' AND cf.id = cfd.cf_id) as cfd_value')->from(PREFIX . 'commun_form cf')->left_join(PREFIX . 'commun_form_data cfd','cf.id = cfd.cf_id')->where( array('cf_code_form =' => $code_formulaire ) )->get();
        
		foreach( $champs_in_db as $champ ):
			$HTML .= '<tr><td>'. $champ['cf_name'] .' :</td><td><strong>'. $champ['cfd_value'] .'</strong></td></tr>';
		endforeach;
        
		$HTML .= '</table>';
		
		return $HTML;
	}
	
	private function getChampInTable($code, $data_id){
		if( is_null($data_id) ):
			$this->champs_in_db = $this->app->db->get(PREFIX . 'commun_form', array('cf_code_form =' => $code) );
		else:
			$this->champs_in_db = $this->app->db->select('DISTINCT(cf.id),cf.*, (SELECT cfd_value FROM '. PREFIX . 'commun_form_data cfd WHERE cfd_id = '. $data_id .' AND cf.id = cfd.cf_id) as cfd_value')->from(PREFIX . 'commun_form cf')->left_join(PREFIX . 'commun_form_data cfd','cf.id = cfd.cf_id')->where( array('cf_code_form =' => $code ) )->get();
		endif;
	}
	
	private function constructForm(){
		foreach( $this->champs_in_db as $Champ):
			$this->form .= '<dl><dt><label for="'. $Champ['cf_name'] .'">'. $Champ['cf_name'] .' :</label></dt><dd>';
			switch ($Champ['cf_type']){
				case 1:
					$this->addInputText($Champ);
					break;
					
				case 2:
					$this->addSelect($Champ);
					break;
			}
			$this->form .= '</dd></dl>';
		endforeach;
	}
	
	private function addInputText( $Champ ){
		$this->form .= '<input type="text" name="formp['.$Champ['id'].']" id="'. $Champ['cf_name'] .'" ';
		if( $Champ['cf_required'] == 1 ) $this->form .= 'required class="validate[required]" ';
		if( !empty( $Champ['cfd_value'] ) ) $this->form .= ' value="'.  $Champ['cfd_value'].'" ';
		$this->form .= '/>';
	}
	
	private function addSelect( $Champ ){
		
		$this->form .= '<select name="formp['.$Champ['id'].']" id="'. $Champ['cf_name'] .'" ';
		
		if( $Champ['cf_required'] == 1 ) $this->form .= 'required class="validate[required]" ';
		
		$this->form .= '>';
		
		if( !empty( $Champ['cfd_value'] ) ) $this->form .= '<option value="'.  $Champ['cfd_value'].'">' . $Champ['cfd_value'] . ' </option>';
		
		$this->form .= '<option></option>';
		
		$Champ['options'] = explode(';',$Champ['cf_value']);
		
		foreach( $Champ['options'] as $k => $v ):
			if( !empty($v) ) $this->form .= '<option value="'. $v .'">'. $v .'</option>';
		endforeach;
		
		$this->form .= '</select>';
	}
}