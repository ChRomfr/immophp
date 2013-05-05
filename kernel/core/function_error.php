<?php
/**
*	GESTIONNAIRE D ERREUR INTERNE
*	CODE REPRIS DU SITE PHP.NET
*	TOUTE LES ERREURS PHP SONT ENREGISTRER DANS UN FICHIER
*	POUR LE SUIVI CELA PERMET UN DEBUG RAPIDE
*	LA FONCTION RETOURNE FALSE POUR LAISSER LE GESTIONNAIRE D ERREUR PHP
* */

function myErrorHandler($errno, $errstr, $errfile, $errline, $errcontext){

	$mytext = date("Y-m-d h:i:s").'|';

   if (!(error_reporting() & $errno)) {
        // Ce code d'erreur n'est pas inclus dans error_reporting()
        return;
    }

    switch ($errno) {
    case E_USER_ERROR:
		$mytext .= "Erreur E_USER_ERROR : [$errno] $errstr - Erreur fatale sur la ligne $errline dans le fichier $errfile - PHP " . PHP_VERSION . " (" . PHP_OS . ")\r\n";
		WriteInFile($mytext);
        exit(1);
        break;

    case E_USER_WARNING:
        $mytext .= "ALERTE : [$errno] $errstr - ligne $errline dans le fichier $errfile\\r\n";
		WriteInFile($mytext);
        break;

    case E_USER_NOTICE:
        $mytext .= "AVERTISSEMENT : [$errno] $errstr - ligne $errline dans le fichier $errfile\\r\n";
		WriteInFile($mytext);
        break;

    default:
        $mytext .= "Type d'erreur inconnu : [$errno] $errstr - ligne $errline dans le fichier $errfile\n";
		WriteInFile($mytext);
        break;
    }

	if(IN_PRODUCTION)
		/* Ne pas exécuter le gestionnaire interne de PHP */
		return true;
	else
		return false;
}

function WriteInFile($txt){
	$file_name = date("Y-m-d") .'.log';
	// On verifie si le fichier du jour existe
	$file = ROOT_PATH . 'log'. DS .'error'. DS . $file_name;

	// On verifie sur le fichier existe
	// Si celui ci n existe pas on le créer
	if( !is_file($file) ){
		$f = fopen($file, 'a+');
		fclose($f);
	}

	// On stock l ancien contenu du fichier
	$ancien_contenu = @file($file);

	// On ajoute la nouvelle ligne au debut du tableau
	@array_unshift($ancien_contenu,$txt);

	// ressort les lignes du tableau
    $nouveau_contenu = @join('',$ancien_contenu);
    $fp = @fopen($file,'w');
    // ecrit la chaine dans le fichier
    $write = @fwrite($fp, $nouveau_contenu);
    @fclose($fp);
}

// Configuration du gestionnaire d'erreurs
$old_error_handler = set_error_handler("myErrorHandler");

error_reporting(E_ALL);
?>