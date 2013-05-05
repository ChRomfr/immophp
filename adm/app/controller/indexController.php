<?php
if( !defined('IN_ADMIN') ) exit;
if( !defined('IN_VA') ) exit;

class indexController extends Controller{

	public function indexAction(){
				
		$this->app->smarty->assign(array(
			'ctitre'			=>	$this->lang['Administration'],
		));
		
        // Librairie pour graph
        $this->registry->load_web_lib('fullcalendar/fullcalendar.css','css');
        $this->registry->load_web_lib('fullcalendar/fullcalendar.print.css','css');
        $this->registry->load_web_lib('flot/jquery.flot.js','js');
        $this->registry->load_web_lib('flot/jquery.flot.pie.js','js');
        $this->registry->load_web_lib('fullcalendar/fullcalendar.min.js','js');
       
        
		return $this->app->smarty->fetch(VIEW_PATH . 'index' . DS . 'index.tpl');
	}	
    
    public function ajaxGetNotReadContact(){
        $Contacts = $this->app->db->get(PREFIX . 'contact', array('lu =' => 0) );
        $this->app->smarty->assign(array(
            'Contacts'      =>  $Contacts,
        ));
        return $this->app->smarty->fetch( VIEW_PATH . 'index' . DS . 'ajax_contact_not_read.tpl');
    }
    
    public function ajaxGetNotReadContactAnnonceAction(){
        $Contacts =     $this->app->db
                            ->select('bc.*, b.nom as b_nom, b.reference as b_reference')
                            ->from(PREFIX . 'bien_contact bc')
                            ->left_join(PREFIX . 'bien b','bc.bien_id = b.id')
                            ->where(array('bc.read =' => 0))
                            ->get();

        $this->app->smarty->assign(array(
            'Contacts'      =>  $Contacts,
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'index' . DS . 'ajax_bien_contact_not_read.tpl');
    }
    
    public function ajaxGetNotReadContactAgenceAction(){
        $Contacts =     $this->app->db
                            ->select('ac.*, a.nom as a_nom')
                            ->from(PREFIX . 'agence_contact ac')
                            ->left_join(PREFIX . 'agence a','ac.agence_id = a.id')
                            ->where(array('ac.read =' => 0))
                            ->get();

        $this->app->smarty->assign(array(
            'Contacts'      =>  $Contacts,
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'index' . DS . 'ajax_agence_contact_not_read.tpl');
    }
    
    /**
     * Affiche la tableau des futur visites
     * @return string
     */
    public function ajaxGetVisiteAction(){
        $this->load_manager('visite','admin');
        $Visites = $this->manager->visite->getFutureByUserId($_SESSION['utilisateur']['id']);
        
        if( empty($Visites) || count($Visites) == 0):
            return '';
        else:
            $this->app->smarty->assign('Visites',$Visites);
            return $this->app->smarty->fetch( VIEW_PATH . 'index' . DS . 'ajax_visite_futur.tpl' );
        endif;
    }
    
    public function ajaxStatsAction(){

        $NbBien = $this->app->db->count(PREFIX . 'bien b', array('b.delete =' => 0));
        $NbProspect = $this->app->db->count(PREFIX . 'prospect p', array('p.delete =' => 0));
        $NbVisite = $this->app->db->count(PREFIX . 'visite');

        $date_start = date('Y') . '-' . date('m') . '-01';
        $date_end = date('Y') . '-' . date('m') . '-' . date('d');

        $NbBienVenduMois = $this->app->db->count(PREFIX . 'bien b', array('b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end));
        $NbBienSaisieMois = $this->app->db->count(PREFIX . 'bien b', array('b.delete =' => 0, 'b.add_on_sql >=' => $date_start, 'b.add_on_sql <=' => $date_end));

        $Tmp = $this->app->db->select('SUM(prix_vente) as total_vente')->from(PREFIX . 'bien b')->where( array('b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end) )->get_one();
        $TotalVente = $Tmp['total_vente'];

        $Tmp = $this->app->db->select('SUM(montant_frais_agence) as total_frais_agence')->from(PREFIX . 'bien b')->where( array('b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end) )->get_one();
        $TotalFraisAgence = $Tmp['total_frais_agence'];

        $Tmp = $this->app->db->select('SUM(montant_com_vendeur) as total_com_vendeur')->from(PREFIX . 'bien b')->where( array('b.delete =' => 0, 'b.vendu =' => 1, 'b.vendu_by_agence =' => 1 , 'b.vendu_on_sql >=' => $date_start, 'b.vendu_on_sql <=' => $date_end) )->get_one();
        $TotalComVendeur = $Tmp['total_com_vendeur'];

        $this->app->smarty->assign(array(
            'NbBien'            =>  $NbBien,
            'NbProspect'        =>  $NbProspect,
            'NbVisite'          =>  $NbVisite,
            'NbBienVenduMois'   =>  $NbBienVenduMois,
            'NbBienSaisieMois'  =>  $NbBienSaisieMois,
            'TotalVente'        =>  $TotalVente,
            'TotalFraisAgence'  =>  $TotalFraisAgence,
            'TotalComVendeur'   =>  $TotalComVendeur,
        ));

        
        
        return $this->registry->smarty->fetch( VIEW_PATH . 'index' . DS . 'ajax_stats.tpl');
    }
}