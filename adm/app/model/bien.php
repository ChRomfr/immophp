<?php

class bien extends Record{

	const Table = 'bien';
	
	public	$id;
	public	$reference;
	public	$agence_id;
	public	$categorie_id;
	public	$transaction;
	public	$vendeur_id;
	public	$nom;
	public	$description;
	public	$adresse;
	public	$code_postal;
	public	$ville;
	public	$pays;
	public	$prix;
	public	$surface;
	public	$surface_terrain;
	public	$piece;
	public	$chambre;
	public	$sdb;
	public	$wc;
	public	$parking;
	public	$conso_energ;
	public	$emission_ges;
	public	$visible;
	public	$add_by;
	public	$add_on;
	public	$edit_by;
	public	$edit_on;
    public  $vendu;
    public  $acheteur_id;
    public  $coup_de_coeur;
    public  $unique_id;
    public 	$add_on_sql;

    

    /**
    *	Date au format timestamp de la date de vente
    */
    public 	$vendu_on;

    /**
    *	Date au format mysql YYYY-MM-DD de la date de vente
    */
    public 	$vendu_on_sql;

    /**
    *	Bool determine quand un bien vendu s il a ete vendu par l agence ou pas
    *	@Db: {"name":"vendu_by_agence","type":"INT(1)","default":0}
    **/	
    public 	$vendu_by_agence;

    /**
    *	Entier, compteur du nombre de fois que l'annonce a ete vu
    *	@Db: {"name":"view","type":"INT(9)","default":0}
    */
    public $view;

    /**
    *	Code HTML de la video pris en iframe de youtube/dailymotion
    *	@Db: {"name":"code_video","type":"TEXT"}
    */
    public 	$video_code;

    /**
    *	@Db: {"name":"exclusif", "type":INT(1),"default":0}
    */
    public 	$exclusif;

    public function checkData(){
		$error = 0;
		
		if( empty($this->transaction) ):
			$error++;
		endif;
		
		if( empty($this->agence_id) ):
			$error++;
		endif;
		
		if( empty($this->categorie_id) ):
			$error++;
		endif;
		
		if( empty($this->nom) ):
			$error++;
		endif;
		
		if( $error == 0 ):
			return true;
		endif;
		
		return "DATA ERROR !";
	}
    
    public function prepareForSave(){

        if( empty($this->id) ):
            $this->add_by = $_SESSION['utilisateur']['id'];
            $this->add_on = time();
            $this->edit_by = $this->add_by;
            $this->edit_on = $this->add_on;
            $this->unique_id = uniqid();
            $this->add_on_sql = date('Y') . '-' . date('m') . '-' . date('d');
            $this->view = 0;
        else:
            $this->edit_by = $_SESSION['utilisateur']['id'];
            $this->edit_on = time();
        endif;
        
    }
	
}