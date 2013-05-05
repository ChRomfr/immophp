<?php

class contactController extends Controller{
	
    /**
     * Affiche la liste des contacts
     * 
     * @return type
     */
	public function indexAction(){
        
        if( $this->app->HTTPRequest->getExists('type') ):
            
            if( $this->app->HTTPRequest->getData('type') == 'biens' ):
                $Contacts =     $this->app->db
                                    ->select('bc.*, b.nom as b_nom, b.reference as b_reference')
                                    ->from(PREFIX . 'bien_contact bc')
                                    ->left_join(PREFIX . 'bien b','bc.bien_id = b.id')
                                    ->order('bc.id DESC')
                                    ->get();
            elseif( $this->app->HTTPRequest->getData('type') == 'agences' ):
                $Contacts =     $this->app->db
                                    ->select('ac.*, a.nom as a_nom')
                                    ->from(PREFIX . 'agence_contact ac')
                                    ->left_join(PREFIX . 'agence a','ac.agence_id = a.id')
                                    ->order('ac.id DESC')
                                    ->get();
            endif;
            
        else:
            $Contacts = $this->app->db->get(PREFIX . 'contact', null, 'id DESC');
        endif;
        
		$this->app->smarty->assign('Contacts', $Contacts);
		return $this->app->smarty->fetch(VIEW_PATH . 'contact' . DS . 'index.tpl');
	}
	
	public function viewAction($id){
        if( $this->app->HTTPRequest->getExists('type') ):
            if( $this->app->HTTPRequest->getData('type') == 'agences' ):
                return $this->viewAgence($id);
            elseif($this->app->HTTPRequest->getData('type') == 'biens' ):
                return $this->viewBien($id);
            endif;
        else:
            return $this->view($id);
        endif;		
	}
    
    private function view($id){
        $this->app->smarty->assign('contact', $this->app->db->get_one(PREFIX . 'contact', array('id =' => $id)));
		$this->app->db->update(PREFIX . 'contact', array('lu' => 1), array('id =' => $id) );
		return $this->app->smarty->fetch(VIEW_PATH . 'contact' . DS . 'view.tpl');
    }
    
    private function viewAgence($id){
        $Contact =     $this->app->db
                            ->select('ac.*, a.nom as a_nom')
                            ->from(PREFIX . 'agence_contact ac')
                            ->left_join(PREFIX . 'agence a','ac.agence_id = a.id')
                            ->where(array('ac.id =' => $id))
                            ->get_one();
        
        $this->app->db->update(PREFIX . 'agence_contact', array('read' => 1),array('id =' => $id));
        
        $this->app->smarty->assign('Contact', $Contact);
        
        return $this->app->smarty->fetch(VIEW_PATH . 'contact' . DS . 'view_agence.tpl');
    }
    
    private function viewBien($id){
        $Contact =     $this->app->db
                            ->select('bc.*, b.nom as b_nom, b.reference as b_reference')
                            ->from(PREFIX . 'bien_contact bc')
                            ->left_join(PREFIX . 'bien b','bc.bien_id = b.id')
                            ->where(array('bc.id =' => $id))
                            ->get_one();
        
        $this->app->db->update(PREFIX . 'bien_contact', array('read' => 1),array('id =' => $id));
        
        $this->app->smarty->assign('Contact', $Contact);
        
        return $this->app->smarty->fetch(VIEW_PATH . 'contact' . DS . 'view_bien.tpl');
    }
	
	public function deleteAction($id){
        if( $this->app->HTTPRequest->getExists('type') ):
            if( $this->app->HTTPRequest->getData('type') == 'agences' ):
                return $this->deleteAgence($id);
            elseif($this->app->HTTPRequest->getData('type') == 'biens' ):
                return $this->deleteBien($id);
            endif;
        else:
            return $this->delete($id);
        endif;
		
	}
    
    private function delete($id){
        $this->registry->db->delete(PREFIX . 'contact', $id);
		return $this->redirect(getLinkAdm("contact/index"),3,$this->lang['Message_supprime']);
    }
    
    private function deleteAgence($id){
        $this->registry->db->delete(PREFIX . 'agence_contact', $id);
		return $this->redirect(getLinkAdm("contact?type=agences"),3,$this->lang['Message_supprime']);
    }
    
     private function deleteBien($id){
        $this->registry->db->delete(PREFIX . 'bien_contact', $id);
		return $this->redirect(getLinkAdm("contact?type=biens"),3,$this->lang['Message_supprime']);
    }
}