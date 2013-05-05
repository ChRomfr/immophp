<?php

class AdmFluxLinkModel extends Record{

	const Table = 'feed_rss_link';

	public $id;

	public $categorie_id;

	public $name;

	public $link;

	public $description;

	public $image;

	public $add_on;

	public $actif;
}