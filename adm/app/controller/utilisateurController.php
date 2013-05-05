<?php
if( !defined('IN_ADMIN') ) exit;
if( !defined('IN_VA') ) exit;
if( ADM_USER_LEVEL > $_SESSION['utilisateur']['isAdmin']) exit;

class utilisateurController extends AdmUtilisateurController{
		
    public function addAction(){
      
        if( $this->app->HTTPRequest->postExists('user') ){
            
			// Traitement du formulaire
			$this->load_model('utilisateur');
			$user = new utilisateur($this->registry->HTTPRequest->postData('user') );
			$this->load_manager('utilisateur');
			
			if( $user->isValid() == false ) goto print_form;
				
			if( $user->validPassword($_POST['user']['password2']) == false ){
				$this->app->smarty->assign('print_error', $this->lang['Mot_de_passe_invalide']);
				goto print_form;
			}
			
			$user->setActif(1);	
			
			$user->cryptPassword();
			$user->register_on = time();
			$user->isAdmin = 1;
			$user->last_connexion = 0;
			
			$user_id = $this->manager->utilisateur->insert($user);			
            
			return $this->redirect(getLinkAdm('utilisateur/edit/' . $user_id), 3, $this->lang['Compte_cree']);
		}
        
        print_form:
        $this->getFormValidatorJs();

        $this->load_manager('agence','admin');

        $this->app->smarty->assign('Agences', $this->manager->agence->getAll());
        return $this->app->smarty->fetch(VIEW_PATH . 'utilisateur' . DS . 'add.tpl');
    }
    
	public function editAction($id){
		$this->load_manager('utilisateur','admin');
		$this->load_manager('agence','admin');
		
		if( $this->registry->HTTPRequest->postExists('user') ){
			$this->manager->utilisateur->update($this->registry->HTTPRequest->postData('user'));
			return $this->redirect(getLinkAdm('utilisateur/index'),3,$this->lang['Utilisateur_modifie']);
		}
		
		$this->app->smarty->assign(array(
			'user'		=>	$this->manager->utilisateur->getById($id),
			'Agences'	=>	$this->manager->agence->getAll(),
		));
		
		return $this->registry->smarty->fetch(VIEW_PATH . 'utilisateur' . DS . 'edit.tpl');
	}
	
	public function deleteAction($id){
		$this->load_manager('utilisateur','admin');
		$this->manager->utilisateur->delete($id);
		return $this->redirect(getLinkAdm('utilisateur/index'),3,$this->lang['Utilisateur_supprime']);
	}
	
}