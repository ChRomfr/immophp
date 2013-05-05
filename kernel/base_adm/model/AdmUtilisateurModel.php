<?php

abstract class AdmUtilisateurModel extends Baseutilisateur{

	const Table = 'user';
		
	public 	$id;
	public	$identifiant;
	public	$email;
	public	$password;
	public	$actif;
	public	$register_on;
	public	$last_connexion;
	public 	$avatar;
	public 	$isAdmin;
	public 	$token_activation;
	public 	$signature;
	public 	$nom;
	public 	$prenom;
	public 	$groupe_id;
	public 	$url;
	public 	$facebook;
	public 	$facebook_id;
	public 	$tweeter;
	public 	$date_naissance;
	public 	$ville;
	public 	$pays;
	public 	$lang;
	public 	$sexe;
	public 	$newsletter;
	public 	$mailing;
	public 	$date_edit_profil;
	public 	$date_changepassword;
	public 	$portable;
	public 	$telephone;
	public 	$uniq_id;

	public function isValid(){
		
		if( empty($this->identifiant) || empty($this->email) || VerifieAdresseMail($this->email) == false ):
			return "Formulaire incomplet, ou donnees incorectes";
		endif;
		
		return true;
	}
	
	public function validPassword($confirmation){
		
		if( empty($this->password) ){
			return "Mot de passe invalide";
		}
		
		if( strlen($this->password) < 6){
			return "Mot de passe trop court, il doit faire 6 caracteres minimum";
		}
		
		if( $this->password != $confirmation){
			return "Mot de passe different";
		}
		
		return true;		
	}
	
	public function cryptPassword(){
		$this->password = sha1( sha1(strtolower($this->identifiant)) . $this->password );
	}
	
	public function save(){
		global $config;

		if( empty($this->id) || ($config['user_id'] == 'uniq' && empty($this->register_on)) ):
			# Nouvel utilisateur
			$this->register_on 			= time();
			$this->actif 				= 1;
			$this->isAdmin 				= 0;
			$this->last_connexion 		= 0;
			$this->email 				= trim(htmlentities($this->email));
			$this->identifiant 			= trim(htmlentities($this->identifiant));
			$this->signature			= '';	
			$this->id 					= parent::save();
		else:
			# Mise a jour
			return parent::save();
		endif;			
	}
}