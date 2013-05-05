-- phpMyAdmin SQL Dump
-- version 4.0.0
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Dim 05 Mai 2013 à 13:49
-- Version du serveur: 5.5.31-0ubuntu0.12.04.1
-- Version de PHP: 5.4.14-1~precise+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données: `immophp_vierge`
--

-- --------------------------------------------------------

--
-- Structure de la table `va_acl_admin`
--

CREATE TABLE IF NOT EXISTS `va_acl_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(100) NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Contenu de la table `va_acl_admin`
--

INSERT INTO `va_acl_admin` (`id`, `module`, `level`) VALUES
(4, 'BLOK', 2),
(6, 'CONTACT', 2),
(7, 'DOWNLOAD', 2),
(9, 'NEWS', 2),
(10, 'PAGE', 2),
(12, 'PREFERENCE', 2),
(14, 'USER', 2),
(16, 'ARTICLE', 2),
(17, 'VIEWEDITOR', 5);

-- --------------------------------------------------------

--
-- Structure de la table `va_agence`
--

CREATE TABLE IF NOT EXISTS `va_agence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `directeur_id` int(11) DEFAULT NULL COMMENT 'Id de l utilisateur etant directeur de cette agence',
  `nom` varchar(150) NOT NULL,
  `description` text,
  `adresse` text,
  `code_postal` varchar(20) NOT NULL,
  `ville` varchar(200) NOT NULL,
  `pays` varchar(200) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `photo` varchar(50) DEFAULT NULL,
  `add_on` int(11) NOT NULL COMMENT 'Timestamp d ajout dans la base',
  `edit_on` int(11) NOT NULL COMMENT 'Timestamp de la derniere modification dans la base',
  `add_by` int(11) NOT NULL COMMENT 'user_id de la personne qui a saisie l agence dans la base',
  `edit_by` int(11) NOT NULL COMMENT 'user_id de la derniere personne qui a fait la modification de l agence dans la base',
  `unique_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Tablea contenant les agences	' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_agence_contact`
--

CREATE TABLE IF NOT EXISTS `va_agence_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agence_id` int(11) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `telephone` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `ip_visiteur` varchar(50) NOT NULL,
  `add_on` int(11) DEFAULT NULL,
  `read` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ac_agenceid` (`agence_id`),
  KEY `ac_read` (`read`),
  KEY `ac_addon` (`add_on`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Stockage des formulaires de contact par rapport à une agence' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_annuaire_categorie`
--

CREATE TABLE IF NOT EXISTS `va_annuaire_categorie` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_annuaire_site`
--

CREATE TABLE IF NOT EXISTS `va_annuaire_site` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_article`
--

CREATE TABLE IF NOT EXISTS `va_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `article` text NOT NULL,
  `author` int(11) NOT NULL,
  `categorie_id` int(11) NOT NULL,
  `creat_on` int(11) NOT NULL,
  `edit_on` int(11) DEFAULT NULL,
  `edit_by` int(11) DEFAULT NULL,
  `commentaire` int(1) DEFAULT '1',
  `image` varchar(100) DEFAULT NULL,
  `fichier` varchar(100) DEFAULT NULL,
  `fichier_for` varchar(10) DEFAULT 'all',
  `visible` int(1) DEFAULT '1',
  `video` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `author` (`author`,`categorie_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_article_categorie`
--

CREATE TABLE IF NOT EXISTS `va_article_categorie` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_article_commentaire`
--

