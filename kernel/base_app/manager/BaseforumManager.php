<?php

class BaseforumManager extends BaseModel{

	public function getCategorieAndForumForIndex(){

		$Data	=	$this->getCategories();

		$i=0;

		foreach($Data as $Row):

			$Data[$i]['forums'] = $this->getForums($Row['id']);
			$y = 0;
			foreach($Data[$i]['forums'] as $forum):
				$Data[$i]['forums'][$y]['nb_thread'] = $this->getNumThreadByForum($forum['id']);
				$Data[$i]['forums'][$y]['nb_message'] = $this->getNumMessageByForum($forum['id']);
				$Data[$i]['forums'][$y]['last_message'] = $this->getLastMessageForum($forum['id']);
				$y++;
			endforeach;
			$i++;

		endforeach;

		return $Data;
	}

	/**
	 * Recupere les categories des forums
	 * @return [type] [description]
	 */
	public function getCategories(){

		return 	$this->db
					->select('*')
					->from(PREFIX . 'forum_categorie')
					->where(array( 'visible =' => 1 ))
					->order('ordre, name')
					->get();

	}

	/**
	 * Recupere les forums d une categorie
	 * @param  [type] $categorie_id [description]
	 * @return [type]               [description]
	 */
	public function getForums($categorie_id){
		return 	$this->db
					->select('*')
					->from(PREFIX . 'forum')
					->where(array('categorie_id =' => $categorie_id, 'visible =' => 1 ))
					->order('ordre, name')
					->get();
	}

	/**
	 * Retourne le nombre de Topic d un forum
	 * @param  [type] $forum_id [description]
	 * @return [type]           [description]
	 */
	public function getNumThreadByForum($forum_id){
		return $this->db->count(PREFIX . 'forum_thread', array('forum_id =' => $forum_id, 'visible =' => 1 ));
	}

	/**
	 * Recuperer le nombre de message d un forum
	 * @param  [type] $forum_id [description]
	 * @return [type]           [description]
	 */
	public function getNumMessageByForum($forum_id){

	}

	public function getLastMessageForum($forum_id){
		return 	$this->db
					->select('fm.id, ft.titre as thread, ft.id as thread_id, fm.add_on, u.identifiant')
					->from(PREFIX . 'forum_message fm')
					->left_join(PREFIX . 'forum_thread ft','fm.thread_id = ft.id')
					->left_join(PREFIX . 'user u','fm.auteur_id = u.id')
					->where(array('fm.forum_id =' => $forum_id))
					->order('id DESC')
					->get_one();
	}

	public function countThread($forum_id){
		return $this->db->count(PREFIX . 'forum_thread', array('forum_id =' => $forum_id) );
	}

	public function getThreadByForumId($forum_id, $limit=10, $offset=0){
		return 	$this->db
					->select('ft.* , uft.identifiant as auteur, (SELECT COUNT(id) FROM '.PREFIX .'forum_message sfm WHERE sfm.thread_id = ft.id) as nb_message, u2ft.identifiant as last_auteur')
					->from(PREFIX . 'forum_thread ft')
					->left_join(PREFIX . 'user uft','ft.auteur_id = uft.id')
					->left_join(PREFIX . 'user u2ft','ft.last_auteur_id = u2ft.id')
					->left_join(PREFIX . 'forum_message fm','ft.id = fm.thread_id')
					->where(array('ft.forum_id =' => $forum_id, 'ft.visible =' => 1))
					->group_by('ft.id')
					->order('ft.last_message_date DESC')
					->limit($limit)
					->offset($offset)
					->get();
	}

	public function getForum($forum_id){
		return 	$this->db
					->select('f.*')
					->from(PREFIX . 'forum f')
					->where(array('f.id =' => $forum_id))
					->get_one();
	}

	public function getMessagesByThreadId($thread_id, $limit, $offset){

		return 	$this->db
					->select('fm.*, u.identifiant as auteur, u.avatar, (SELECT COUNT(fma.id) FROM '. PREFIX . 'forum_message_alerte fma WHERE fma.message_id = fm.id AND fma.traite = 0) as alerte')
					->from(PREFIX . 'forum_message fm')
					->left_join(PREFIX . 'user u', 'fm.auteur_id = u.id')
					->where(array('fm.thread_id =' => $thread_id))
					->order('fm.add_on ASC')
					->limit($limit)
					->offset($offset)					
					->get();

	}

	public function getAllForums(){
		return 	$this->db
					->select('f.*, fc.name as categorie')
					->from(PREFIX . 'forum f')
					->left_join(PREFIX . 'forum_categorie fc','f.categorie_id = fc.id')
					->order('ordre, f.name')
					->get();
	}

	public function getAlertes($limit = 10, $offset = 0){
		return 	$this->db
					->select('fma.*, u.identifiant, u2.identifiant as rapporteur, fm.thread_id')
					->from(PREFIX . 'forum_message_alerte fma')
					->left_join(PREFIX . 'user u','fma.auteur_id = u.id')
					->left_join(PREFIX . 'user u2','fma.auteur_id = u2.id')
					->left_join(PREFIX . 'forum_message fm','fm.id = fma.message_id')
					->order('fma.date_alerte DESC')
					->limit($limit)
					->offset($offset)
					->get();
	}

	public function getLastAlerteNonTraite($limit = 10){
		return 	$this->db
					->select('fma.*, u.identifiant, u2.identifiant as rapporteur, fm.thread_id')
					->from(PREFIX . 'forum_message_alerte fma')
					->left_join(PREFIX . 'user u','fma.auteur_id = u.id')
					->left_join(PREFIX . 'user u2','fma.auteur_id = u2.id')
					->left_join(PREFIX . 'forum_message fm','fm.id = fma.message_id')
					->where(array('fma.traite =' => 0))
					->order('fma.date_alerte DESC')
					->limit($limit)
					->get();
	}

	public function getLastLogModeration($limit = 10){

		return 	$this->db
					->select('flm.*, u.identifiant as moderateur')
					->from(PREFIX . 'forum_log_moderation flm')
					->left_join(PREFIX . 'user u','flm.moderateur_id = u.id')
					->order('flm.date_action DESC')
					->limit($limit)
					->get();

	}
}