<?php

class configurationController extends Controller{

	public function __construct($registry){
		parent::__construct($registry);
		if( $_SESSION['utilisateur']['isAdmin'] < 9){ header('location:'. getLinkAdm('index')); exit;}
	}
	
	public function indexAction(){
		
		if( $this->registry->HTTPRequest->postExists('config') ){
			$config = $this->registry->HTTPRequest->postData('config');
			
			foreach($config as $k => $v){
				$this->registry->db->update(PREFIX . 'config', array('valeur' => $v), array('cle =' => $k));
			}

			# On traite l upload du logo
			$this->savelogo();
			
			$this->registry->cache->remove('config');
			
			return $this->redirect(getLinkAdm("configuration"), 3, $this->lang['Configuration_enregistree']);
		}
		
		//$this->registry->addJS('ckeditor/ckeditor.js');
		$this->load_manager('page','admin');
		$this->app->smarty->assign('themes', getThemes());
		$this->app->smarty->assign('Logos', getFilesInDir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'logo' . DS) );
		$this->app->smarty->assign('Pages', $this->manager->page->getAll());
		return $this->registry->smarty->fetch(VIEW_PATH . 'configuration' . DS . 'index.tpl');
	}

	public function ajaxGetPreviewAction($theme){
		if( is_file(ROOT_PATH . 'themes' . DS . $theme . DS . 'preview.png') ):
			return '<img src="'. $this->app->config['url'] . $this->app->config['url_dir'] . 'themes/'. $theme .'/preview.png" alt="" />';
		else:
			return;
		endif;
	}

	private function savelogo(){

		$dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'logo' . DS;
				
		if( !is_dir($dir) ):
			@mkdir($dir);
		endif;
		
        $Image = new Upload($_FILES['logo']);

        if($Image->uploaded):
			$Image->allowed = 'image/*';
            $Image->file_overwrite = true;
            $Image->file_new_name_body  = microtime(true);
			$Image->image_resize          = true;
			$Image->image_ratio_y         = true;
			$Image->image_x               = 300;
            $Image->process($dir);
			$Image->file_dst_name;
		endif;
	}
	
}