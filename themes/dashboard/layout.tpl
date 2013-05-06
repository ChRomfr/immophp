<!DOCTYPE html>
<html>
<head>
<title>{$config.titre_site} :: Administration</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="icon" type="image/png" href="{$config.url}{$config.url_dir}themes/sharkphp/images/sharkphp.png" />
<!--[if IE]><link rel="shortcut icon" type="image/x-icon" href="{$config.url}{$config.url_dir}themes/sharkphp/images/sharkphp.ico" /><![endif]-->
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/bootstrap/css/font-awesome.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/bootstrap/css/bootstrap.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/bootstrap/css/bootstrap-responsive.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/dashboard/css/opa-icons.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/dashboard/css/charisma-app.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/dashboard/css/uniform.default.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/dashboard/dashboard.css" type="text/css" media="screen" />
{if !empty($css_add)}
{foreach $css_add as $k => $v}
<link rel="stylesheet" href="{$config.url}{$config.url_dir}web/css/{$v}" type="text/css" media="screen" />
{/foreach}
{foreach registry::$css_lib as $k => $v}
<link rel="stylesheet" href="{$config.url}{$config.url_dir}web/lib/{$v}" type="text/css" media="screen" />
{/foreach}
{/if}
<script type="text/javascript" src="{$config.url}{$config.url_dir}web/js/javascript.js"></script>
{if !empty($js_add)}
{foreach $js_add as $k => $v}
<script type="text/javascript" src="{$config.url}{$config.url_dir}web/js/{$v}"></script>
{/foreach}
{/if}
{foreach registry::$js_lib as $k => $v}
<script type="text/javascript" src="{$config.url}{$config.url_dir}web/lib/{$v}"></script>
{/foreach}

