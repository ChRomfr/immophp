<?php

abstract class AdmViewEditorController extends Controller{
	
	public function indexAction(){
		$Views	=	$this->app->db
						->select('*, vt.id as id')
						->from(PREFIX . 'view_template vt')
						->left_join(PREFIX . 'template_available ta','vt.template_id = ta.id')
						->order('nom')
						->get();

		$this->app->smarty->assign(array(
			'Views'		=>	$Views,
			'Dispo'		=>	$this->app->db->get(PREFIX . 'template_available', null, 'nom'),
		));

		# Generation de la page
		if( is_file( VIEW_PATH . 'viewEditor' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'viewEditor' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'viewEditor' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}

	public function addAction($tpl_id = null){
		
		if( $this->app->HTTPRequest->postExists('tpl') ):

			# Recuperation informations TPL
			$Template = new myObject( $this->app->db->get_one(PREFIX . 'template_available', array('id =' => $tpl_id)));

			# Recuperation des donnees du formulaire
			$Tpl = new myObject($this->app->HTTPRequest->postData('tpl'));

			# On complete les donnees
			$Tpl->creat_on = time();
			$Tpl->edit_on = time();
			$Tpl->name = $Template->nom;
			$Tpl->real_dir = str_replace('#','_',$Template->chemin);
			$Tpl->template_id = $tpl_id;
			$Tpl->token = uniqid();

			# On sauvegarde
			$this->app->db->insert(PREFIX . 'view_template', $Tpl);

			# On redirige l utilisateur
			return $this->redirect( $this->app->Helper->getLinkAdm('viewEditor/index'),3, 'Vue enregistree' );

		endif;

		if( empty($tpl_id) ):
			$tpl_id = $this->app->HTTPRequest->getData('vue_id');
		endif;

		# Recuperation du tpl dans la base
		$Tpl = new myObject( $this->app->db->get_one(PREFIX . 'template_available', array('id =' => $tpl_id)));

		# Parse du chemin
		$Tpl->chemin = str_replace('#', DS, $Tpl->chemin);

		# On recupere le contenu dans un fichier
		$Tpl->code = file_get_contents(ROOT_PATH . $Tpl->chemin);

		# On envoie a smarty
		$this->app->smarty->assign(array(
			'Tpl'	=>	$Tpl,
		));

		# Generation de la page
		if( is_file( VIEW_PATH . 'viewEditor' . DS . 'add.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'viewEditor' . DS . 'add.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'viewEditor' . DS . 'add.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}

	public function editAction($vue_id){

		if( $this->app->HTTPRequest->postExists('tpl') ):

			# Recuperation des donnees du formulaire
			$Tpl = new myObject($this->app->HTTPRequest->postData('tpl'));

			# On complete les donnees
			$Tpl->edit_on = time();

			# On sauvegarde
			$this->app->db->update(PREFIX . 'view_template', $Tpl);

			# On redirige l utilisateur
			return $this->redirect( $this->app->Helper->getLinkAdm('viewEditor/index'),3, 'Vue enregistree' );

		endif;

		# Recuperation de la vue a modifier
		$Vue = new myObject($this->app->db->get_one(PREFIX . 'view_template', array('id =' => $vue_id)));

		# Recuperation du tpl dans la base
		$Tpl = new myObject( $this->app->db->get_one(PREFIX . 'template_available', array('id =' => $Vue->template_id)));

		# Parse du chemin
		$Tpl->chemin = str_replace('#', DS, $Tpl->chemin);

		# On recupere le contenu dans un fichier
		$Tpl->code = file_get_contents(ROOT_PATH . $Tpl->chemin);

		# On envoie a smarty
		$this->app->smarty->assign(array(
			'Tpl'	=>	$Tpl,
			'Vue'	=>	$Vue
		));

		# Generation de la page
		if( is_file( VIEW_PATH . 'viewEditor' . DS . 'edit.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'viewEditor' . DS . 'edit.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'viewEditor' . DS . 'edit.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}

	public function deleteAction($vue_id){
		$this->app->db->delete(PREFIX . 'view_template', $vue_id);
		return $this->redirect( $this->app->Helper->getLinkAdm('viewEditor/index'), 3, 'Vue supprimee');
	}

}