CREATE TABLE IF NOT EXISTS `va_article_commentaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `commentaire` text NOT NULL,
  `post_on` int(11) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `news_id` (`model_id`),
  KEY `auteur_id` (`auteur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_bien`
--

CREATE TABLE IF NOT EXISTS `va_bien` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL,
  `agence_id` int(11) DEFAULT NULL,
  `categorie_id` int(11) DEFAULT NULL,
  `transaction` varchar(50) DEFAULT NULL,
  `vendeur_id` int(11) DEFAULT NULL,
  `nom` varchar(200) NOT NULL,
  `description` text,
  `adresse` text,
  `code_postal` varchar(20) DEFAULT NULL,
  `ville` varchar(200) DEFAULT NULL,
  `pays` varchar(200) DEFAULT NULL,
  `prix` varchar(15) DEFAULT NULL,
  `surface` int(11) DEFAULT NULL,
  `surface_terrain` int(11) DEFAULT NULL,
  `piece` int(11) DEFAULT NULL,
  `chambre` int(11) DEFAULT NULL,
  `sdb` int(11) DEFAULT NULL,
  `wc` int(11) DEFAULT NULL,
  `parking` int(11) DEFAULT NULL,
  `conso_energ` varchar(2) DEFAULT NULL,
  `emission_ges` varchar(2) DEFAULT NULL,
  `visible` int(11) DEFAULT '0',
  `add_by` int(11) DEFAULT NULL,
  `add_on` int(11) DEFAULT NULL,
  `edit_by` int(11) DEFAULT NULL,
  `edit_on` int(11) DEFAULT NULL,
  `delete` int(11) DEFAULT '0',
  `vendu` int(11) DEFAULT '0',
  `acheteur_id` int(11) DEFAULT NULL,
  `coup_de_coeur` int(11) DEFAULT '0',
  `unique_id` varchar(50) DEFAULT NULL,
  `add_on_sql` date DEFAULT NULL,
  `vendu_on` int(11) DEFAULT NULL,
  `vendu_on_sql` date DEFAULT NULL,
  `vendu_by_agence` int(1) DEFAULT '0',
  `vendu_by` int(1) DEFAULT NULL,
  `prix_vente` varchar(10) DEFAULT NULL,
  `montant_frais_agence` varchar(10) DEFAULT NULL,
  `montant_com_vendeur` varchar(10) DEFAULT NULL,
  `view` int(9) DEFAULT '0',
  `video_code` text,
  `exclusif` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Tableau contenant les biens' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_bien_categorie`
--

CREATE TABLE IF NOT EXISTS `va_bien_categorie` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_bien_contact`
--

CREATE TABLE IF NOT EXISTS `va_bien_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bien_id` int(11) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `telephone` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `ip_visiteur` varchar(50) NOT NULL,
  `add_on` int(11) DEFAULT NULL,
  `read` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `bc_bienid` (`bien_id`),
  KEY `bc_read` (`read`),
  KEY `bc_addon` (`add_on`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Stockage des formulaires de contact par rapport à une annonce' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_bien_prix`
--

CREATE TABLE IF NOT EXISTS `va_bien_prix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bien_id` int(11) NOT NULL,
  `prix_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prix` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bp_bien` (`bien_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_blok`
--

CREATE TABLE IF NOT EXISTS `va_blok` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` varchar(100) DEFAULT NULL,
  `fichier` varchar(100) DEFAULT NULL,
  `call_fonction` varchar(100) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `contenu` text,
  `type` varchar(100) DEFAULT NULL,
  `visible` int(1) NOT NULL DEFAULT '1',
  `ordre` int(2) NOT NULL DEFAULT '99',
  `param` int(1) NOT NULL DEFAULT '0',
  `only_index` int(1) NOT NULL DEFAULT '0',
  `visible_by` varchar(50) NOT NULL DEFAULT 'all',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Contenu de la table `va_blok`
--

INSERT INTO `va_blok` (`id`, `position`, `fichier`, `call_fonction`, `name`, `contenu`, `type`, `visible`, `ordre`, `param`, `only_index`, `visible_by`) VALUES
(2, 'left', 'blokUtilisateur.php', 'blokUtilisateur', 'Utilisateur', NULL, 'system', 0, 1, 0, 0, 'all'),
(21, 'left', 'blokRechercheBien.php', 'blokRechercheBien', 'Recherche', '', 'ADDON', 1, 0, 0, 0, 'all');

-- --------------------------------------------------------

--
-- Structure de la table `va_blok_available`
--

CREATE TABLE IF NOT EXISTS `va_blok_available` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `file` varchar(150) NOT NULL,
  `function_call` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Contient les blok disponible' AUTO_INCREMENT=7 ;

--
-- Contenu de la table `va_blok_available`
--

