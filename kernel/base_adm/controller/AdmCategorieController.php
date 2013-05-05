<?php

abstract class AdmCategorieController extends Controller{
	
	protected $controller;
	
	protected $Tree;
	
	/**
	 * Constructeur
	 * @param [type] $registry
	 */
	public function __construct($registry){
		parent::__construct($registry);

		# Recuperation du model pour la categorie
		$this->controller = $this->app->HTTPRequest->getData('c');

		# Chargement du manager
		$this->load_manager('categorie', 'admin');

		# On lui definie la table
		$this->manager->categorie->setTable($this->controller);
		
		# On charge la classe pour la representation instervallaire
		require_once ROOT_PATH . 'kernel' . DS . 'core' . DS . 'Tree.class.php';
		$this->Tree = new Tree($this->app->db, PREFIX . $this->controller .'_categorie');
	}
	
	/**
	 * Recupere tout les categories et les affiche
	 * @return string code html
	 */
	public function indexAction(){
		
		# On recupere les categories
		$categories = $this->Tree->getAll();
		
		# Envoie a smarty
		$this->app->smarty->assign(array(
			'categories'	=>	$categories,
		));
		
		# Generation de la page
		if( is_file( VIEW_PATH . 'categorie' . DS . 'index.tpl' ) ) :
			$tpl_file = VIEW_PATH . 'categorie' . DS . 'index.tpl';
		else:
			$tpl_file = ROOT_PATH . 'kernel' . DS . 'base_adm' . DS  . 'view' . DS . 'categorie' . DS . 'index.tpl';
		endif;

		return $this->app->smarty->fetch($tpl_file);		
	}
	
	/**
	 * Traite l enregistrement d'une nouvelle categorie
	 */
	public function addAction(){

		if( !$this->app->HTTPRequest->postExists('categorie') ):
			header('location:' . $_SERVER['HTTP_REFERER']);
			exit;
		endif;
		
		$categorie = $this->app->HTTPRequest->postData('categorie');
		
		if( !empty($categorie['name']) ) :
			$Image = $this->savePhoto('image');

			if( $Image != false ):
				$categorie['image'] = $Image;
			else:
				$categorie['image'] = '';
			endif;

			# On enregistre la categorie
			$this->Tree->add($categorie);

			return $this->redirect( $this->app->Helper->getLinkAdm('categorie?c='. $this->app->HTTPRequest->getData('c')), 3,$this->lang['Categorie_ajoutee']);
		endif;
	}
	
	public function editAction(){

		if( !$this->app->HTTPRequest->postExists('categorie') ):
			header('location:' . $_SERVER['HTTP_REFERER']);
			exit;
		endif;
		
		$categorie = $this->app->HTTPRequest->postData('categorie');
		
		if( !empty($categorie['name']) && !empty($categorie['id']) ):

			$Image = $this->savePhoto('image');

			if( $Image != false ):
				$categorie['image'] = $Image;
			endif;

			$this->manager->categorie->update($categorie);

			return $this->redirect( $this->app->Helper->getLinkAdm('categorie?c='. $this->app->HTTPRequest->getData('c')), 3,$this->lang['Categorie_modifiee']);
		endif;
	}
	
	public function deleteAction($id){
		$this->Tree->remove($id);
		return $this->redirect( $this->app->Helper->getLinkAdm('categorie?c='. $this->registry->HTTPRequest->getData('c')), 3,$this->lang['Categorie_supprimee']);
	}
	
	public function getDataAction($categorie_id){
		$Categorie = $this->Tree->getById($categorie_id);
		return json_encode($Categorie);
	}

	/**
	 * Enregistrement l image sur le serveur
	 * @param  string nom de la var $_FILE qui contient l image
	 * @return string|bool le nom de l image ou false si l enregistrement a echoue
	 */
	private function savePhoto($file){
		$Dir = ROOT_PATH . 'web' . DS . 'upload' . DS . 'categorie' . DS;
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'upload' . DS . 'class.upload.php';
		
		if( !is_dir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'categorie' . DS) ):
			@mkdir(ROOT_PATH . 'web' . DS . 'upload' . DS . 'categorie' . DS);
		endif;

		if( !is_dir($Dir) ):
			@mkdir($Dir);
		endif;
		
		$Fichier = new Upload($_FILES[''.$file.'']);

		if($Fichier->uploaded):
			$Fichier->allowed = 'image/*';
            $Fichier->file_overwrite = true;
            $Fichier->file_new_name_body  = microtime(true);
			$Fichier->image_resize          = true;
			$Fichier->image_ratio_y         = true;
			$Fichier->image_x               = 1024;
            $Fichier->process($Dir);

            if( $Fichier->processed ):
            	return $Fichier->file_dst_name;
            else:
            	return false;
            endif;
		endif;

		return false;
	}
}