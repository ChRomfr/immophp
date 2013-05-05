<?php

class agence extends Record{

	const Table = 'agence';
	
	public	$id;
	public	$directeur_id;
	public	$nom;
	public	$description;
	public	$adresse;
	public	$code_postal;
	public	$ville;
	public	$pays;
	public	$telephone;
	public	$fax;
	public	$email;
	public	$photo;
	public	$add_on;
	public	$add_by;
	public	$edit_on;
	public	$edit_by;
	public  $unique_id;
    
	public function checkData(){
		$error = 0;
		
		if( empty($this->nom) ):
			$error++;
		endif;
		
		if( !empty($this->directeur_id) && !is_numeric($this->directeur_id) ):
			$error++;
		endif;
		
		if( empty($this->code_postal) ):
			$error++;
		endif;
		
		if( empty($this->ville) ):
			$error++;
		endif;
	
		if( $error > 0):
			return "Error data agence";
		endif;
		
		$this->prepareForSave();
		
		return true;
	}
	
	public function prepareForSave(){
		
		if( empty($this->id) ):
			$this->add_by = $_SESSION['utilisateur']['id'];
			$this->add_on = time();
			$this->edit_by = $this->add_by;
			$this->edit_on = $this->add_on;
            $this->unique_id = uniqid();
		endif;
		
	}
	
	public function savePhoto(){
		$dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'agence' . DS . $this->id;
		
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php';
		
		if( !is_dir($dir) ):
			@mkdir($dir);
		endif;
		
        $Image = new Upload($_FILES['photo']);
        if($Image->uploaded):
			$Image->allowed = 'image/*';
            $Image->file_overwrite = true;
            $Image->file_new_name_body  = microtime(true);
			$Image->image_resize          = true;
			$Image->image_ratio_y         = true;
			$Image->image_x               = 1024;
            $Image->process($dir);
			$this->photo = $Image->file_dst_name;
		endif;
	}
}