INSERT INTO `va_blok_available` (`id`, `name`, `description`, `file`, `function_call`) VALUES
(4, 'Coup de coeur', 'Affiche une annonce coup de coeur de maniere aleatoire. Ce blok ne peut s affiche que sur les cotes du site', 'blokCoupDeCoeur.php', 'blokCoupDeCoeur'),
(3, 'Recherche', '', 'blokRechercheBien.php', 'blokRechercheBien'),
(5, 'Actualité', 'Affiche les dernieres actualité saisie sur le site', 'blokActualite.php', 'blokActualite'),
(6, 'Exclusivité', 'Affiche une annonce exclusive de maniere aleatoire. Ce blok ne peut s affiche que sur les cotes du site', 'blokExclusivite.php', 'blokExclusivite');

-- --------------------------------------------------------

--
-- Structure de la table `va_commun_cp_ville`
--

CREATE TABLE IF NOT EXISTS `va_commun_cp_ville` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cp` varchar(10) NOT NULL,
  `ville` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_commun_form`
--

CREATE TABLE IF NOT EXISTS `va_commun_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cf_code_form` varchar(50) NOT NULL,
  `cf_name` varchar(250) NOT NULL,
  `cf_value` text,
  `cf_type` int(2) NOT NULL DEFAULT '1',
  `cf_required` int(1) NOT NULL DEFAULT '0',
  `cf_actif` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_commun_form_data`
--

CREATE TABLE IF NOT EXISTS `va_commun_form_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `cfd_id` int(11) NOT NULL,
  `cfd_value` text,
  PRIMARY KEY (`id`),
  KEY `cf_id` (`cf_id`,`cfd_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_commun_liste`
--

CREATE TABLE IF NOT EXISTS `va_commun_liste` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(5) NOT NULL,
  `libelle` varchar(200) NOT NULL,
  `value` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code`,`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Contient les listes communes.' AUTO_INCREMENT=16 ;

--
-- Contenu de la table `va_commun_liste`
--

INSERT INTO `va_commun_liste` (`id`, `code`, `libelle`, `value`) VALUES
(12, 'DEP', 'F', 'F'),
(11, 'DEP', 'E', 'E'),
(10, 'DEP', 'D', 'D'),
(9, 'DEP', 'C', 'C'),
(8, 'DEP', 'B', 'B'),
(7, 'DEP', 'A', 'A'),
(13, 'DEP', 'G', 'G'),
(14, 'TRANS', 'Vente', 'vente'),
(15, 'TRANS', 'Location', 'loc');

-- --------------------------------------------------------

--
-- Structure de la table `va_config`
--

CREATE TABLE IF NOT EXISTS `va_config` (
  `cle` varchar(200) NOT NULL,
  `valeur` text,
  PRIMARY KEY (`cle`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `va_config`
--

INSERT INTO `va_config` (`cle`, `valeur`) VALUES
('titre_site', 'immophp'),
('keywords', 'mot,cle,'),
('description_site', 'Description du site pour les moteur de recherche.'),
('footer_site', ''),
('version', '2013032401'),
('logo', NULL),
('footer_link', '<h1>Immophp</h1>\r\n<span><a href="">Immophp</a></span><br/>\r\n<span><a href="http://api.vousfinancer.com/js/pretimmo/current/" class="simulateur_pret">Simlateur de prêt</a><span><br/>\r\n<span><a href="" title="">Mention legale</a></span>'),
('bread', '1'),
('lang', 'french'),
('news_in_index', '3'),
('news_per_page', '1'),
('news_truncate_in_index', '1'),
('rewrite_url', '1'),
('theme', 'immophp'),
('last_news_in_index', '1'),
('email', 'contact@sharkphp.com'),
('code_stat', ''),
('download_view_by', 'all'),
('index_contenu', '<script type="text/javascript"><!--\r\n    google_ad_client = "ca-pub-1710313297381782";\r\n    /* immophpindex2 */\r\n    google_ad_slot = "2633224687";\r\n    google_ad_width = 336;\r\n    google_ad_height = 280;\r\n    //-->\r\n    </script>\r\n    <script type="text/javascript"\r\n    src="http://pagead2.googlesyndication.com/pagead/show_ads.js">\r\n    </script>'),
('footer_txt', NULL),
('user_activation', 'mail'),
('mail_method', 'smtp'),
('smtp_server', 'smtp.free.fr'),
('smtp_port', '25'),
('smtp_login', ''),
('smtp_password', ''),
('annonce_per_page', '9'),
('pays_default', 'FRANCE'),
('devise', '€'),
('slogan_site', 'Cms pour agence immobiliere'),
('news_commentaire', '0'),
('install_id', 'b23b06781210cb2a16fd4196abfbadfd'),
('social_plugin_code', '<!-- AddThis Button BEGIN -->\n<div class="addthis_toolbox addthis_default_style ">\n<a class="addthis_button_preferred_1"></a>\n<a class="addthis_button_preferred_2"></a>\n<a class="addthis_button_preferred_3"></a>\n<a class="addthis_button_preferred_4"></a>\n<a class="addthis_button_compact"></a>\n<a class="addthis_counter addthis_bubble_style"></a>\n</div>\n<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=xa-51116ad557413d36"></script>\n<!-- AddThis Button END -->'),
('url_simulateur_credit', 'http://api.vousfinancer.com/js/pretimmo/current/'),
('format_date_day', '%d/%m/%Y'),
('format_date', '%d/%m/%Y - %H:%M'),
('bien_seuil_visite_hebdomadaire', NULL),
('bien_seuil_visite_mensuel', NULL),
('index_carte_agence', '1'),
('index_last_annonce', '1'),
('index_page', ''),
('news_nom', 'News'),
('register_open', '0'),
('article_nom', 'Articles'),
('article_pager', '0'),
('article_commentaire', '1'),
('article_per_page', '5'),
('download_per_page', '10'),
('annuaire_submit_onlymember', '1'),
('annuaire_site_rss', '0'),
('annuaire_site_keyword', '0'),
('annuaire_site_backlink_required', '1'),
('annuaire_pub_afert_first', '0'),
('annuaire_code_pub', '\n	<script type="text/javascript"><!--\n	google_ad_client = "ca-pub-1710313297381782";\n	/* carpe 468x60 */\n	google_ad_slot = "4753583552";\n	google_ad_width = 468;\n	google_ad_height = 60;\n	//-->\n	</script>\n	<script type="text/javascript"\n	src="http://pagead2.googlesyndication.com/pagead/show_ads.js">\n	</script>'),
('annuaire_code_backlink', '<a href="http://www.sharkphp.com/annuaire" title="Annuaire de lien en dur sharkphp">Sharkphp annuaire</a>'),
('annuaire_min_length_resume', '100'),
('annuaire_min_length_description', '600'),
('annuaire_regle_soumission', ''),
('user_use_group', '1'),
('user_id', 'int'),
('user_edit_profil', '1'),
('user_register_by_fb', '0'),
('user_avatar', '1'),
('user_delete_account', '0'),
('user_group_default_visiteur', '1'),
('user_group_default_membre', '2'),
('user_group_default_admin', '4'),
('use_ckeditor', '0'),
('use_sh', '1'),
('fb_app_id', ''),
('fb_url', ''),
('twitter_url', ''),
('print_stat_page', '1'),
('forum_name', 'Forum'),
('forum_description', 'Description du forum'),
('forum_group_modo', '3'),
('forum_pub_after_1_message', '1'),
('forum_pub_code', '\n	<script type="text/javascript"><!--\n	google_ad_client = "ca-pub-1710313297381782";\n	/* carpe 468x60 */\n	google_ad_slot = "4753583552";\n	google_ad_width = 468;\n	google_ad_height = 60;\n	//-->\n	</script>\n	<script type="text/javascript"\n	src="http://pagead2.googlesyndication.com/pagead/show_ads.js">\n	</script>'),
('mod_feed_rss', '0'),
('mod_link', '0'),
('mod_annuaire', '0'),
('mod_forum', '0'),
('mod_download', '0'),
('mod_news', '1'),
('mod_page', '1'),
('mod_article', '1');

-- --------------------------------------------------------

--
-- Structure de la table `va_contact`
--

CREATE TABLE IF NOT EXISTS `va_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `ip` varchar(50) NOT NULL,
  `post_on` int(15) NOT NULL,
  `lu` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_discussion`
--

CREATE TABLE IF NOT EXISTS `va_discussion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sujet` varchar(150) NOT NULL,
  `reply` int(1) NOT NULL DEFAULT '1',
  `last_update` int(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_download`
--

CREATE TABLE IF NOT EXISTS `va_download` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categorie_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL,
  `apercu` varchar(255) NOT NULL,
  `vue` int(11) DEFAULT '0',
  `downloaded` int(11) DEFAULT '0',
  `download_for` varchar(10) DEFAULT 'all',
  `add_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `add_by` int(11) DEFAULT NULL,
  `visible` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `download_categorie` (`categorie_id`),
  KEY `download_user` (`add_on`),
  KEY `download_visible` (`visible`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_download_categorie`
--

CREATE TABLE IF NOT EXISTS `va_download_categorie` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_feed_rss_item`
--

CREATE TABLE IF NOT EXISTS `va_feed_rss_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed_rss_link_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `add_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_feed_rss_link`
--

CREATE TABLE IF NOT EXISTS `va_feed_rss_link` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_feed_rss_link_categorie`
--

CREATE TABLE IF NOT EXISTS `va_feed_rss_link_categorie` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_forum`
--

CREATE TABLE IF NOT EXISTS `va_forum` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_forum_log_moderation`
--

CREATE TABLE IF NOT EXISTS `va_forum_log_moderation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_action` datetime NOT NULL,
  `moderateur_id` int(11) NOT NULL,
  `thread_id` int(11) DEFAULT NULL,
  `forum_id` int(11) DEFAULT NULL,
  `message_id` int(11) DEFAULT NULL,
  `action` text NOT NULL,
  `detail` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_forum_message`
--

CREATE TABLE IF NOT EXISTS `va_forum_message` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_forum_message_alerte`
--

CREATE TABLE IF NOT EXISTS `va_forum_message_alerte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `date_alerte` datetime DEFAULT NULL,
  `traite` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_forum_thread`
--

CREATE TABLE IF NOT EXISTS `va_forum_thread` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_forum_thread_user_follow`
--

CREATE TABLE IF NOT EXISTS `va_forum_thread_user_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_last_visite` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_groupe`
--

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

--
-- Contenu de la table `va_groupe`
--

INSERT INTO `va_groupe` (`id`, `name`, `description`, `image`, `principal`, `systeme`, `ouvert`, `visible`) VALUES
(1, 'visiteurs', 'groupe par defaut pour les visiteur', NULL, 0, 1, 0, 0),
(2, 'membres', 'groupe contenant tout les membres', NULL, 1, 1, 0, 0),
(3, 'moderateurs', 'groupe contenant les moderateurs du forums', NULL, 0, 1, 0, 0),
(4, 'administrateur', 'groupe contenant les administrateur du site', NULL, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `va_link`
--

CREATE TABLE IF NOT EXISTS `va_link` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Table contenant les liens' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_link_available`
--

CREATE TABLE IF NOT EXISTS `va_link_available` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `va_link_available`
--

INSERT INTO `va_link_available` (`id`, `name`, `link`) VALUES
(1, 'Annonces', 'annonce'),
(2, 'Agences', 'agence'),
(3, 'Carte', 'annonce/carte'),
(4, 'Contact', 'contact');

-- --------------------------------------------------------

--
-- Structure de la table `va_link_categorie`
--

CREATE TABLE IF NOT EXISTS `va_link_categorie` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_logs`
--

CREATE TABLE IF NOT EXISTS `va_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date et heure du log',
  `log_by` int(11) NOT NULL COMMENT 'Utilisateur ayant realiser l action',
  `model` varchar(100) NOT NULL COMMENT 'Nom du model',
  `model_id` int(11) NOT NULL COMMENT 'Id du model',
  `log` text NOT NULL COMMENT 'Description de l action',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_log_admin`
--

CREATE TABLE IF NOT EXISTS `va_log_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log` text NOT NULL,
  `log_by` int(11) NOT NULL,
  `log_at` int(15) NOT NULL,
  `module` varchar(50) DEFAULT NULL,
  `link_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_mailing`
--

CREATE TABLE IF NOT EXISTS `va_mailing` (
  `id` int(11) NOT NULL,
  `sujet` varchar(150) DEFAULT NULL,
  `message` text,
  `destinataires` varchar(45) DEFAULT NULL,
  `auteur_id` int(11) DEFAULT NULL,
  `date_mailing` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `va_menu`
--

CREATE TABLE IF NOT EXISTS `va_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `creat_on` int(15) NOT NULL,
  `creat_by` int(11) NOT NULL,
  `links` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_messbox`
--

CREATE TABLE IF NOT EXISTS `va_messbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `destinataire_id` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `discussion_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `lu` int(1) NOT NULL DEFAULT '0',
  `post_on` int(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_news`
--

CREATE TABLE IF NOT EXISTS `va_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sujet` varchar(150) DEFAULT NULL,
  `contenu` text NOT NULL,
  `contenu_suite` text,
  `post_on` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `categorie_id` int(11) NOT NULL DEFAULT '0',
  `source` varchar(200) DEFAULT NULL,
  `source_link` varchar(200) DEFAULT NULL,
  `commentaire` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `categorie_id` (`categorie_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_news_categorie`
--

CREATE TABLE IF NOT EXISTS `va_news_categorie` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_news_commentaire`
--

CREATE TABLE IF NOT EXISTS `va_news_commentaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `commentaire` text NOT NULL,
  `post_on` int(11) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `news_id` (`model_id`),
  KEY `auteur_id` (`auteur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_page`
--

CREATE TABLE IF NOT EXISTS `va_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(150) NOT NULL,
  `contenu` text NOT NULL,
  `creat_on` int(15) NOT NULL,
  `edit_on` int(15) NOT NULL,
  `auteur_id` int(11) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_prospect`
--

CREATE TABLE IF NOT EXISTS `va_prospect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(200) NOT NULL,
  `prenom` varchar(200) NOT NULL,
  `adresse` text,
  `code_postal` varchar(20) DEFAULT NULL,
  `ville` varchar(200) DEFAULT NULL,
  `pays` varchar(200) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `portable` varchar(20) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `vendeur` int(1) DEFAULT '0',
  `acheteur` int(1) DEFAULT '0',
  `criteres` text,
  `deja_proprietaire` int(1) DEFAULT '0',
  `preference_contact` text,
  `preference_visite` text,
  `autres` text,
  `add_by` int(11) DEFAULT NULL,
  `add_on` int(11) DEFAULT NULL,
  `edit_by` int(11) DEFAULT NULL,
  `edit_on` int(11) DEFAULT NULL,
  `delete` int(1) DEFAULT '0',
  `agence_id` int(11) DEFAULT NULL,
  `add_on_sql` date DEFAULT NULL,
  `edit_on_sql` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `p_vendeur` (`vendeur`),
  KEY `p_achateur` (`acheteur`),
  KEY `p_delete` (`delete`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Table contenant les prospects' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_prospect_suivi`
--

CREATE TABLE IF NOT EXISTS `va_prospect_suivi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prospect_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `suivi` text NOT NULL,
  `add_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ps_prospect_id` (`prospect_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_sessions`
--

CREATE TABLE IF NOT EXISTS `va_sessions` (
  `session_id` varchar(50) CHARACTER SET latin1 NOT NULL,
  `user_id` varchar(50) CHARACTER SET latin1 NOT NULL,
  `ip` varchar(50) CHARACTER SET latin1 NOT NULL,
  `create_on` int(11) NOT NULL,
  `last_used` int(11) NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `va_sessions`
--

INSERT INTO `va_sessions` (`session_id`, `user_id`, `ip`, `create_on`, `last_used`) VALUES
('13adf635c41db588d1e311f36d3c57d1', 'Visiteur', '78.227.211.202', 1364146977, 1364146977),
('da8be4429f64b9a999aa6846e250d733', 'Visiteur', '54.234.58.210', 1364146976, 1364146976),
('940abf58fb279134b78ee10948005f3e', 'Visiteur', '78.227.211.202', 1364146973, 1364146975);

-- --------------------------------------------------------

--
-- Structure de la table `va_template_available`
--

CREATE TABLE IF NOT EXISTS `va_template_available` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `chemin` varchar(200) NOT NULL,
  `call_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `va_template_available`
--

INSERT INTO `va_template_available` (`id`, `nom`, `description`, `chemin`, `call_url`) VALUES
(1, 'Annonce detail', 'Page de presentation des annonces', 'app#view#annonce#detail.tpl', 'annonce/detail/ID'),
(2, 'Annonce liste', 'Liste des annonces', 'app#view#annonce#index.tpl', 'annonce/index'),
(3, 'Agence liste', 'Liste des agences', 'app#view#agence#index.tpl', 'agence/index'),
(4, 'Agence detail', 'Detail agence', 'app#view#agence#detail.tpl', 'agence/detail/ID');

-- --------------------------------------------------------

--
-- Structure de la table `va_user`
--

CREATE TABLE IF NOT EXISTS `va_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifiant` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `isAdmin` int(1) NOT NULL DEFAULT '0',
  `actif` int(1) NOT NULL DEFAULT '0',
  `register_on` int(15) NOT NULL,
  `avatar` varchar(50) DEFAULT NULL,
  `last_connexion` int(15) NOT NULL,
  `token_activation` varchar(100) DEFAULT NULL,
  `nom` varchar(200) DEFAULT NULL,
  `prenom` varchar(200) DEFAULT NULL,
  `portable` varchar(50) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `signature` text,
  `groupe_id` int(11) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `facebook` varchar(200) DEFAULT NULL,
  `facebook_id` varchar(50) DEFAULT NULL,
  `tweeter` varchar(200) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `ville` varchar(150) DEFAULT NULL,
  `pays` varchar(150) DEFAULT NULL,
  `lang` varchar(30) DEFAULT NULL,
  `sexe` varchar(1) DEFAULT NULL,
  `newsletter` int(1) DEFAULT NULL,
  `mailing` int(1) DEFAULT NULL,
  `date_edit_profil` timestamp NULL DEFAULT NULL,
  `date_changepassword` timestamp NULL DEFAULT NULL,
  `uniq_id` varchar(50) DEFAULT NULL,
  `gmail_adr` varchar(200) DEFAULT NULL,
  `gmail_password` varchar(200) DEFAULT NULL,
  `gmail_id_prv` varchar(200) DEFAULT NULL,
  `agence_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifiant` (`identifiant`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Contenu de la table `va_user`
--

INSERT INTO `va_user` (`id`, `identifiant`, `email`, `password`, `isAdmin`, `actif`, `register_on`, `avatar`, `last_connexion`, `token_activation`, `nom`, `prenom`, `portable`, `telephone`, `signature`, `groupe_id`, `url`, `facebook`, `facebook_id`, `tweeter`, `date_naissance`, `ville`, `pays`, `lang`, `sexe`, `newsletter`, `mailing`, `date_edit_profil`, `date_changepassword`, `uniq_id`, `gmail_adr`, `gmail_password`, `gmail_id_prv`, `agence_id`) VALUES
(1, 'admin', 'contact@rossini-transaction.com', '5d587f223f68c75764b0571859623390e23994a9', 9, 1, 1343389430, NULL, 1362102473, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `va_user_groupe`
--

CREATE TABLE IF NOT EXISTS `va_user_groupe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `groupe_id` int(11) NOT NULL,
  `principal` varchar(20) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL COMMENT 'Permet de definir un role a l utilisateur au sein du groupe. admin, membre ...',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Liaison entre les utilisateurs et ses groupes' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_user_notification`
--

CREATE TABLE IF NOT EXISTS `va_user_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_notification` datetime NOT NULL,
  `notification` text NOT NULL,
  `read` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_user_reset_password`
--

CREATE TABLE IF NOT EXISTS `va_user_reset_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(200) NOT NULL,
  `time_on_demand` int(15) NOT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_view_template`
--

CREATE TABLE IF NOT EXISTS `va_view_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `real_dir` varchar(150) NOT NULL,
  `tpl` text NOT NULL,
  `creat_on` int(11) NOT NULL,
  `edit_on` int(11) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '0',
  `template_id` int(11) DEFAULT NULL COMMENT 'Id #template_available',
  `token` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_visite`
--

CREATE TABLE IF NOT EXISTS `va_visite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `bien_id` int(11) DEFAULT NULL,
  `prospect_id` int(11) DEFAULT NULL,
  `date_visite` date DEFAULT NULL,
  `heure_visite` time DEFAULT NULL,
  `compte_rendu` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `va_visite_user_gcalendar`
--

CREATE TABLE IF NOT EXISTS `va_visite_user_gcalendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visite_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `g_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
