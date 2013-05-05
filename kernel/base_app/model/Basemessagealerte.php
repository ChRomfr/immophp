<?php

class Basemessagealerte extends Record{

	const Table = 'forum_message_alerte';

	public $id;

	public $message_id;

	public $auteur_id;

	public $date_alerte;

	public $traite;
}