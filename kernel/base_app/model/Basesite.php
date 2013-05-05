<?php

class Basesite extends Record{
	
	const Table = 'annuaire_site';

	public $id;

	public $user_id;

	public $email;

	public $categorie_id;

	public $url;

	public $name;

	public $resume;

	public $description;

	public $flux_rss_1;

	public $flux_rss_2;

	public $backlink;

	public $add_on;

	public $edit_on;

	public $keyword;

	public $visible;

	public $status;

	public $date_valid;

	public $raison_refus;

	public $valid_by;

	public $facebook;

	public $twitter;

	public $googleplus;

	public $allopass;

	public function isValid($config){

		$Error = null;

		$this->resume = strip_tags($this->resume);
		$this->description = strip_tags($this->description);

		if( empty($this->name) ):
			$Error .= '<li>Nom du votre site obligatoire</li>';
		endif;

		if( !filter_var($this->url, FILTER_VALIDATE_URL) ):
			$Error .= '<li>Url de votre site invalide</li>';
		endif;

		if( empty($this->resume) ):
			$Error .= '<li>Veuillez indiquer le resume de votre site</li>';
		endif; 

		if( strlen($this->resume) < $config['annuaire_min_length_resume']):
			$Error .= '<li>Resume trop court</li>';
		endif;

		if( empty($this->description) ):
			$Error .= '<li>Veuillez indiquer la description de votre site</li>';
		endif; 

		if( strlen($this->description) < $config['annuaire_min_length_description']):
			$Error .= '<li>Description trop courte</li>';
		endif;

		if( empty($this->email) ):
			$Error .= '<liVeuillez indiquer votre adresse email</li>';
		endif;

		if( !filter_var($this->email, FILTER_VALIDATE_EMAIL) ):
			$Error .= '<li>Email invalide</li>';
		endif;

		if( !is_null($Error) ):
			return $Error;
		else:
			return true;
		endif;
	}

	public function prepareForSave(){

		$this->status = 'new';
		$this->add_on = TimeToDATETIME();
		$this->edit_on = TimeToDATETIME();
		$this->visible = 0;

	}
}