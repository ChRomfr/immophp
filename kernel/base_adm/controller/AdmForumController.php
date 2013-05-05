<?php

abstract class AdmForumController extends Controller{

	public function indexAction(){

		$this->load_manager('forum','base_app');

		#  	Recuperation des alertes non traite
		$Alertes = $this->manager->forum->getLastAlerteNonTraite();
		
		#  	Recuperation des dernieres actions de moderation
		$Logs = $this->manager->forum->getLastLogModeration();

		# 	Affichage des categore/index
		
		$this->app->smarty->assign(array(
			'Logs'				=>	$Logs,
			'Alertes'			=>	$Alertes,
			'ForumsData'		=>	$this->manager->forum->getCategorieAndForumForIndex(),
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'forum' . DS . 'index.tpl');
	}

	public function traitealerteAction($alerte_id){

		$Alerte = new Basemessagealerte();
		$Alerte->get($alerte_id);
		$Alerte->traite = 1;
		$Alerte->save();

		$Log = new Baselogmoderation();
		$Log->date_action = TimeToDATETIME();
		$Log->moderateur_id = $_SESSION['utilisateur']['id'];
		$Log->action = "Traitement de l'alerte #". $Alerte->id;
		$Log->save();

		$this->app->smarty->assign('FlashMessage','Alerte traitée');

		return $this->indexAction();
	}

	/**
	 * Affiche et traite le formulaire pour ajouter une categorie
	 * @return [type] [description]
	 */
	public function categorieaddAction(){

		if( $this->app->HTTPRequest->postExists('categorie') ):

			$Categorie = new myObject($this->app->HTTPRequest->postData('categorie') );

			$Categorie->add_by = $_SESSION['utilisateur']['id'];
			$Categorie->add_on = TimeToDATETIME();

			$Categorie->image = $this->savePhoto('image');

			if( $Categorie->image == false):
				$Categorie->image = '';
			endif;

			$this->app->db->insert(PREFIX . 'forum_categorie', $Categorie);

			return $this->redirect( $this->app->Helper->getLinkAdm('forum'), 3, $this->lang['Categorie_ajoutee'] );
		endif;

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'forum' . DS . 'categorieadd.tpl');
	}
	public function categorieeditAction($categorie_id){

		if( $this->app->HTTPRequest->postExists('categorie') ):

			$Categorie = new myObject($this->app->HTTPRequest->postData('categorie') );

			$Categorie->edit_by = $_SESSION['utilisateur']['id'];
			$Categorie->edit_on = TimeToDATETIME();
			$Categorie->id = $categorie_id;

			if( isset($_POST['delete_image']) ):
				$Categorie->image = '';
			endif;

			$Categorie->image = $this->savePhoto('image');

			if( $Categorie->image == false):
				$Categorie->image = '';
			endif;

			$this->app->db->update(PREFIX . 'forum_categorie', $Categorie);

			return $this->redirect( $this->app->Helper->getLinkAdm('forum'), 3, $this->lang['Categorie_modifiee'] );
		endif;

		$Categorie = new myObject( $this->app->db->get_one(PREFIX . 'forum_categorie', array('id =' => $categorie_id)) );

		$this->app->smarty->assign(array(
			'Categorie'		=>	$Categorie,
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'forum' . DS . 'categorieedit.tpl');

	}

	/**
	 * Supprime une categorie
	 * @param  [type] $categorie_id [description]
	 * @return [type]               [description]
	 */
	public function categoriedeleteAction($categorie_id){
		$this->app->db->delete(PREFIX . 'forum_categorie', $categorie_id);

		# Mise a jour des forum
		$this->app->db->query( 'UPDATE '. PREFIX . 'forum SET categorie_id = 0 WHERE categorie_id = '. $categorie_id . ' ');

		# Ajout d'un log
		$Log = new Baselogmoderation();
		$Log->date_action = TimeToDATETIME();
		$Log->moderateur_id = $_SESSION['utilisateur']['id'];
		$Log->action = "Suppression de la categorie #". $categorie_id;
		$Log->save();

		$this->app->smarty->assign('FlashMessage', $this->lang['Categorie_supprimee']);

		return $this->indexAction();
	}
	
	public function forumaddAction($categorie_id){

		if( $this->app->HTTPRequest->postExists('forum') ):
			$Forum = new myObject($this->app->HTTPRequest->postData('forum') );
			$Forum->add_by = $_SESSION['utilisateur']['id'];
			$Forum->add_on = TimeToDATETIME();
			$Forum->categorie_id = $categorie_id;

			$Forum->image = $this->savePhoto('image');

			if( $Forum->image == false):
				$Forum->image = '';
			endif;

			$this->app->db->insert(PREFIX . 'forum', $Forum);

			return $this->redirect( $this->app->Helper->getLinkAdm('forum'), 3, $this->lang['Forum_ajoute'] );
		endif;

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'forum' . DS . 'forumadd.tpl');
	}

