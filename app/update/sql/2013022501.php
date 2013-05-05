<?php
/**
*	UPDATE DU 25 FEV 2013
*/
global $registry;

$version = '2013022501';

# Suppression du cache
$registry->cache->remove('config');

# Mise a jour de la version
$registry->db->exec(' UPDATE '. PREFIX . 'config SET valeur = "'. $version .'" WHERE cle = "version"');

# Suppression du cache
$registry->cache->remove('config');


WriteInFileUpdate("Debut de la mise a jour ...\r\n");
WriteInFileUpdate("Version : " . $version . "\r\n");

$Queries = array();

@mkdir( ROOT_PATH . 'web' . DS . 'upload' . DS . 'logo' . DS );

$Queries[] = "CREATE TABLE IF NOT EXISTS `va_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date et heure du log',
  `log_by` int(11) NOT NULL COMMENT 'Utilisateur ayant realiser l action',
  `model` varchar(100) NOT NULL COMMENT 'Nom du model',
  `model_id` int(11) NOT NULL COMMENT 'Id du model',
  `log` text NOT NULL COMMENT 'Description de l action',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;";

$Queries[] = "CREATE TABLE IF NOT EXISTS `va_bien_prix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bien_id` int(11) NOT NULL,
  `prix_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prix` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_bien` (`bien_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;";

$Queries[] = "ALTER TABLE  `va_bien` ADD  `video_code` TEXT NULL DEFAULT NULL;";
$Queries[] = "ALTER TABLE  `va_bien` ADD  `exclusif` INT( 1 ) NULL DEFAULT  '0';";
$Queries[] = "ALTER TABLE  `va_user` ADD  `agence_id` INT NULL DEFAULT NULL;";
$Queries[] = "ALTER TABLE  `va_prospect` ADD  `agence_id` INT NULL DEFAULT NULL;";
$Queries[] = "INSERT INTO `va_config` (`cle`, `valeur`) VALUES ('bien_seuil_visite_hebdomadaire', NULL), ('bien_seuil_visite_mensuel', NULL);";
$Queries[] = "ALTER TABLE  `va_prospect` ADD  `add_on_sql` DATE NULL DEFAULT NULL , ADD  `edit_on_sql` DATE NULL DEFAULT NULL;";

$Queries[] = "CREATE TABLE IF NOT EXISTS `va_prospect_suivi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prospect_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `suivi` text NOT NULL,
  `add_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ps_prospect_id` (`prospect_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;";

$Queries[] = "ALTER TABLE  `va_view_template` ADD  `template_id` INT NULL DEFAULT NULL COMMENT  'Id #template_available';";
$Queries[] = "ALTER TABLE  `va_view_template` ADD  `token` VARCHAR( 50 ) NOT NULL , ADD UNIQUE (`token`);";
$Queries[] = "INSERT INTO  `va_acl_admin` (`id`, `module`, `level`) VALUES (NULL, 'VIEWEDITOR', '5');";

$Queries[] = "CREATE TABLE IF NOT EXISTS `va_template_available` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `chemin` varchar(200) NOT NULL,
  `call_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;";

$Queries[] = "INSERT INTO `va_template_available` (`id`, `nom`, `description`, `chemin`, `call_url`) VALUES (NULL, 'Annonce detail', 'Page de presentation des annonces', 'app#view#annonce#detail.tpl', 'annonce/detail/ID');";
$Queries[] = "INSERT INTO `va_blok_available` (`id`, `name`, `description`, `file`, `function_call`) VALUES (NULL, 'Exclusivité', 'Affiche une annonce exclusive de maniere aleatoire. Ce blok ne peut s affiche que sur les cotes du site', 'blokExclusivite.php', 'blokExclusivite');"; 
$Queries[] = "INSERT INTO `va_template_available` (`id`, `nom`, `description`, `chemin`, `call_url`) VALUES (NULL, 'Annonce liste', 'Liste des annonces', 'app#view#annonce#index.tpl', 'annonce/index');";
$Queries[] = "INSERT INTO `va_template_available` (`id`, `nom`, `description`, `chemin`, `call_url`) VALUES (NULL, 'Agence liste', 'Liste des agences', 'app#view#agence#index.tpl', 'agence/index');";
$Queries[] = "INSERT INTO `va_template_available` (`id`, `nom`, `description`, `chemin`, `call_url`) VALUES (NULL, 'Agence detail', 'Detail agence', 'app#view#agence#detail.tpl', 'agence/detail/ID');";

$Queries[] = "INSERT INTO `va_config` (`cle`, `valeur`) VALUES ('index_carte_agence', '1');";
$Queries[] = "INSERT INTO `va_config` (`cle`, `valeur`) VALUES ('index_last_annonce', '1');";
$Queries[] = "INSERT INTO `va_config` (`cle`, `valeur`) VALUES ('index_page', '');";

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