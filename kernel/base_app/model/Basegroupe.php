<?php

class Basegroupe extends Record{

	const Table = 'groupe';

	public $id;

	public $name;

	public $description;

	public $image;

	public $principal;

	public $systeme;

	public $ouvert;

	public $visible;

	public function isValid(){

		$error = null;

		if( empty($this->name) ):
			$error = 'Veuillez donner un nom au groupe';
		endif;

		if( is_null($error) ):
			return true;
		endif;

		return $error;
	}

}