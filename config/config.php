<?php if( !defined('IN_VA') ) exit;

// DONNEE DE CONNEXION A LA BASE DE DONNEES
$DB_Configuration = array(
'type'			=>	'mysql',
'serveur' 		=> '127.0.0.1',
'utilisateur' 	=> 'root',
'password' 		=> '',
'base' 			=> 'immophp',
);

define('PREFIX', 'va_');		// Prefix des tables
define('IN_PRODUCTION', false);	// Active le mode developpeur
define('BREAD_SEP','&nbsp;<&nbsp;');
# On definie si les sessions sont stocke en base de donnee
define('SESSION_IN_DB',true);
# Permet l identification d un utilisateur plusieurs fois
define('SESSION_MULTI',false);

$config_file = array(
'format_date'				=>	"%d/%m/%Y - %H:%M",
'format_date_day'			=>	"%d/%m/%Y",
'url'						=>	'http://chrom-pc/',
'url_dir'					=>	'immophp/',
'rewrite_url'				=>	0,
# News
'news_commentaire'			=>	0,
'news_nom'					=>	'News',	
# Utilisateur
'register_open'				=>	0,
#Article
'article_nom'				=>	'Articles',
'article_pager'				=>	0,
'article_commentaire'		=>	1,
# Download
'download_per_page'			=>	10,
# Utilisateur
'user_activation'			=>	'auto',	# Valeur possible : auto|mail|admin
'user_id'					=>	'int',	# Valeur possible : int|uniq dans le cas uniq modifier le type dans la base de donnee en varchar(50)
'user_edit_profil'			=>	0,
'user_register_by_fb'		=>	0,
# General
'use_ckeditor'				=>	0,
'use_sh'					=>	1,
'fb_app_id'					=>	''		# Id application facebook
);