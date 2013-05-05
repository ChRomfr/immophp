<?php

class visiteController extends Controller{
    
    public function indexAction(){
        
        $date = array();
		
		if( $this->app->HTTPRequest->getExists('year') ):
			$date['year'] = $this->app->HTTPRequest->getData('year');
		else:
			$date['year'] = date("Y");
		endif;
		
		if( $this->app->HTTPRequest->getExists('month') ):
			$date['month'] = $this->app->HTTPRequest->getData('month');
		else:
			$date['month'] = date("m");
		endif;
		
		if( strlen($date['month']) == 1 && $date['month']  < 10 ):
			$date['month']  = '0' . $date['month'];
		endif;
        
        $this->load_manager('visite','admin');
        
        $NbVisiteLastMonth = $this->manager->visite->getNbVisiteByMonth(date('Y').'-'. (date('m')-1));
        $NbVisiteMonth = $this->manager->visite->getNbVisiteByMonth(date('Y').'-'. date('m'));
        $Visites = $this->manager->visite->getFuture();
        
        $this->app->smarty->assign(array(
            'Visites'           =>  $Visites,
            'NbVisiteMonth'     =>  $NbVisiteMonth,
            'NbVisiteLastMonth' =>  $NbVisiteLastMonth,
            'Calendrier'        =>  $this->getCalendar($date),
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'visite' . DS . 'index.tpl');
    }
    
    public function detailAction($visite_id){
        
        $this->load_manager('visite','admin');
        
        $Visite = $this->manager->visite->getById($visite_id);
        
        $this->getFormValidatorJs();
        
        $this->app->smarty->assign(array(
            'Visite'    =>  $Visite,
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'visite' . DS . 'detail.tpl');
    }
    
    public function addCompteRenduAction($visite_id){
        
        $Visite = $this->app->HTTPRequest->postData('visite');
        
        if( empty($Visite['compte_rendu']) ):
            return $this->detailAction($visite_id);
        endif;
        
        $this->app->db->update(PREFIX . 'visite', $Visite);
        
        return $this->redirect(getLinkAdm('visite/detail/'. $visite_id), 3, $this->lang['Compte_rendu_enregistre']);
        
    }
    
    public function calendrierAction(){
        $date = array();
		
		if( $this->app->HTTPRequest->getExists('year') ):
			$date['year'] = $this->app->HTTPRequest->getData('year');
		else:
			$date['year'] = date("Y");
		endif;
		
		if( $this->app->HTTPRequest->getExists('month') ):
			$date['month'] = $this->app->HTTPRequest->getData('month');
		else:
			$date['month'] = date("m");
		endif;
		
		if( strlen($date['month']) == 1 && $date['month']  < 10 ):
			$date['month']  = '0' . $date['month'];
		endif;
        
        $this->app->smarty->assign(array(
            'Calendrier'        =>  $this->getCalendar($date),
        ));
        
        return $this->app->smarty->fetch( VIEW_PATH . 'visite' . DS . 'ajax_calendrier.tpl');
    }
    
    /**
     * Affiche un calendrier
     * Repri de la programmation GOLIATH
     * @param type $date
     * @return string
     */
    private function getCalendar($date){
		
        $this->load_manager('visite','admin');
       
        $Datas = $this->manager->visite->getByMonthAndYear($date['year'] . '-'. $date['month'] . '-');
							
		// Mise en forme des datas	
		$Visites = array();
		
		//foreach($Datas as $Row):
			//$Visite[''. $Row['date_visite'] .'-'. $Row['moment_jour']  .''] = $Row;
            //$Visite[''. $Row['date_visite'] .'-#'. $Row['id']  .''] = $Row;
		//endforeach;
		
		$TimestampMonth = mktime(0,0,0,$date['month'],1,$date['year']);
		$NbDaysInMonth = date("t", $TimestampMonth);
		$NumberFirstDay = date("N",$TimestampMonth);
		
		
		$Calendar = '<table class="calendrier">';
			$Calendar .= '<tr>';
				$Calendar .= '<td class="calendrier_jour">'. $this->lang['Lundi'] .'</td>';
				$Calendar .= '<td class="calendrier_jour">'. $this->lang['Mardi'] .'</td>';
				$Calendar .= '<td class="calendrier_jour">'. $this->lang['Mercredi'] .'</td>';
				$Calendar .= '<td class="calendrier_jour">'. $this->lang['Jeudi'] .'</td>';
				$Calendar .= '<td class="calendrier_jour">'. $this->lang['Vendredi'] .'</td>';
				$Calendar .= '<td class="calendrier_jour">'. $this->lang['Samedi'] .'</td>';
				$Calendar .= '<td class="calendrier_jour">'. $this->lang['Dimanche'] .'</td>';
			$Calendar .= '</tr>';
            
        // 1er parcours pour la mise en forme
        for($i = 1; $i <= $NbDaysInMonth; $i++):
            
            $Day = $i;
            if( strlen($Day) == 1 && $Day  < 10 ):
                $Day = '0' . $i;
            endif;
            
            $CurrentDay = $date['year'].'-'.$date['month'].'-'.$Day;
            $Visites[''. $date['year'].'-'.$date['month'].'-'.$Day.''] = array();
           
            foreach($Datas as $Row):
                if( $Row['date_visite'] == $CurrentDay):
                    $Visites[$CurrentDay][] = $Row;
                endif;
            endforeach;
            
        endfor;
			
		for($i = 1; $i <= $NbDaysInMonth; $i++){
		      if( $i < 10)
                    $i = '0'.$i;
              
              $CurrentDay = $date['year'].'-'.$date['month'].'-'.$i;
			// Traitement 1er ligne
			if( $i == 1 ){
				$Calendar .= '<tr>';
				$Calendar .= str_repeat('<td></td>',( $NumberFirstDay - 7)+6 );
                
                
				
				$Calendar .= '<td class="calendrier_cellule">
					<div class="calendrier_day_number">'. $i . '</div>';
					
					if( count($Visites[$CurrentDay]) > 0 ):
						
                        foreach($Visites[$CurrentDay] as $Rdv):
                            $Calendar .= '<span><small><a href="'. getLinkAdm("visite/detail/". $Rdv['id']) .'">'. substr($Rdv['heure_visite'],0,-3) . ' '. $Row['p_nom'] . ' ' . $Row['p_prenom'] .'</a></small></span><br/>';
                        endforeach;
					
					endif;
					
				$Calendar .= '</td>';
				
				
			}else{
				$Calendar .= '<td class="calendrier_cellule">
					<div class="calendrier_day_number">'. $i . '</div>';
					
					if( count($Visites[$CurrentDay]) > 0 ):
						
                        foreach($Visites[$CurrentDay] as $Rdv):
                           $Calendar .= '<span><small><a href="'. getLinkAdm("visite/detail/". $Rdv['id']) .'">'. substr($Rdv['heure_visite'],0,-3) . ' '. $Row['p_nom'] . ' ' . $Row['p_prenom'] .'</a></small></span><br/>';
                        endforeach;
					
					endif;
					
					
				$Calendar .= '</td>';
			}
			
			if( date("N", mktime(0,0,0,$date['month'],$i,$date['year'])) % 7 == 0){
				$Calendar .= '</tr><tr>';
			}
		}
		
		$Calendar .= '</tr></table>';
		
		return $Calendar;
    }
	
    public function getForFullCalendarAction(){

    	$date = array();
		
		if( $this->app->HTTPRequest->getExists('year') ):
			$date['year'] = $this->app->HTTPRequest->getData('year');
		else:
			$date['year'] = date("Y");
		endif;
		
		if( $this->app->HTTPRequest->getExists('month') ):
			$date['month'] = $this->app->HTTPRequest->getData('month');
		else:
			$date['month'] = date("m");
		endif;
		
		if( strlen($date['month']) == 1 && $date['month']  < 10 ):
			$date['month']  = '0' . $date['month'];
		endif;

		$this->load_manager('visite','admin');
       
        $Datas = $this->manager->visite->getByMonthAndYear($date['year'] . '-'. $date['month'] . '-');

        $visites = array();

        foreach($Datas as $Data):
        	$visites[] = array('id' => $Data['id'], 'title' => 'Visite du bien '. $Data['reference'] . ' avec '. $Data['p_nom'] . ' '. $Data['p_prenom'], 'start' => $Data['date_visite'] .' '. $Data['heure_visite'], 'allDay'=> false, 'url' => $this->app->Helper->getLinkAdm('visite/detail/'. $Data['id']));
        endforeach;

        return json_encode($visites);
    }

}