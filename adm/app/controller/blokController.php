<?php
if(!defined('IN_VA')) exit;
if(!defined('IN_ADMIN')) exit;
if( ADM_BLOK_LEVEL > $_SESSION['utilisateur']['isAdmin'] ) exit;

class blokController extends AdmBlokController{}