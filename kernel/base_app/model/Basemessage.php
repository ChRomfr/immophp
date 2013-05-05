<?php

class Basemessage extends Record{
	
	const Table = 'forum_message';

	public $id;

	public $thread_id;

	public $forum_id;

	public $auteur_id;

	public $message;

	public $add_on;

	public $edit_on;

	public $edit;

	public $auteur_signature;

	public $email_notify;

	public $auteur_ip;

	public $bbcodeoff;

	public $fichier;

	public function prepareForSave(){

		if( empty($this->id) ):
			$this->add_on = TimeToDATETIME();
			$this->auteur_ip = $_SERVER['REMOTE_ADDR'];
			$this->auteur_id = $_SESSION['utilisateur']['id'];
		endif;

	}

}