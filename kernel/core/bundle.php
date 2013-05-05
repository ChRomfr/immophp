<?php

if( is_dir(BUNDLE_PATH) ):
	$Bundles = getDirsInDir(BUNDLE_PATH);

	# On boucle sur les Bundles pour recuperer le config
	foreach ($Bundles as $key => $value) :
		if( is_file(ROOT_PATH . 'bundle' . DS . $value . DS . 'config'. DS . 'config.php') ):
			require_once ROOT_PATH . 'bundle' . DS . $value . DS . 'config'. DS . 'config.php';
		endif;
	endforeach;

	# Envoie des bundles a smarty
	$registry->smarty->assign('Bundle', $Bundles);
endif;
