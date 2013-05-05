<?php

class AdmFilemanagerController extends Controller{

	public function indexAction(){

		$this->app->load_web_lib('elfinder/css/elfinder.min.css','css');
		$this->app->load_web_lib('elfinder/js/elfinder.min.js','js');

		return $this->app->smarty->fetch(ROOT_PATH . 'kernel' . DS . 'base_adm' . DS . 'view' . DS . 'filemanager' . DS . 'index.tpl');
	}

	public function connectorAction(){
		require ROOT_PATH .  'web' . DS . 'lib' . DS . 'elfinder' . DS . 'php' . DS . 'elFinderConnector.class.php';
		require ROOT_PATH .  'web' . DS . 'lib' . DS . 'elfinder' . DS . 'php' . DS . 'elFinder.class.php';
		require ROOT_PATH .  'web' . DS . 'lib' . DS . 'elfinder' . DS . 'php' . DS . 'elFinderVolumeDriver.class.php';
		require ROOT_PATH .  'web' . DS . 'lib' . DS . 'elfinder' . DS . 'php' . DS . 'elFinderVolumeLocalFileSystem.class.php';


		$opts = array(
			// 'debug' => true,
			'roots' => array(
				array(
					'driver'        => 'LocalFileSystem',   // driver for accessing file system (REQUIRED)
					'path'          => ROOT_PATH . 'web' . DS . 'upload',         // path to files (REQUIRED)
					'URL'           => dirname($_SERVER['PHP_SELF']) . '/../files/', // URL to files (REQUIRED)
					'accessControl' => 'access'             // disable and hide dot starting files (OPTIONAL)
				)
			)
		);

		// run elFinder
		$connector = new elFinderConnector(new elFinder($opts));
		$connector->run();

	}

}