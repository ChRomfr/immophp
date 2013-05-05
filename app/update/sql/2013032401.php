<?php
/**
*	UPDATE DU 25 FEV 2013
*/
global $registry;

$version = '2013032401';

# Suppression du cache
$registry->cache->remove('config');

# Mise a jour de la version
$registry->db->exec(' UPDATE '. PREFIX . 'config SET valeur = "'. $version .'" WHERE cle = "version"');

# Suppression du cache
$registry->cache->remove('config');


WriteInFileUpdate("Debut de la mise a jour ...\r\n");
WriteInFileUpdate("Version : " . $version . "\r\n");

$Queries = array();


$Queries[] = "ALTER TABLE `va_article` ADD COLUMN `commentaire` INT(1) NULL DEFAULT 1  AFTER `edit_by` , ADD COLUMN `image` VARCHAR(100) NULL DEFAULT NULL  AFTER `commentaire` , ADD COLUMN `fichier` VARCHAR(100) NULL DEFAULT NULL  AFTER `image` , ADD COLUMN `fichier_for` VARCHAR(10) NULL DEFAULT 'all'  AFTER `fichier` , ADD COLUMN `visible` INT(1) NULL DEFAULT 1  AFTER `fichier_for` ;";

$Queries[] = "ALTER TABLE `va_download` ADD COLUMN `vue` INT(11) NULL DEFAULT 0  AFTER `apercu` , ADD COLUMN `downloaded` INT(11) NULL DEFAULT 0  AFTER `vue` , ADD COLUMN `download_for` VARCHAR(10) NULL DEFAULT 'all'  AFTER `downloaded` , ADD COLUMN `add_on` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP  AFTER `download_for` , ADD COLUMN `add_by` INT(11) NULL  AFTER `add_on` , ADD COLUMN `visible` INT(1) NULL  AFTER `add_by` 
, ADD INDEX `download_categorie` (`categorie_id` ASC) 
, ADD INDEX `download_user` (`add_on` ASC) 
, ADD INDEX `download_visible` (`visible` ASC) ;";

$Queries[] = "ALTER TABLE `va_download` CHANGE `add_on` `add_on` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP;";

$Queries[] = "ALTER TABLE `va_download` CHANGE `add_on` `add_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ;";

 $Queries[] = "CREATE  TABLE  `va_article_commentaire` (  `id` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `model_id` int( 11  )  NOT  NULL ,
 `auteur_id` int( 11  )  NOT  NULL ,
 `commentaire` text NOT  NULL ,
 `post_on` int( 11  )  NOT  NULL ,
 `visible` int( 1  )  NOT  NULL DEFAULT  '1',
 PRIMARY  KEY (  `id`  ) ,
 KEY  `news_id` (  `model_id`  ) ,
 KEY  `auteur_id` (  `auteur_id`  )  ) ENGINE  =  MyISAM  DEFAULT CHARSET  = latin1;";

$Queries[] =  " ALTER TABLE  `va_article` ADD  `video` INT( 1 ) NOT NULL DEFAULT  '0';";

$Queries[] = "ALTER TABLE `va_user` DROP COLUMN `pilot` , ADD COLUMN `signature` TEXT NULL DEFAULT NULL  AFTER `telephone` , ADD COLUMN `groupe_id` INT NULL DEFAULT NULL  AFTER `signature` , ADD COLUMN `url` VARCHAR(200) NULL DEFAULT NULL  AFTER `groupe_id` , ADD COLUMN `facebook` VARCHAR(200) NULL DEFAULT NULL  AFTER `url` , ADD COLUMN `facebook_id` VARCHAR(50) NULL DEFAULT NULL  AFTER `facebook` , ADD COLUMN `tweeter` VARCHAR(200) NULL DEFAULT NULL  AFTER `facebook_id` , ADD COLUMN `date_naissance` DATE NULL DEFAULT NULL  AFTER `tweeter` , ADD COLUMN `ville` VARCHAR(150) NULL DEFAULT NULL  AFTER `date_naissance` , ADD COLUMN `pays` VARCHAR(150) NULL DEFAULT NULL  AFTER `ville` , ADD COLUMN `lang` VARCHAR(30) NULL DEFAULT NULL  AFTER `pays` , ADD COLUMN `sexe` VARCHAR(1) NULL DEFAULT NULL  AFTER `lang` , ADD COLUMN `newsletter` INT(1) NULL DEFAULT NULL  AFTER `sexe` , ADD COLUMN `mailing` INT(1) NULL DEFAULT NULL  AFTER `newsletter` , ADD COLUMN `date_edit_profil` TIMESTAMP NULL DEFAULT NULL  AFTER `mailing` , ADD COLUMN `date_changepassword` TIMESTAMP NULL DEFAULT NULL  AFTER `date_edit_profil` , ADD COLUMN `uniq_id` VARCHAR(50) NULL DEFAULT NULL  AFTER `date_changepassword` ;";

