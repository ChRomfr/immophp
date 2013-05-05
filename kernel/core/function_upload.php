<?php

function upload($file, $dir, $rename = false){

	$ds = substr($dir, -1);
	
	if($ds != DIRECTORY_SEPARATOR)	$dir = $dir . DIRECTORY_SEPARATOR;	

	// On test le dossier ou doit etre placer le fichier
	if( !is_dir($dir) ){
		// On tente de le créer
		if( !mkdir($dir,0777) ) return false; //'Erreur : impossible de creer le dossier';
	}
	
	// Test que le fichier upload existe
	$tmp_file = $_FILES[''. $file .'']['tmp_name'];
	if(!is_uploaded_file($tmp_file)) return false; //'Erreur : le fichier n\'a pas ete envoyer sur le serveur';
	
	// Traitement du mon de fichier
	if($rename == true){
		$fichier = time() . '.' . substr(strrchr($_FILES[''. $file .'']['name'],'.'),1);
	}else{
		$fichier = $_FILES[''. $file .'']['name'];
	}

	// Transfert du fichier dans son repertoire
	if(!move_uploaded_file($tmp_file, $dir . $fichier)) return false; //'Erreur : une erreur est survenue pendant le deplacement du fichier';
    else return $fichier;
}

function upload_image($file, $dir, $rename = false, $changeSize = FALSE){
	$ds = substr($dir, -1);
	
	if($ds != DIRECTORY_SEPARATOR)	$dir = $dir . DIRECTORY_SEPARATOR;	
	
	// On test le dossier ou doit etre placer le fichier
	if( !is_dir($dir) ){
		// On tente de le créer
		if( !mkdir($dir,0777) ) return 'Erreur : impossible de creer le dossier';
	}
	
	// Test que le fichier upload existe
	$tmp_file = $_FILES[''. $file .'']['tmp_name'];
	if(!is_uploaded_file($tmp_file)) return 'Erreur : le fichier n\'a pas ete envoyer sur le serveur';

	$extensions_valides = array( 'jpg' , 'jpeg' , 'gif' , 'png', 'JPG', 'jpeg', 'GIF', 'PNG' );
	$extension_upload = strtolower(  substr(  strrchr($_FILES[''. $file .'']['name'] , '.')  ,1)  );
	if ( !in_array($extension_upload,$extensions_valides) ) return 'Erreur format fichier';
	$size = getimagesize($tmp_file);
	
	if($size[0] > 1024 && $changeSize == true){	// On recreer l images au bonne dimension
		$newhauteur = $size[1] * (1024 / $size[0]);	// Calcul de la nouvelle hauteur en gardant les proportions
		$img_tmp = ROOT_PATH . 'upload'. DS . $_FILES[''. $file .'']['name'];
		move_uploaded_file($_FILES[''. $file .'']['tmp_name'], $img_tmp);
		$src = imagecreatefromjpeg($img_tmp);
		$img = imagecreatetruecolor(1024, $newhauteur);
		imagecopyresampled($img, $src, 0, 0, 0, 0, 1024, $newhauteur, $size[0], $size[1]);
		$img_name = time() .'.jpg';
		imagejpeg($img, $dir . $img_name);
		@unlink($img_tmp);
		return $img_name;
	}else{
		// Traitement du mon de fichier
		if($rename == true){
			$fichier = time() . '.' . substr(strrchr($_FILES[''. $file .'']['name'],'.'),1);
		}else{
			$fichier = $_FILES[''. $file .'']['name'];
		}
		
		// Transfert du fichier dans son repertoire
		if(!move_uploaded_file($tmp_file, $dir . $fichier)) return 'Erreur : une erreur est survenue pendant le deplacement du fichier';
		else return $fichier;
	}
}