<?php

abstract class Baseforumcontroller extends Controller{

	public function indexAction(){

		$this->load_manager('forum', 'base_app');

		$ForumsData = $this->manager->forum->getCategorieAndForumForIndex();

		$this->app->smarty->assign(array(
			'ctitre'		=>	'Forum',
			'ForumsData'	=>	$ForumsData,
		));

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'forum' . DS . 'index.tpl');
	}

	public function viewforumAction($forum_id){
		$per_page = 20;

		$this->load_manager('forum', 'base_app');

		# Recuperation du nombre de topic
		$NbThread = $this->manager->forum->getNumThreadByForum($forum_id);

		# Recuperation des topics
		$Threads = $this->manager->forum->getThreadByForumId($forum_id, $per_page, getOffset($per_page));

		# Recuperation des infos du forum
		$Forum = $this->manager->forum->getForum($forum_id);

		# Pagination
		$Pagination = new Zebra_Pagination();
		$Pagination->records_per_page($per_page);
		$Pagination->records($NbThread);

		$this->app->smarty->assign(array(
			'ctitre'				=>	'Forum :: '. $Forum['name'],
			'Threads'				=>	$Threads,
			'Forum'					=>	$Forum,
			'Pagination'			=>	$Pagination,
			'Description_this_page'	=>	$Forum['description'],
		));

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'forum' . DS . 'viewforum.tpl');
	}

	public function newthreadAction($forum_id){

		if( $_SESSION['utilisateur']['id'] == 'Visiteur'):
			return $this->indexAction();
		endif;

		$this->load_manager('forum', 'base_app');

		if( $this->app->HTTPRequest->postExists('thread') ):

			$Thread = new Basethread($this->app->HTTPRequest->postData('thread') );
			$Message = new Basemessage($this->app->HTTPRequest->postData('message'));

			# On valide les donnees deja presentes
			if( empty($Thread->titre) ):
				$this->app->smarty->assign('Error','Sujet obligatoire');
				goto printform;
			endif;

			if( empty($Message->message) ):
				$this->app->smarty->assign('Error','Message obligatoire');
				goto printform;
			endif;

			# On complete les donnees du sujet
			$Thread->forum_id = $forum_id;
			$Thread->auteur_id = $_SESSION['utilisateur']['id'];
			$Thread->prepareForSave();
			$Thread->id = $Thread->save();

			# On traite le message
			$Message->message = htmlentities($Message->message);
			$Message->forum_id = $forum_id;
			$Message->thread_id = $Thread->id;
			$Message->prepareForSave();
			$Message->save();

			# Redirection de l utilisateur
			return $this->redirect( $this->app->Helper->getLink('forum/viewtopic/'. $Thread->id),3, 'Sujet ajouté' );

		endif;

		printform:
		$this->getFormValidatorJs();

		$this->app->load_web_lib('markitup/skins/simple/style.css','css');
		$this->app->load_web_lib('markitup/bbcode/style.css','css');
		$this->app->load_web_lib('markitup/jquery.markitup.js','js');
		$this->app->load_web_lib('markitup/bbcode/set.js','js');

		$Forum = $this->manager->forum->getForum($forum_id);

		$this->app->smarty->assign(array(
			'ctitre'		=>	'Forum :: :: Nouveau sujet',
			'Forum'			=>	$Forum,
		));

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'forum' . DS . 'newthread.tpl');
	}

	public function viewtopicAction($thread_id){

		# Init du nombre de message par page
		$per_page = 20;

		# Chargement du manager
		$this->load_manager('forum', 'base_app');

		# On commpte le nombre de message
		$NbMessage = $this->app->db->count(PREFIX . 'forum_message', array('thread_id =' => $thread_id));

		# On recupere les messages
		$Messages = $this->manager->forum->getMessagesByThreadId($thread_id, $per_page, getOffset($per_page));

		# Recuperation infos topic
		$Thread = new Basethread($this->app->db->get_one(PREFIX . 'forum_thread', array('id =' => $thread_id)));

		# On traite la pagination
		$Pagination = new Zebra_Pagination();
		$Pagination->records($NbMessage);
		$Pagination->records_per_page($per_page);

		if( $this->isModerateur() == true ):
			$this->app->smarty->assign('Forums', $this->manager->forum->getAllForums());
		endif;
		
		# Envoie a smarty
		$this->app->smarty->assign(array(
			'ctitre'		=>	'Forum :: ' . $Thread->titre,
			'Messages'		=>	$Messages,
			'Thread'		=>	$Thread,
			'Pagination'	=>	$Pagination,
			'Forum'			=>	new myObject( $this->app->db->get_one(PREFIX . 'forum', array('id =' => $Thread->forum_id)) )
		));

		if( $_SESSION['utilisateur']['id'] != 'Visiteur' ):
			$this->getFormValidatorJs();

			$this->app->load_web_lib('markitup/skins/simple/style.css','css');
			$this->app->load_web_lib('markitup/bbcode/style.css','css');
			$this->app->load_web_lib('markitup/jquery.markitup.js','js');
			$this->app->load_web_lib('markitup/bbcode/set.js','js');
		endif;
		
		# Generation de la page
		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'forum' . DS . 'viewtopic.tpl');

	}

	public function addReplyAction($thread_id){

		$per_page = 20;

		if( $this->app->HTTPRequest->postExists('reply') && $_SESSION['utilisateur']['id'] != 'Visiteur' ):

			$Thread = new Basethread($this->app->db->get_one(PREFIX . 'forum_thread', array('id =' => $thread_id)));

			if( empty($Thread) ):
				return $this->redirect( $this->app->Helper->getLink('forum'), 3, 'Le sujet n\'existe pas ou plus !' );
			endif;

			if( $Thread->closed == 1 ):
				return $this->redirect( $this->app->Helper->getLink('forum/viewtopic/'. $thread_id), 3, 'Ce sujet est fermé !' );
			endif;

			$Message = new Basemessage($this->app->HTTPRequest->postData('reply')); 

			if( empty($Message->message) ):
				return $this->redirect( $this->app->Helper->getLink('forum/viewtopic/'. $thread_id), 3, 'Votre réponse est vide !' );
			endif;

			# On traite le message
			$Message->message = htmlentities($Message->message);
			$Message->forum_id = $Thread->forum_id;
			$Message->thread_id = $thread_id;
			$Message->prepareForSave();
			$Message->id = $Message->save();

			# On met a jour le thread
			$Thread->last_auteur_id = $_SESSION['utilisateur']['id'];
			$Thread->last_message_date = TimeToDATETIME();
			$Thread->save();
			
			# On calcul la page de redirection
			$page = floor($this->app->db->count(PREFIX . 'forum_message', array('thread_id =' => $thread_id)) / $per_page) + 1;
			# On redirige l utilisateur
			return $this->redirect( $this->app->Helper->getLink('forum/viewtopic/'. $thread_id.'?page='.$page.'#message-'. $Message->id), 3, 'Réponse enregistrée' );

		endif;

		return $this->redirect( $_SERVER['HTTP_REFERER'],0,'');
	}

	public function editreplyformAction($message_id){

		$Message = new Basemessage();
		$Message->get($message_id);
		
		$Thread = new Basethread();
		$Thread->get($Message->thread_id);

		$this->app->smarty->assign(array(
			'Message'		=>	$Message,
			'Thread'		=>	$Thread,
		));

		return $this->app->smarty->fetch(BASE_APP_PATH . 'view' . DS . 'forum' . DS . 'editreplyform.tpl');
	}

	public function editReplyAction($message_id){

		if( $this->app->HTTPRequest->postExists('replyedit') ):

			$Message = new Basemessage($this->app->HTTPRequest->postData('replyedit'));
			$Message->edit_on = TimeToDATETIME();
			$Message->edit = 1;
			$Message->id = $message_id;
			$Message->save();

			$Message->get($message_id);

			$Thread = new Basethread();
			$Thread->get($Message->thread_id);

			return $this->redirect( $this->app->Helper->getLink('forum/viewtopic/'. $Thread->id), 3, 'Message modifié' );
		endif;

		return $this->indexAction();
	}


	public function deletereplyAction($message_id){

		if( $this->isModerateur() == false ):
			return $this->indexAction();
		endif;

		$Message = new Basemessage();
		$Message->get($message_id);
		$oldmessage = $Message->message;
		$Message->message = 'Supprimer par modérateur';
		$Message->save();

		$Log = new Baselogmoderation();
		$Log->date_action = TimeToDATETIME();
		$Log->moderateur_id = $_SESSION['utilisateur']['id'];
		$Log->forum_id = $Message->forum_id;
		$Log->thread_id = $Message->thread_id;
		$Log->message_id = $message_id;
		$Log->action = "Suppression d une message";
		$Log->detail = $oldmessage;
		$Log->save();

		$this->app->smarty->assign(array(
			'FlashMessage'		=>	'Message supprimé',
		));

		return $this->viewtopicAction($Message->thread_id);

	}

	public function movetopicAction($topic_id){
		# Verification des droits
		if( $this->isModerateur() == false ):
			return $this->indexAction();
		endif;

		if( $this->app->HTTPRequest->postExists('thread') ):
			$Topic = new Basethread( $this->app->HTTPRequest->postData('thread')  );
			$Topic->save();

			$this->app->db->query('UPDATE '. PREFIX . 'forum_message SET forum_id = "'. $Topic->forum_id .'" WHERE thread_id = "'. $Topic->id .'"');

			$Log = new Baselogmoderation();
			$Log->date_action = TimeToDATETIME();
			$Log->moderateur_id = $_SESSION['utilisateur']['id'];
			$Log->thread_id = $topic_id;
			$Log->action = "Deplacement sujet";
			$Log->save();

		endif;

		$this->app->smarty->assign('FlashMessage','Sujet deplacé');

		return $this->viewtopicAction($topic_id);
	}

	/**
	 * [locksujetAction description]
	 * @param  [type] $thread_id [description]
	 * @return [type]            [description]
	 */
	public function locksujetAction($thread_id){

		# Verification des droits
		if( $this->isModerateur() == false ):
			return $this->indexAction();
		endif;

		$Thread = new Basethread();
		$Thread->id = $thread_id;
		$Thread->closed = 1;
		$Thread->save();

		$Log = new Baselogmoderation();
		$Log->date_action = TimeToDATETIME();
		$Log->moderateur_id = $_SESSION['utilisateur']['id'];
		$Log->thread_id = $thread_id;
		$Log->action = "Verouillage du topic";
		$Log->save();

		$this->app->smarty->assign('FlashMessage','Sujet verouillé');

		return $this->viewtopicAction($thread_id);
	}	

	public function unlocksujetAction($thread_id){

		# Verification des droits
		if( $this->isModerateur() == false ):
			return $this->indexAction();
		endif;

		$Thread = new Basethread();
		$Thread->id = $thread_id;
		$Thread->closed = '2';
		$Thread->save();

		$Log = new Baselogmoderation();
		$Log->date_action = TimeToDATETIME();
		$Log->moderateur_id = $_SESSION['utilisateur']['id'];
		$Log->thread_id = $thread_id;
		$Log->action = "Deverouillage du topic";
		$Log->save();

		$this->app->smarty->assign('FlashMessage','Sujet déverouillé');

		return $this->viewtopicAction($thread_id);
	}

	public function alertemessageAction($message_id){

		if( $_SESSION['utilisateur']['id'] == 'Visiteur'):
			return $this->indexAction();
		endif;

		# Verification si deja une alerte pour ce message
		if( $this->app->db->count(PREFIX . 'forum_message_alerte', array('id =' => $message_id, 'traite =' => 0)) ):
			return $this->redirect( $_SERVER['HTTP_REFERER'], 3, 'Ce message a déjà été signaler. L\'alerte est en cour de traitement');	
		endif;

		# Recuperation du message
		$Message = new Basemessage();
		$Message->get($message_id);

		# Alerte
		$Alerte  = new Basemessagealerte();
		$Alerte->message_id = $message_id;
		$Alerte->auteur_id = $_SESSION['utilisateur']['id'];
		$Alerte->date_alerte = TimeToDATETIME();
		$Alerte->traite = 0;
		$Alerte->save();

		return $this->redirect( $_SERVER['HTTP_REFERER'], 3, 'Alerte envoyée');
	}	

	public function deletetopicAction($topic_id){
		# Verification des droits
		if( $this->isModerateur() == false ):
			return $this->indexAction();
		endif;

		$Topic = new Basethread();
		$Topic->get($topic_id);

		$this->app->db->delete(PREFIX . 'forum_message', null, array('thread_id =' => $topic_id));
		$this->app->db->delete(PREFIX . 'forum_thread', null, array('id =' => $topic_id));

		$Log = new Baselogmoderation();
		$Log->date_action = TimeToDATETIME();
		$Log->moderateur_id = $_SESSION['utilisateur']['id'];
		$Log->action = "Suppression du sujet : ". $Topic->titre;
		$Log->save();

		$this->app->smarty->assign('FlashMessage','Sujet supprimé');

		return $this->viewforumAction($Topic->forum_id);
	}

	private function isModerateur(){
		if( $_SESSION['utilisateur']['isAdmin'] > 0 ):
			return true;
		endif;

		if( isset($_SESSION['utilisateur']['groupes']['moderateurs']) ):
			return true;
		endif;

		if( isset($_SESSION['utilisateur']['groupes']['administrateurs']) ):
			return true;
		endif;

		return false;
	}

}