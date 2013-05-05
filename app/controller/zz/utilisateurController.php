<?php

class utilisateurController extends BaseutilisateurController{
/*
	public function indexAction(){
		if( $_SESSION['utilisateur']['id'] == 'Visiteur')
			return $this->registerAction();
		else
			return $this->profilAction();
	}
	
	
	public function signatureAction(){
	
		if( $this->app->HTTPRequest->postExists('signature') ):
			$Signature = $this->app->HTTPRequest->postData('signature');
			
			if( !isset($Signature['signature_img']) ) goto printform;
			
			// Formatage couleur
			if( $Signature['signature_color_text'] != '' ):
				$Signature['signature_color_text'] = str_replace('rgb(','',$Signature['signature_color_text']);
				$Signature['signature_color_text'] = str_replace(')','',$Signature['signature_color_text']);
			endif;
			
			$this->app->db->update(PREFIX . 'user', $Signature, array('id =' => $_SESSION['utilisateur']['id']));
			$_SESSION['utilisateur']['signature_img'] = $Signature['signature_img'];
			$_SESSION['utilisateur']['signature_color_text'] = $Signature['signature_color_text'];
			//var_dump($Signature);
			//return $this->redirect( getLink('utilisateur/index'), 3, $this->lang['Signature_enregistree']);
		endif;
		
		printform:
		
		// Recuperation des images dans le dossier
		$Tpl = getFilesInDir( ROOT_PATH . 'web' . DS . 'images' . DS . 'signature' . DS);
		unset($Tpl['signature.php']);	// on supprime le fichier de generation des signatures
		
		$this->app->addJS('mColorPicker.js');
		
		$this->app->smarty->assign(array(
			'c_titre'		=>	$this->lang['Signature'],
			'Tpls'			=>	$Tpl,
		));
		
		return $this->app->smarty->fetch( VIEW_PATH . 'utilisateur' . DS . 'signature.tpl');
		
	}
*/	
}
