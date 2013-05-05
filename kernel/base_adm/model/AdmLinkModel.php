<?php

abstract class AdmLinkModel extends Record{

	const Table = 'link';

	public $id;

	public $categorie_id;

	public $auteur_id;

	public $name;

	public $description;

	public $url;

	public $actif;

	public $valid;

	public $add_on;

	public $image;

	public $apersite;

}