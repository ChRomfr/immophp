<?php

abstract class AdmDownloadModel extends Record{

	const Table = 'download';


	public	$id,
			$name,
			$categorie_id,
			$url,
			$apercu;

	public $description;

	public $vue;

	public $downloaded;

	public $visible;

	public $download_for;

	public $add_on;

	public $add_by;

	public function prepareForSave(){

		$this->add_by = $_SESSION['utilisateur']['id'];
		$this->vue = 0;
		$this->downloaded = 0;

		# Initialisation des variable url et apercu pour permettre l enregistrement
		$this->url = '';
		$this->apercu = '';
	}

	public function isValid(){

		if( empty($this->name) ):
			return 'Name is empty';
		endif;

		return true;
	}
}