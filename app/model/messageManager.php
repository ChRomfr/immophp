<?php
if( !defined('IN_VA') ) exit;

class messageManager extends BaseModel{
	
	public function insert(message $message){
		return $this->db->insert(PREFIX . 'messbox', $message);
	}
	
	public function getByDiscussionId($did){
		return 	$this->db->select('m.*, d.sujet, u.identifiant AS auteur, u.avatar, d.reply')
				->from(PREFIX .'messbox m')
				->left_join(PREFIX . 'discussion d', 'd.id = m.discussion_id')
				->left_join(PREFIX . 'user u', 'u.id = m.auteur_id')
				->where(array('m.discussion_id =' => $did))
				->order('m.post_on DESC')
				->get();
	}
	
	public function setReadMessageByDiscussionAndUser($did, $uid){
		$this->db->update(PREFIX . 'messbox m', array('lu' => 1), array('discussion_id =' => $did, 'destinataire_id =' => $uid));
	}
	
}