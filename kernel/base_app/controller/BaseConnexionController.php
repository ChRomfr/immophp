<?php

class BaseconnexionController extends Controller{
    
    	/**
    	 * Affiche et traite le forumaire d identification
    	 * @return [type] [description]
    	 */
    	public function indexAction(){
		
		# Si utilisateur deja connecter on le renvoie a l index
		if( $_SESSION['utilisateur']['id'] != 'Visiteur' ):
			header('location:' . $this->app->Helper->getLink('index') );
			exit;
		endif;
		
		# Soumission du formulaire
		if( $this->app->Http->postExists('login') ):            
            
            if( is_file(APP_PATH . 'model' . DS  . 'utilisateur.php') ):
                $this->load_model('utilisateur');
                $user = new utilisateur( $this->app->HTTPRequest->postData('login') );
            else:
                $this->load_model('utilisateur', 'base_app');
                $user = new Baseutilisateur( $this->app->HTTPRequest->postData('login') );
            endif;	
			
            $Result = $user->checkLogin();

            if( $Result !== true):
            	$this->app->smarty->assign('Error_login', $Result);
            	goto print_form;
            endif;

            # On creer la session
			$this->app->session->create($user);

			# On met a jour le profil utilisateur avec sa derniere connexion
			$this->app->db->update(PREFIX . 'user', array('last_connexion' => time()), array('id =' => $_SESSION['utilisateur']['id']));
			
			if( isset($_SESSION['utilisateur']['isAdmin']) && $_SESSION['utilisateur']['isAdmin'] > 0):
				# Si administrateur redirige l utilisateur vers l administration
				return $this->redirect( $this->app->config['url'] . $this->app->config['url_dir'] . 'admin.php');
			else:
				# On gere la redirection de l utilisateur
				$url_redirection = $this->registry->Helper->getLink('index');
				
				if( $this->registry->Http->postExists('referer') ):
					$referer = $this->registry->Http->post('referer');
					# On verifie que l url soit bien du site
					if( strpos($referer, $this->registry->config['url']) !== false ):
						$url_redirection = $referer;
					endif;
				endif;
				return $this->redirect($url_redirection);
			endif;
		endif;
		
		# Affichage du formulaire
		print_form:
		$this->Helper->getFormValidatorJs();
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'connexion' . DS . 'index.tpl');
	}
	
	public function logoutAction(){
		# Destruction de la session
		$this->app->session->destroy();
		# Redirection de l utilisateur
		return $this->redirect($this->app->Helper->getLink('index'), 0, $this->lang['Vous_etes_maintenant_deconnecte']);
	}
	
	public function lostPasswordAction(){
		
		if( $this->app->HTTPRequest->postExists('email') ):
			$Email = $this->app->HTTPRequest->postData('email');
			
			// On verifie que un utilisateur existe avec cet email dans la base
			$Result = $this->app->db->count(PREFIX . 'user', array('email =' => trim($Email)) );
			
			if( $Result == 1):
				// Suppression des demandes deja existante
				$this->app->db->delete(PREFIX . 'user_reset_password',null, array('email =' => trim($Email)) );
								
				// Creation d'un token et timestamp de validite
				$Data = array(
					'token'				=>	getUniqueID(),
					'time_on_demand'	=>	time(),	
					'email'				=>	trim($Email),
				);
				
				// Preparation et envoie du mail
				$this->app->smarty->assign(array('Data' => $Data));
				$corp_message = $this->app->smarty->fetch( BASE_APP_PATH . 'view' . DS . 'connexion' . DS . 'email_lostpassword_french.tpl' );
				sendEmail($Email , $this->app->config['email'], 'Password request :: '. $this->app->config['titre_site'], strip_tags($corp_message), $corp_message);
				
				// Enregistrement dans la base
				$this->app->db->insert(PREFIX . 'user_reset_password', $Data);
				
				return $this->redirect( $this->app->Helper->getLink("connexion/index"), 5, $this->lang['Email_envoye_procedure'] );
			else:
				$this->app->smarty->assign('Error', 'E-mail not found');
				goto printform;
			endif;
			
		endif;
		
		printform:
		return $this->registry->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'connexion' . DS . 'lost_password.tpl');
	}
	
	public function resetPasswordAction(){
		
		if( $this->app->HTTPRequest->getExists('token') ):
		
			$token = $this->app->HTTPRequest->getData('token');
			
			// Verification existe dans la base
			$Result = $this->app->db->count(PREFIX . 'user_reset_password', array('token =' => $token));
			if($Result != 1) exit;
			
			// Recuperation des informations
			$Data = $this->app->db->get_one(PREFIX . 'user_reset_password', array('token =' => $token));
			
			// Verification que la demande date de moins de 30mins
			if( $Data['time_on_demand'] < (time() - (60*30)) ){
				$this->app->smarty->assign('Error', 'Request expired');
				return $this->lostPasswordAction();
			}
			
			// Recuperation des informations utilisateur
			$User = $this->app->db->get_one(PREFIX . 'user', array('email =' => $Data['email']) );
			
			// Generation du mot de passe
			$NewPassword = getChaine();
			$Password = cryptPassword($NewPassword, $User['identifiant']);
			
			// Sauvegarde dans la base
			$this->app->db->update(PREFIX . 'user', array('password' => $Password), array('id =' => $User['id'], 'email =' => $User['email']));
			
			// Suppression de la demande
			$this->app->db->delete(PREFIX . 'user_reset_password', null, array('token =' => $token) );
			
			// Envoie email
			$this->app->smarty->assign(array('Data' => $Data, 'NewPassword' => $NewPassword, 'User' => $User));
			$corp_message = $this->app->smarty->fetch( BASE_APP_PATH . 'view' . DS . 'connexion' . DS . 'email_sendpassword_french.tpl' );
				sendEmail($User['email'] , $this->app->config['email'], 'New password :: '. $this->app->config['titre_site'], strip_tags($corp_message), $corp_message);
			
			return $this->redirect( $this->app->Helper->getLink('connexion/index'),5, $this->lang['Votre_mot_de_passe_vient_etre_envoyer'] );
		else:
			exit;
		endif;
	}
}