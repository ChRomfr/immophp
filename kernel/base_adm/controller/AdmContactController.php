<?php

abstract class AdmContactController extends Controller{

	public function indexAction(){

		# Recuperation du nombre de contacts
		$NbContacts = $this->app->db->count(PREFIX . 'contact');

		# Recuperation des contacts
		$Contacts = $this->app->db->get(PREFIX . 'contact', null, 'id DESC');

		# Pagination
		$Pagination = new Zebra_Pagination();
		$Pagination->records($NbContacts);
		$Pagination->records_per_page(20);

		# Envoie a smarty
		$this->app->smarty->assign(array(
			'Contacts'		=>	$Contacts,
			'Pagination'	=>	$Pagination,
		));

		# Generation de la page
		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'contact' . DS . 'index.tpl');
	}

	public function viewAction($id){

		$this->app->smarty->assign('contact', $this->app->db->get_one(PREFIX . 'contact', array('id =' => $id)));
		$this->app->db->update(PREFIX . 'contact', array('lu' => 1), array('id =' => $id) );
		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'contact' . DS . 'view.tpl');
	}

	public function deleteAction($id){
        $this->app->db->delete(PREFIX . 'contact', $id);
		return $this->redirect($this->app->Helper->getLinkAdm("contact"),3,$this->lang['Message_supprime']);
    }
}