$Queries[] =  "CREATE  TABLE `va_mailing` (
  `id` INT NOT NULL ,
  `sujet` VARCHAR(150) NULL ,
  `message` TEXT NULL ,
  `destinataires` VARCHAR(45) NULL ,
  `auteur_id` INT NULL ,
  `date_mailing` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) );";

$Queries[] = "
CREATE TABLE `va_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categorie_id` int(11) DEFAULT '0',
  `auteur_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `url` varchar(255) NOT NULL,
  `actif` int(1) DEFAULT '0',
  `valid` int(1) DEFAULT '1',
  `add_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `image` varchar(255) DEFAULT NULL,
  `apersite` int(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `link_categorie` (`categorie_id`),
  KEY `link_auteur` (`auteur_id`),
  KEY `link_actif` (`actif`),
  KEY `link_valid` (`valid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Table contenant les liens';	
";

$Queries[] = "
CREATE TABLE `va_link_categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(75) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(100) NOT NULL,
  `lft` int(11) NOT NULL,
  `rght` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_annuaire_categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(75) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(100) NOT NULL,
  `lft` int(11) NOT NULL,
  `rght` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_annuaire_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT '0',
  `email` varchar(150) NOT NULL,
  `categorie_id` int(11) DEFAULT '0',
  `url` varchar(255) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `resume` text NOT NULL,
  `description` text NOT NULL,
  `flux_rss_1` varchar(255) DEFAULT NULL,
  `flux_rss_2` varchar(255) DEFAULT NULL,
  `backlink` varchar(255) DEFAULT NULL,
  `add_on` datetime DEFAULT NULL,
  `edit_on` datetime DEFAULT NULL,
  `keyword` text,
  `visible` int(1) DEFAULT '0',
  `status` varchar(15) DEFAULT 'new',
  `date_valid` datetime DEFAULT NULL,
  `raison_refus` text,
  `valid_by` int(11) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `googleplus` varchar(255) DEFAULT NULL,
  `allopass` varchar(255) DEFAULT NULL,
  `vue` int(11) NOT NULL DEFAULT '0',
  `visited` int(11) NOT NULL DEFAULT '0',
  `note` int(11) NOT NULL DEFAULT '0',
  `nb_vote` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `as_categorie` (`categorie_id`),
  KEY `as_visible` (`visible`),
  KEY `as_status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_feed_rss_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed_rss_link_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `add_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_feed_rss_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categorie_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `add_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text NOT NULL,
  `actif` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `frl_active` (`actif`),
  KEY `frl_categorie` (`categorie_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_feed_rss_link_categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(75) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(100) NOT NULL,
  `lft` int(11) NOT NULL,
  `rght` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE  TABLE `va_user_notification` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `date_notification` DATETIME NOT NULL ,
  `notification` TEXT NOT NULL ,
  `read` INT(1) NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM;
";

$Queries[] = "
CREATE  TABLE `va_forum_thread_user_follow` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `thread_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `date_last_visite` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM;
";

$Queries[] = "
CREATE TABLE `va_forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categorie_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text,
  `image` varchar(150) DEFAULT NULL,
  `ordre` int(4) DEFAULT '0',
  `niveau` int(2) DEFAULT '0',
  `admin` int(1) DEFAULT '0',
  `add_on` datetime DEFAULT NULL,
  `add_by` int(11) DEFAULT NULL,
  `edit_on` datetime DEFAULT NULL,
  `edit_by` int(11) DEFAULT NULL,
  `niveau_poll` int(2) DEFAULT '1',
  `niveau_vote` int(2) DEFAULT '1',
  `visible` int(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_forum_categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text,
  `image` varchar(200) DEFAULT NULL,
  `niveau` int(11) DEFAULT '0' COMMENT 'Niveau a partir du quel les membres peuvent voir la categorie 0 tout le monde 1,2,3 ... depent du niveau du membre',
  `ordre` int(4) DEFAULT '0' COMMENT 'Ordre d\\''affiche des categorie 0 categorie la plus haute dans l affichage',
  `admin` int(1) DEFAULT '0' COMMENT 'Permet de definir que cette categorie n est visible que par les administrateurs du site.',
  `add_on` datetime DEFAULT NULL COMMENT 'Date d ajout dans la base',
  `add_by` int(11) DEFAULT NULL COMMENT 'id de l utilisateur qui a ajoute la categorie',
  `edit_on` datetime DEFAULT NULL COMMENT 'Date de la derniere modifications de la categorie',
  `edit_by` int(11) DEFAULT NULL COMMENT 'Id de l utilisateur qui a modifie la categorie',
  `visible` int(1) DEFAULT '0' COMMENT 'Determine si la categorie est visible. Si a 0 celle ci ne sera pas afficher meme en fonction du niveau et admin',
  `parent_id` int(11) DEFAULT '0',
  `rght` int(5) DEFAULT NULL,
  `lft` int(5) DEFAULT NULL,
  `level` int(5) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `forumcat_visible` (`visible`),
  KEY `forumcat_ordre` (`ordre`),
  KEY `forumcat_niveau` (`niveau`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Table contenant les categories du forum';
";

$Queries[] = "
CREATE TABLE `va_forum_log_moderation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_action` datetime NOT NULL,
  `moderateur_id` int(11) NOT NULL,
  `thread_id` int(11) DEFAULT NULL,
  `forum_id` int(11) DEFAULT NULL,
  `message_id` int(11) DEFAULT NULL,
  `action` text NOT NULL,
  `detail` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_forum_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `add_on` datetime NOT NULL,
  `edit_on` datetime DEFAULT NULL,
  `edit` int(1) DEFAULT '0',
  `auteur_signature` int(1) DEFAULT '0',
  `email_notify` int(1) DEFAULT '0',
  `auteur_ip` varchar(50) NOT NULL,
  `bbcodeoff` int(1) DEFAULT '0',
  `fichier` varchar(200) DEFAULT NULL,
  `visible` int(1) DEFAULT '1',
  `valid` int(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_forum_message_alerte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `date_alerte` datetime DEFAULT NULL,
  `traite` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_forum_thread` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `add_on` datetime NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `view` int(11) DEFAULT '0',
  `annonce` int(1) DEFAULT '0',
  `sondage` int(1) DEFAULT '0',
  `closed` int(1) DEFAULT '0',
  `last_auteur_id` int(11) NOT NULL COMMENT 'id auteur dernier message',
  `last_message_date` datetime NOT NULL COMMENT 'date dernier message',
  `visible` int(1) NOT NULL DEFAULT '1' COMMENT 'defini si le sujet est visible ou non',
  PRIMARY KEY (`id`),
  KEY `ft_forum_id` (`forum_id`),
  KEY `ft_auteur_id` (`auteur_id`),
  KEY `ft_visible` (`visible`),
  KEY `ft_forum_visible` (`forum_id`,`visible`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
";

$Queries[] = "
CREATE TABLE `va_user_groupe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `groupe_id` int(11) NOT NULL,
  `principal` varchar(20) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL COMMENT 'Permet de definir un role a l utilisateur au sein du groupe. admin, membre ...',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Liaison entre les utilisateurs et ses groupes';
";

$Queries[] = "
CREATE TABLE IF NOT EXISTS `va_groupe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text,
  `image` varchar(150) DEFAULT NULL,
  `principal` int(1) DEFAULT '1',
  `systeme` int(1) NOT NULL DEFAULT '0' COMMENT 'Permet de definir si le groupe est system ou non. Un groupe systeme ne peut pas etre supprimer ',
  `ouvert` int(1) DEFAULT '0' COMMENT 'Permet de definir si le groupe est ouvert.',
  `visible` int(1) DEFAULT '1' COMMENT 'Rend le groupe visible ou non',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Contient les groupes utilisateurs' AUTO_INCREMENT=6 ;
";

$Queries[] = "
INSERT INTO `va_groupe` (`id`, `name`, `description`, `image`, `principal`, `systeme`, `ouvert`, `visible`) VALUES
(1, 'visiteurs', 'groupe par defaut pour les visiteur', NULL, 0, 1, 0, 0),
(2, 'membres', 'groupe contenant tout les membres', NULL, 1, 1, 0, 0),
(3, 'moderateurs', 'groupe contenant les moderateurs du forums', NULL, 0, 1, 0, 0),
(4, 'administrateur', 'groupe contenant les administrateur du site', NULL, 0, 1, 0, 0);
";

# Injection des configs en base
$configToInject = array(
'format_date'				=>	"%d/%m/%Y - %H:%M",
'format_date_day'			=>	"%d/%m/%Y",
'rewrite_url'				=>	0,
# News
'news_commentaire'			=>	0,
'news_nom'					=>	'News',	
'news_per_page'				=>	5,
'news_truncate_in_index'	=>	1,
# Utilisateur
'register_open'				=>	0,
#Article
'article_nom'				=>	'Articles',
'article_pager'				=>	0,
'article_commentaire'		=>	1,
'article_per_page'			=>	5,
# Download
'download_per_page'			=>	10,
'download_view_by'			=>	'all',
# Annuaire
'annuaire_submit_onlymember'		=>	1,	# Soumission que pour les membres
'annuaire_site_rss'					=>	0,	# Autoriser les flux rss dans la soumission
'annuaire_site_keyword'				=>	0,	# Mot clé
'annuaire_site_backlink_required'	=>	1, 	# Oblige ou non le rien de retour
'annuaire_pub_afert_first'			=>	0,	# Difni si on affiche un pub apres le 1er site
'annuaire_code_pub'					=>	'
	<script type="text/javascript"><!--
	google_ad_client = "ca-pub-1710313297381782";
	/* carpe 468x60 */
	google_ad_slot = "4753583552";
	google_ad_width = 468;
	google_ad_height = 60;
	//-->
	</script>
	<script type="text/javascript"
	src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
	</script>'
									,
'annuaire_code_backlink'			=> '<a href="http://www.sharkphp.com/annuaire" title="Annuaire de lien en dur sharkphp">Sharkphp annuaire</a>',
'annuaire_min_length_resume'		=>	100,	# Nb caractere mini resume
'annuaire_min_length_description'	=>	600,	# Nb caractere mini description
'annuaire_regle_soumission'			=>	'',		# Regle de soumission a l annuaire peut etre du code HTML
# Utilisateur
'user_use_group'				=>	1, 			# Utilisateur des groupes utilisateurs
'user_activation'				=>	'auto',		# Valeur possible : auto|mail|admin
'user_id'						=>	'int',		# Valeur possible : int|uniq dans le cas uniq modifier le type dans la base de donnee en varchar(50)
'user_edit_profil'				=>	1,			# Affiche ou non le lien d edition de profil
'user_register_by_fb'			=>	0,			# Determine si on peut s enregistrer via FB
'user_avatar'					=>	1,			# Defini si le membre peut upload un avatar	
'user_delete_account'			=>	0,			# Defini si l utilisateur peut supprimer mon compte
'user_group_default_visiteur'	=>	1, 			# Groupe par defaut pour les visiteurs
'user_group_default_membre'		=>	2, 			# Groupe par defaut pour les membres
'user_group_default_admin'		=> 	4, 			# Groupe par defaut pour les administrateurs
 # General
'titre_site'					=>	'Sharkphp',
'slogan_site'					=>	'Encore un site sur le php',
'email'							=>	'w.shark@hotmail.fr',
'description_site'				=>	'',
'keywords'						=>	'',
'code_stat'						=>	'',
'theme'							=>	'sharkphp',
'use_ckeditor'					=>	0,
'use_sh'						=>	1,
'fb_app_id'						=>	'', # Id application facebook
'fb_url'						=>	'',	
'twitter_url'					=>	'',	
'print_stat_page'				=>	1, # Affiche ou non les stats sur la generation de la page		
#Forums
'forum_name'					=>	'Forum',					# Nom de votre forum
'forum_description'				=>	'Description du forum',	# Description du forum qui sera mit dans la gestion du site
'forum_group_modo'				=>	3,						# Tous les membres du groupe #3 seront moderateurs global du forum
'forum_pub_after_1_message'		=>	1,
'forum_pub_code'				=>'
	<script type="text/javascript"><!--
	google_ad_client = "ca-pub-1710313297381782";
	/* carpe 468x60 */
	google_ad_slot = "4753583552";
	google_ad_width = 468;
	google_ad_height = 60;
	//-->
	</script>
	<script type="text/javascript"
	src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
	</script>'
									,
# Activation des modules pour administration
'mod_feed_rss'				=>	0,
'mod_link'						=>	0,
'mod_annuaire'				=>	0,
'mod_forum'						=>	0,
'mod_download'				=>	0,
'mod_news'						=>	1,
'mod_page'						=>	1,
'mod_article'					=>	1,
);

foreach( $configToInject as $k => $v ):

	$Result = $registry->db->count(PREFIX . 'config', array('cle =' => $k), 'cle');
	
	if( $Result == 0 ):
		$registry->db->insert(PREFIX . 'config', array('cle' => $k, 'valeur' => $v) );
	endif;

endforeach;



foreach( $Queries as $k => $query ):

	try{
		$registry->db->exec($query);
	}

	catch (Exception $e){
		WriteInFileUpdate("Erreur sur la requete : ". $query ." #Infos : ". $e->getMessage() ."\r\n");
		exit("ERROR DURING UPDATE ...");
	}
	
	WriteInFileUpdate($query . " #OK\r\n");

endforeach;

WriteInFileUpdate("Mise a jour termine\r\n");

# Suppression du cache
$registry->cache->remove('config');