	/**
	 * Affiche et traite le forum d edition
	 * @param  [type] $id [description]
	 * @return [type]     [description]
	 */
	public function forumeditAction($id){

		if( $this->app->HTTPRequest->postExists('forum') ):

			$Forum = new myObject($this->app->HTTPRequest->postData('forum') );
			$Forum->add_by = $_SESSION['utilisateur']['id'];
			$Forum->add_on = TimeToDATETIME();
			$Forum->id = $id;

			$Forum->image = $this->savePhoto('image');

			if( isset($_POST['delete_image']) ):
				$Forum->image = '';
			endif;

			if( $Forum->image == false && !isset($_POST['delete_image'])):
				unset($Forum->image);
			endif;

			$this->app->db->update(PREFIX . 'forum', $Forum);

			return $this->redirect( $this->app->Helper->getLinkAdm('forum'), 3, $this->lang['Forum_modfie'] );
		endif;

		$Forum = new myObject( $this->app->db->get_one(PREFIX . 'forum', array('id =' => $id)) );

		$this->app->smarty->assign(array(
			'Forum'			=>	$Forum,
			'Categories'	=>	$this->app->db->get(PREFIX . 'forum_categorie'),
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'forum' . DS . 'forumedit.tpl');
	}

	public function forumdeleteAction($id){

		$this->app->db->delete(PREFIX . 'forum', $id);
		$this->app->db->query( 'UPDATE '. PREFIX .'forum_message SET forum_id = 0 WHERE forum_id = '. $id .'');
		$this->app->db->query( 'UPDATE '. PREFIX .'forum_thread SET forum_id = 0 WHERE forum_id = '. $id .'');

		# Ajout d'un log
		$Log = new Baselogmoderation();
		$Log->date_action = TimeToDATETIME();
		$Log->moderateur_id = $_SESSION['utilisateur']['id'];
		$Log->action = "Suppression du forum #". $id;
		$Log->save();

		$this->app->smarty->assign('FlashMessage', $this->lang['Forum_supprime']);

		return $this->indexAction();
	}

	public function alertesAction(){

		$per_page = 50;

		$this->load_manager('forum','base_app');

		$NbAlertes = $this->app->db->count(PREFIX . 'forum_message_alerte');
		$Alertes = $this->manager->forum->getAlertes($per_page, getOffset($per_page));

		$Pagination = new Zebra_Pagination();
		$Pagination->records_per_page($per_page);
		$Pagination->records($NbAlertes);

		$this->app->smarty->assign(array(
			'Alertes'		=>	$Alertes,
			'Pagination'	=>	$Pagination,
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'forum' . DS . 'alertes.tpl');
	}

	public function logsAction(){

		$per_page = 50;

		$this->load_manager('forum','base_app');

		$NbLogs = $this->app->db->count(PREFIX . 'forum_log_moderation');
		$Logs = $this->manager->forum->getLastLogModeration($per_page, getOffset($per_page));

		$Pagination = new Zebra_Pagination();
		$Pagination->records_per_page($per_page);
		$Pagination->records($NbLogs);

		$this->app->smarty->assign(array(
			'Logs'			=>	$Logs,
			'Pagination'	=>	$Pagination,
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'forum' . DS . 'logs.tpl');
	}

	/**
	 * Enregistrement l image sur le serveur
	 * @param  string nom de la var $_FILE qui contient l image
	 * @return string|bool le nom de l image ou false si l enregistrement a echoue
	 */
	private function savePhoto($file){
		$Dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'categorie' . DS;
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php';
		
		if( !is_dir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'categorie' . DS) ):
			@mkdir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'categorie' . DS);
		endif;

		if( !is_dir($Dir) ):
			@mkdir($Dir);
		endif;
		
		$Fichier = new Upload($_FILES[''.$file.'']);

		if($Fichier->uploaded):
			$Fichier->allowed = 'image/*';
            $Fichier->file_overwrite = true;
            $Fichier->file_new_name_body  = microtime(true);
			$Fichier->image_resize          = true;
			$Fichier->image_ratio_y         = true;
			$Fichier->image_x               = 250;
            $Fichier->process($Dir);

            if( $Fichier->processed ):
            	return $Fichier->file_dst_name;
            else:
            	return false;
            endif;
		endif;

		return false;
	}
}