<script type="text/javascript" src="{$config.url}{$config.url_dir}themes/bootstrap/js/bootstrap.min.js"></script>
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body data-spy="scroll" data-target=".navbar">
{strip}
	<!-- NAVBAR -->
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="btn btn-navbar" data-toggle="collapse" date-target=".nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="{$Helper->getLink("index")}" title="Retour au site">IMMOPHP</a>
				<div class="nav-collapse">
					<ul class="nav">
						<li><a href="{$Helper->getLinkAdm("index")}"><i class="icon-home icon-white"></i></a></li>
						<li><a href="{$Helper->getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a></li>
						<li><a href="{$Helper->getLinkAdm("prospect")}" title="{$lang.Prospect}">{$lang.Prospects}</a></li>
						<li><a href="{$Helper->getLinkAdm("visite")}" title="{$lang.Visites}">{$lang.Visites}</a></li>
						<li><a href="{$Helper->getLinkAdm("agence")}" title="{$lang.Agences}">{$lang.Agences}</a></li>
					</ul>
					<ul class="nav pull-right">
						{if $smarty.session.utilisateur.id != 'Visiteur'}
						<li><a href="{$Helper->getLink("utilisateur")}" title=""><i class="icon-user icon-white"></i></a>
						<li><a href="{$Helper->getLink("connexion/logout")}" title=""><i class="icon-off icon-white"></i></a>
						{/if}

						{if $smarty.session.utilisateur.isAdmin > 0}
						<li><a href="{$config.url}{$config.url_dir}adm/" title="Administration"><i class="icon-wrench icon-white"></i></a></li>
						{/if}
					</ul>
					
				</div>
			</div>
		</div>
	</div><!-- /navbar -->
	<!-- Header -->
	<div id="header" style="padding-top:50px;"></div>

	<!-- Conteneur centrale -->
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2 main-menu-span" style="padding-top:20px;">
				<div class="well nav-collapse sidebar-nav">
					<ul class="nav nav-tabs nav-stacked main-menu">
						<li class="nav-header hidden-tablet">Immobilier</li>
						<!-- BIENS -->
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">{$lang.Biens}&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
                				<li><a href="{$Helper->getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a></li>
                				<li><a href="{$Helper->getLinkAdm("bien/add")}" title="{$lang.Ajouter}">{$lang.Ajouter}</a></li>
                				<li><a href="{$Helper->getLinkAdm("categorie?c=bien")}" title="">{$lang.Categorie}</a></li>
                			</ul>
                		</li>
                		<!-- AGENCES -->
                		<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">{$lang.Agences}&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
                				<li><a href="{$Helper->getLinkAdm("agence")}" title="{$lang.Agences}">{$lang.Agences}</a></li>
                				<li><a href="{$Helper->getLinkAdm("agence/add")}" title="{$lang.Ajouter}">{$lang.Ajouter}</a></li>
                			</ul>
                		</li>
						<!-- CONTACT -->
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">{$lang.Contact}&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
                				<li><a href="{$Helper->getLinkAdm("contact")}" title="{$lang.Contact}">{$lang.Contact}</a></li>
                				<li><a href="{$Helper->getLinkAdm("contact?type=biens")}" title="{$lang.Biens}">{$lang.Biens}</a></li>
                				<li><a href="{$Helper->getLinkAdm("contact?type=agences")}" title="{$lang.Agences}">{$lang.Agences}</a></li>
                			</ul>
                		</li>
                		<!-- PROSPECT -->
                		<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">{$lang.Prospects}&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
                				<li><a href="{$Helper->getLinkAdm("prospect")}" title="{$lang.Prospects}">{$lang.Prospects}</a></li>
                				<li><a href="{$Helper->getLinkAdm("prospect/add")}" title="{$lang.Ajouter}">{$lang.Ajouter}</a></li>
                			</ul>
                		</li>
						<!-- VISITES -->
                		<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">{$lang.Visites}&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
                				<li><a href="{$Helper->getLinkAdm("visite")}" title="{$lang.Visites}">{$lang.Visites}</a></li>
                			</ul>
                		</li>
					{if $smarty.session.utilisateur.isAdmin  > 3}
						<li class="nav-header hidden-tablet">Main</li>
						<li><a href="{$Helper->getLinkAdm("index")}" title="">Dashboard</a></li>
						{if $config.mod_annuaire == 1}
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">Annuaire&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("annuaire")}">Annuaire</a></li>
								<li><a href="{$Helper->getLinkAdm("categorie?c=annuaire")}" title=""}>Categorie</a></li>
								<li><a href="{$Helper->getLinkAdm("annuaire/setting")}" title=""}>Configuration</a></li>
							</ul>
						</li>
						{/if}
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">Article&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("article")}">Article</a></li>
								<li><a href="{$Helper->getLinkAdm("categorie?c=article")}" title=""}>Categorie</a></li>
							</ul>
						</li>
						<li><a href="{$Helper->getLinkAdm("blok")}" title="">Blok</a></li>
						<li><a href="{$Helper->getLinkAdm("contact")}" title="Contact">Contact</a></li>

						{if $config.mod_forum == 1}
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">Forums&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("forum")}" title="">Forums</a></li>
								<li><a href="{$Helper->getLinkAdm("forum/alertes")}" title="">Alertes</a></li>
								<li><a href="{$Helper->getLinkAdm("forum/logs")}" title="">Logs</a></li>
							</ul>
						</li>
						{/if}

						{if $config.mod_feed_rss == 1}
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">Flux&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("feedRss")}" title="">Flux RSS</a></li>
								<li><a href="{$Helper->getLinkAdm("categorie?c=feed_rss_link")}" title=""}>Categorie</a></li>
							</ul>
						</li>
						{/if}

						{if $config.mod_link == 1}
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">Liens&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("link")}" title="">Liens</a></li>
								<li><a href="{$Helper->getLinkAdm("categorie?c=link")}" title=""}>Categorie</a></li>
							</ul>
						</li>
						{/if}

						<li><a href="{$Helper->getLinkAdm("menu")}" title="">Menu</a></li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">News&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("news")}" title="">News</a></li>
								<li><a href="{$Helper->getLinkAdm("categorie?c=news")}" title=""}>Categorie</a></li>
							</ul>
						</li>
						<li><a href="{$Helper->getLinkAdm("page")}" title="">Page</a></li>
						<li><a href="{$Helper->getLinkAdm("configuration")}" title="">Préférences</a></li>
						
						{if $config.mod_download == 1}
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">Téléchargements&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("download")}" title="">Téléchargements</a></li>
								<li><a href="{$Helper->getLinkAdm("categorie?c=download")}" title=""}>Categorie</a></li>
							</ul>
						</li>
						{/if}

						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">{$lang.Utilisateurs}&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("utilisateur")}" title="">{$lang.Utilisateurs}</a></li>
								<li><a href="{$Helper->getLinkAdm("utilisateur/groupe")}" title="">{$lang.Groupes}</a></li>
							</ul>
						</li>
						
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="">Système&nbsp;<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="{$Helper->getLinkAdm("systeme")}" title="">Système</a></li>
								<li><a href="{$Helper->getLinkAdm("filemanager")}" title="">File manager</a></li>
								<li><a href="{$Helper->getLinkAdm("viewEditor")}" title="">Editeur de vue</a></li>
								<li><a href="{$Helper->getLinkAdm("systeme/errorPhp")}" title="">Erreurs PHP</a></li>
							</ul>
						</li>
						<!-- Traitements des bundles -->
						{if isset($Bundle) && is_array($Bundle)}
							{foreach $Bundle as $Row}
								{if $Row.menu_admin == 1}
									{$Row.menu_admin_code}
								{/if}
							{/foreach}
						{/if}
					{/if}
					</ul><!-- /nav -->
				</div><!-- /well -->
			</div><!-- /span2 -->
			<div class="span10">
				{$content}
			</div><!-- /span10 -->
		</div><!-- /row-fluid -->
	</div><!-- /container-fluid -->

	<!-- Footer -->
	<footer class="footer_site">
		<div class="container">
			<div class="row-fluid">
				<div class="span8">
				</div><!-- /span8 -->
				<div class="span4">
				</div><!-- /span4 -->
			</div><!-- /row-fluid-->
		</div><!-- /container -->
		<div class="container">
			<div class="row-fluid">
				<div class="span8">	
				</div>
				<div class="span4">					
				</div>
			</div><!-- /row-fluid -->
			<hr/>
			<div class="fleft">
				
			</div>
			<div class="fright">
				Réaliser avec <a href="http://www.sharkphp.com" title="Another CMS/FRAMEWORK">Sharkphp <img src="{$config.url}{$config.url_dir}web/images/sharkphp.png" alt="" style="width:20px;" /></a>
			</div>
			<div class="clear"></div>
		</div><!-- /container -->
	</footer>
{/strip}
<script type="text/javascript">
<!--
$(document).ready(function() {
	$("a.fbimage").fancybox();
});
{if isset($FlashMessage) && !empty($FlashMessage)}
$(".breadcrumb").after('<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">&times;</button>{$FlashMessage}</div>');
{/if}
//-->
</script>
</body>
</html>