<?php

class prospect_suivi extends Record{
	
	const Table = 'prospect_suivi';

	public $id;

	public $prospect_id;

	public $user_id;

	public $suivi;

	public $add_on;
}