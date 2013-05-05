<?php

$chrono1 = microtime(true);
define('IN_VA', TRUE);
define('IN_ADMIN', TRUE);
define('DS', DIRECTORY_SEPARATOR); 
define('ROOT_PATH', str_replace('admin.php','',__FILE__));
define('APP_PATH', ROOT_PATH . 'adm' . DS . 'app' . DS);
define('CACHE_PATH', ROOT_PATH . 'cache' . DS);
define('VIEW_PATH', ROOT_PATH . 'adm' . DS . 'app' . DS . 'view' . DS);
define('CONTROLLER_PATH', ROOT_PATH . 'adm' . DS .  'app' . DS . 'controller' . DS);
define('MODEL_PATH', ROOT_PATH . 'adm' . DS .  'app' . DS . 'model' . DS);
define('UPLOAD_PATH', ROOT_PATH . 'web' . DS . 'upload' . DS);
define('ADM_MODEL_PATH',ROOT_PATH . 'adm' . DS . 'app' . DS . 'model' . DS);


# START CODE SPECIFIQUE APP
require ROOT_PATH . 'app' . DS . 'inc' . DS . 'MyLog.class.php';
define('USE_TABLE_CONFIG',true);
# END CODE SPECIFIQUE APP

require_once ROOT_PATH . 'kernel' . DS . 'core'. DS . 'core.php';
require_once ROOT_PATH . 'app' . DS . 'inc' . DS . 'function_immophp.php';

# Appel du model Logs
require_once MODEL_PATH . 'log.php';

$registry->router->setPath(ROOT_PATH . 'adm' . DS . 'app' . DS . 'controller' .DS);

# START CODE SPECIFIQUE APP APRES NOYAU
define('URL_IMG_ACTION', $config['url'] . $config['url_dir'] . 'web/images/');
$registry->MyLog = new Mylog( array('app' => $registry, 'table' => PREFIX . 'log_admin') );
$registry->constructConstAdm();
# END CODE SPECIFIQUE APP

# Si utilisation non identifie ou non admin on le redirige
if( !isset($_SESSION['utilisateur']['isAdmin']) || $_SESSION['utilisateur']['isAdmin'] == 0):
	header('location:' . $registry->Helper->getLink('connexion') );
	exit;
endif;


$registry->constructConstAdm();

$registry->addJS('jquery-last.min.js');
$registry->addJS('jquery-migrate-1.1.0.min.js');
$registry->addJS('jquery-ui-last.custom.min.js');
$registry->addCSS('smoothness/jquery-ui-last.custom.css');
$registry->addJS('fancybox/jquery.mousewheel-3.0.4.pack.js');
$registry->addJS('fancybox/jquery.fancybox-1.3.4.pack.js');
$registry->addCSS('fancybox/jquery.fancybox-1.3.4.css');
$registry->addJS('jquery.maskedinput.min.js');
$registry->addJS('mustache.js');

$Content = $registry->router->loader();

if( !$registry->HTTPRequest->getExists('nohtml') ){
	$registry->smarty->assign('in_adm', true);
	$registry->smarty->assign('app', $registry);
	$registry->smarty->assign('css_add', registry::$css);
	$registry->smarty->assign('js_add', registry::$js);
	$registry->smarty->assign('content', $Content);
	echo $registry->smarty->display(ROOT_PATH . 'themes' . DS . 'dashboard' . DS . 'layout.tpl');
}else
	echo $Content;

if( !$registry->Http->getExists('nohtml') ){
echo'<div style="size:9px; margin:auto; width:1000px;">';
echo'<div>
		Page generee en : '. round( microtime(true) - $chrono1, 6) . ' sec | 
		Requete SQL : '. $db->num_queries .' | 
		Utilisation memoire : ' . round(memory_get_usage() / (1024*1024),2) .' mo
	</div>';
}