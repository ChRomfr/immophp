<?php
/*

                                                                               
                                     _,,                                   ,dW 
                                   ,iSMP                                  JIl; 
                                  sPT1Y'                                 JWS:' 
                                 sIl:l1                                 fWIl?  
                                dIi:Il;                                fW1"    
                               dIi:l:I'                               fWI:     
                              dIli:l:I;                              fWI:      
                            .dIli:I:S:S                     .       fWIl`      
                          ,sWSSIIIiISIIS w,_             .sMW     ,MWIl;       
                     _.,sWWW*"'*" , SWW' MWWMm mu,,._  .iSYISb, ,MM*SI!:       
                 _,s YMMWW'',sd,'MM WMMi "*MW* WWWMWMb MMS WWP`,MW' S1!`       
            _,os,'MMi YW' m,'WW; WWb`SWM Im,,  SIS ISW SISIP*  WSi  II!.       
         .osSMWMW,'WSi ',MMP SSb WSW ISII`SYYi III !Il lIi,ui:,*1:li:l1!       
      ,sSMMWWWSSSS,'SWbdWW*  *YSbiSS:'IlI 7llI il1: l! 'l:+'+l; `''+1i:1i      
   ,sYSMWMWY**"""'` 'WWSSIIiu,'**Y11';IIIb ?!li ?l:i,         `      `'l!:     
  sPITMWMW'`.M.wdWWb,'YIi `YT" ,u!1",ISIWWm,'+?+ `'+Ili                `'l:,   
  YIi1lTYfPSkyLinedI!i`I!" .,:!1"',iSWWMMMMMmm,                                
    "T1l1lI**"'`.2006? ',o?*'``  ```""**YSWMMMWMm,                             
         "*:iil1I!I!"` '                 ``"*YMMWWM,                           
               ii!                             '*YMWM,                         
               I'                                  "YM                         
                                                                               

*/

class Baseutilisateur extends Record{

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

	/**
	 * Contient les groupes utilisisateurs
	 * @NoDb: {"nodb":1}
	 * @CallFunction: {"function":"getGroupes"}
	 */
	public $groupes; 
	
	public function setActif( $str ){
		$this->actif = $str;
	}
	
	public function getEmail(){
		return $this->email;
	}
			
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
	
	public function checkLogin(){
		global $db;
		
		# Cas identifiant ou password vide
		if( empty($this->identifiant) || empty($this->password) ):
			return false;
		endif;

		# Securisation des donnees pour eviter l injection
		$this->identifiant = trim(htmlentities($this->identifiant));
		
		# On hash le password	
		$this->cryptPassword();

		# On requete la base
		$Result = $db->count( $this->getTable(), array('identifiant =' => $this->identifiant, 'password =' => $this->password) );

		# On test le resultat si different de 1 
		# on retourne une erreur
		if( $Result != 1):
			return 'Utilisateur ou mot de passe incorrecte.';
		endif;

		# On recupere les informations de utilisateur
		$data = $db->get_one( $this->getTable(), array('identifiant =' => $this->identifiant, 'password =' => $this->password) );
		
		if( empty($data) ):
			return 'Impossible de recuperer vos informations';
		endif;

		# On assigne les valeur au element
		$this->hydrate($data);

		if( $this->actif == 0):
			return 'Votre compte n\'est pas active ou a été desactivé par un administrateur';
		endif;

		# Return true 
		return true;
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
			$this->id 					= parent::save();			
		else:
			# Mise a jour
			return parent::save();
		endif;			
	}

	public function setTokenActivation( $str ){
		$this->token_activation = $str;
	}
	
	public function getTokenActivation(){
		return $this->token_activation;
	}

	/**
	 * Recupere les groupes de l utilisateurs
	 * @return void
	 */
	public function getGroupes(){
		global $db;

		# Recuperation des groupes
		$Groupes = 	$db->
						select('gr.*')
						->from(PREFIX . 'groupe gr')
						->left_join(PREFIX . 'user_groupe ugr','ugr.groupe_id = gr.id')
						->where(array('ugr.user_id =' => $this->id))
						->get();

		# On boucle dessus pour les mettres dans le bon shema
		foreach($Groupes as $Groupe):
			$this->groupes[$Groupe['name']] = array('id' => $Groupe['id'], 'name' => $Groupe['name']);;
		endforeach;
	}
}