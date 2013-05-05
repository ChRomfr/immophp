<?php

class Basethread extends Record{
	
	const Table = 'forum_thread';

	public $id;

	public $forum_id;

	public $titre;

	public $add_on;

	public $auteur_id;

	public $view;

	public $annonce;

	public $sondage;

	public $closed;

	public $visible;

	public $last_auteur_id;

	public $last_message_date;

	public function prepareForSave(){

		if( empty($this->id) ):
			$this->view = 0;
			$this->annonce = 0;
			$this->sondage = 0;
			$this->closed = 0;
			$this->add_on = TimeToDATETIME();
			$this->visible = 1;
			$this->last_auteur_id = $_SESSION['utilisateur']['id'];
			$this->last_message_date = TimeToDATETIME();
		endif;

	}

}