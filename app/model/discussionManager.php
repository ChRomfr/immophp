<?php
if( !defined('IN_VA') ) exit;

class discussionManager extends BaseModel{

	/*
	public function getByUserId($id){
		return $this->db->select('DISTINCT(d.id), d.sujet, d.last_update, MAX(m.id) AS last_id_message')
				->from(PREFIX . 'discussion d')
				->left_join(PREFIX .'messbox m', 'm.discussion_id = d.id')
				->where_free('auteur_id = '. $id .' OR destinataire_id = '. $id)
				->get();
	}*/
	
	/**
	 * Recupere la liste discution avec les destinataire/auteur et les nombre de message non lus dans la discussion
	 * @param int $id : id de l'utilisateur
	 * @return mixed : liste des discussion
	 */
	public function getForIndexByUserId($id){
		$Query = '
			SELECT DISTINCT(d.id), d.sujet, d.last_update, m.destinataire_id, u2.identifiant AS destinataire, u1.identifiant AS auteur, m.auteur_id,
			(SELECT count(m.lu) FROM '. PREFIX . 'messbox m WHERE m.discussion_id = d.id AND destinataire_id = 1 AND m.lu=0) AS not_read
			FROM '. PREFIX . 'messbox m
			LEFT JOIN '. PREFIX . 'discussion d ON d.id = m.discussion_id
			LEFT JOIN '. PREFIX . 'user u1 ON u1.id = m.auteur_id
			LEFT JOIN '. PREFIX . 'user u2 ON u2.id = m.destinataire_id
			WHERE auteur_id = '. $id .' OR destinataire_id = '. $id;
			
		$Sql = $this->db->query($Query);
		return $Sql->fetchAll(PDO::FETCH_ASSOC);
	}
	
	public function insert(discussion $discussion){
		return $this->db->insert(PREFIX . 'discussion', $discussion);
	}
	
	public function update(discussion $discussion){
	}
	
	public function isInDiscussion($uid, $did){
		$Result = $this->db->select('COUNT(id) AS nb')
					->from(PREFIX . 'messbox')
					->where_free(' destinataire_id = '. $uid . ' OR auteur_id = '. $uid . ' AND discussion_id = '. $did)
					->get_one();
					
		return $Result['nb'];
	}
	
	public function delete($id){
		$this->db->delete(PREFIX . 'discussion', $id);
		$this->db->delete(PREFIX . 'messbox', null, array('discussion_id =' => $id));
	}
	
}