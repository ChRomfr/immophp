<?php

abstract class AdmSystemeController extends Controller{

	public function indexAction(){
		
		// Recuperation des et utilisateur en lignr
		$users_online = $this->app->db->select('u.identifiant, s.*')->from(PREFIX . 'sessions s')->left_join(PREFIX . 'user u', 'u.id = s.user_id')->where( array('last_used >' => time() - 300) )->get();
		
		$this->app->smarty->assign('uonline', $users_online);
			
		# Generation de la page
		if( is_file( VIEW_PATH . 'systeme' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'systeme' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'systeme' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);
	}
	
	public function deleteCacheAction(){
		if( $this->registry->HTTPRequest->getExists('nohtml') ){
			$files = getFilesInDir(CACHE_PATH);
			foreach($files as $f){
				@unlink(CACHE_PATH . $f);
			}
			return $this->lang['Cache_supprime'];
		}
	}

	public function errorPhpAction(){

		$this->app->smarty->assign(array(
			'Files'		=>	getFilesInDir(ROOT_PATH . 'log' . DS . 'error' . DS),
		));

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'systeme' . DS . 'errorPhp.tpl');
	}

	public function getErrorPhpAction($File){

		$Contenu = @file(ROOT_PATH . 'log' . DS . 'error' . DS . $File);
        $errors = array();
        foreach($Contenu as $Row):
            $Tmp = explode('|',$Row);
            $errors[] = $Tmp;
        endforeach;
        
        $this->app->smarty->assign(array(
            'Errors'        =>    $errors,
        ));

        return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'systeme' . DS . 'getErrorPhp.tpl');
	}

	public function clearLogPhpAction(){
		$Files = getFilesInDir(ROOT_PATH . 'log' . DS . 'error' . DS);

		foreach( $Files as $k => $v):
			@unlink(ROOT_PATH . 'log' . DS . 'error' . DS . $v);
		endforeach;

		return 'ok';
	}
}