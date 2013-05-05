<?php

class AdmSiteModel extends Record{

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

}