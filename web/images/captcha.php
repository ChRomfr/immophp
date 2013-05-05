<?php
/**
*	Code inspirer de : http://www.siteduzero.com/tutoriel-3-56210-les-captchas-graphiques.html
*/
session_start();
header ("Content-type: image/png");

# Generation captcha
require '../../kernel/core/Captcha.class.php';
$captcha = new Captcha();
$captcha->create();
$nombre = $captcha->nombre;

$largeur = strlen($nombre) * 10;
$hauteur = 20;
$img = imagecreate($largeur, $hauteur);
$blanc = imagecolorallocate($img, 255, 255, 255); 
$noir = imagecolorallocate($img, 0, 0, 0);
$milieuHauteur = ($hauteur / 2) - 8;
imagestring($img, 6, strlen($nombre) /2 , $milieuHauteur, $nombre, $noir);
imagerectangle($img, 1, 1, $largeur - 1, $hauteur - 1, $noir); // La bordure

imagepng($img);
imagedestroy($img);

header("Content-type: image/png");
?>