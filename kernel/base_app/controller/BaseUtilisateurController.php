<?php

class BaseutilisateurController extends Controller{
        
    public function indexAction(){
    	if( $_SESSION['utilisateur']['id'] == 'Visiteur')
    		return $this->registerAction();
    	else
    		return $this->profilAction();
    }

    public function profilAction(){

    	return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'utilisateur' . DS . 'profil.tpl');
    }
    
    /**
	*	Affichage et traitement du formulaire d enregistrement utilisateur
	*	@return mixed code html
	*/
	public function registerAction(){
		
		global $config;
	
		if( $this->app->HTTPRequest->postExists('user') ){
			// Traitement du formulaire
			$user = new BaseUtilisateur($this->app->HTTPRequest->postData('user') );

			//$this->load_manager('utilisateur', 'base_app');
			
			if( $Result = $user->isValid() !== true ):
				$this->app->smarty->assign('Error_register', $Result);			
				goto print_form;
			endif;
				
			if( $Reslt = $user->validPassword($_POST['user']['password2']) !== true ){
				$this->app->smarty->assign('Error_register', $Result);			
				goto print_form;
			}	
			
			if( $this->app->config['user_id'] == 'uniq' ):
				$user->id = getUniqueID();
			endif;

			# On crypte le mot de passe 
			$user->cryptPassword();

			# On le sauvegarde dans la base
			$user->id = $user->save();

			# On ajoute l utilisateur au groupe membre
			$this->app->db->insert(PREFIX . 'user_groupe', array('groupe_id' => 2, 'user_id' => $user->id));

			if( $this->app->config['user_activation'] != 'auto'):
				$user->actif = 0;
				$user->setTokenActivation( getUniqueID() );
				$user->save();
				# Cas email
				if( $this->app->config['user_activation'] == 'mail'):
					$this->app->smarty->assign(array('user' => $user));
					$corp_message = $this->app->smarty->fetch( BASE_APP_PATH . 'view' . DS . 'utilisateur' . DS . 'mail_activation.tpl' );
					sendEmail($user->email , $config['email'], $this->lang['Enregistrement_sur'] .' '. $config['titre_site'], strip_tags($corp_message), $corp_message);
					return $this->redirect($this->app->Helper->getLink('index'), 3, "Votre compte a ete cree, vous devez maintenant l activer en cliquant sur le lien dans l'email qui vient d'etre envoyer");
				endif;
				
				# Cas admin
				if( $this->app->config['user_activation'] == 'admin'):
					return $this->redirect($this->app->Helper->getLink('index'), 3, "Votre compte a ete cree, il doit maintenant etre active par un administrateur");
				endif;

			endif;
			
			return $this->redirect($this->app->Helper->getLink('index'), 3, $this->lang['Compte_cree']);
		}
		
		print_form:		
		$this->getFormValidatorJs();
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'utilisateur' . DS . 'register.tpl');		
	}

	/**
	 * Affiche et traite le formulaire d edition de profil
	 * @return [type] [description]
	 */
	public function editAction(){

		if(  $this->app->HTTPRequest->postExists('user') ):
			$User = new myObject($this->app->HTTPRequest->postData('user') );
			$this->app->db->update(PREFIX . 'user', $User, array('id =' => $_SESSION['utilisateur']['id']));

			# Mise a jour des var de sessions
			$User = $this->app->db->get_one(PREFIX . 'user', array('id =' => $_SESSION['utilisateur']['id']));
			$this->app->session->create($User);

			# Redirection utilisateur
			return $this->redirect( $this->app->Helper->getLink('utilisateur'),3, 'Profil mise a jour' );
		endif;

		$this->getFormValidatorJs();
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'utilisateur' . DS . 'edit.tpl');

	}
    
    /**
     * Traite l activation des utilisateurs
     * @return string Code html de la page
     */
	public function activationAction( ){

		if(  $this->app->HTTPRequest->getExists('reg') == false ):
			return $this->redirect( $this->app->Helper->getLink('index'),0,'' );
		endif;
		
		$Reg = explode('|', $this->app->HTTPRequest->getData('reg') );
		
		if( !is_array($Reg) ) exit();		
		if( $this->app->db->count(PREFIX . 'user', array('id =' => $Reg[0], 'token_activation =' => $Reg[1], 'actif =' => 0)) != 1) exit();
		
		$user = $this->app->db->get_one(PREFIX . 'user', array('id =' => $Reg[0], 'token_activation =' => $Reg[1], 'actif =' => 0)) ;
		
		$user['actif']  = 1;
		$user['token_activation'] = '';
		
		$this->app->db->update(PREFIX . 'user', $user);
		
		return $this->redirect($this->app->Helper->getLink('connexion/index'),10, $this->lang['Votre_compte_est_active']);
		
	}

	public function changePasswordAction(){

		if( $_SESSION['utilisateur']['id'] == 'Visiteur'):
			header('location:'. $this->app->Helper->getLink('index') ); exit;
		endif;
		
		if( $this->app->HTTPRequest->postExists('password') ):
			$data = $this->app->HTTPRequest->postData('password');
			
			if( empty($data['ancien']) || empty($data['nouveau']) || empty($data['confirmation']) || strlen($data['nouveau']) < 6 || $data['nouveau'] != $data['confirmation'] )
				goto print_form;
				
			if( $this->app->db->count(PREFIX . 'user', array('id =' => $_SESSION['utilisateur']['id'], 'password =' => cryptPassword($data['ancien'], $_SESSION['utilisateur']['identifiant']))) != 1)
				goto print_form;
				
			$this->app->db->update(PREFIX . 'user', array('password' => cryptPassword($data['nouveau'], $_SESSION['utilisateur']['identifiant'])), array('id =' => $_SESSION['utilisateur']['id']));
			
			return $this->redirect($this->app->Helper->getLink('utilisateur'), 3, $this->lang['Mot_de_passe_change']); 
		endif;
		
		print_form:

		$this->getFormValidatorJs();

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'utilisateur' . DS . 'changePassword.tpl');
		
	}

    /**
     * Requete qui verifie si l identifiant existe deja dans la base utilisateur
     * 
     * 
     */
    public function check_identifiantAction($identifiant){
		$this->load_manager('utilisateur', 'base_app');

		$result = $this->manager->utilisateur->existIdentifiant(trim(htmlentities($identifiant)));

		if( $result > 0 )
			return 'alreadyUse';
		else
			return '';
	}
	
	public function check_emailAction($email){
		$this->load_manager('utilisateur', 'base_app');
		
		$result = $this->manager->utilisateur->existEmail(trim(htmlentities($email)));

		if( $result > 0 )
			return 'alreadyUse';
		else
			return '';
	}
	
	public function checkEmailAction(){
		$email = $_GET['user']['email'];
		$email = trim($email);

		if( VerifieAdresseMail($email) == false ):
			return "false";
		endif;

		$Result = $this->app->db->count(PREFIX . 'user', array('email =' => $email) );

		if( $Result > 0):
			return "false";
		else:
			return "true";
		endif;
	}

	public function checkIdentifiantAction(){
		$identifiant = $_GET['user']['identifiant'];
		$identifiant = trim($identifiant);

		$Result = $this->app->db->count(PREFIX . 'user', array('identifiant =' => $identifiant) );

		if( $Result > 0):
			return "false";
		else:
			return "true";
		endif;
	}      
}