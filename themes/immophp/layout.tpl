<!DOCTYPE html>
<head>
<title>{$config.titre_site}{if isset($ctitre)} :: {$ctitre}{else} :: {$config.slogan_site}{/if}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="title" content="{$config.titre_site} {if isset($ctitre)} :: {$ctitre}{/if}" />
<meta name="description" content="{if isset($Description_this_page)}{$Description_this_page}{else}{$config.description_site}{/if}" />
<meta name="keywords" content="{$config.keywords}" />	
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/bootstrap/css/bootstrap.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/bootstrap/css/bootstrap-responsive.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/default/design.css" type="text/css" media="screen" />
<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/immophp/style.css" type="text/css" media="screen" />
<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="{getLink("xml/rss?nohtml")}" />
{if !empty($css_add)}
{foreach $css_add as $k => $v}
<link rel="stylesheet" href="{$config.url}{$config.url_dir}web/css/{$v}" type="text/css" media="screen" />
{/foreach}
{/if}
{foreach registry::$css_lib as $k => $v}
<link rel="stylesheet" href="{$config.url}{$config.url_dir}web/lib/{$v}" type="text/css" media="screen" />
{/foreach}
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
<body>
	<div id="contenu">
		<div id="header">
            <div style="padding-top: 5px;">
                <span style="font-size: 24px; color:#fff; font-weight: bolder;">{$config.titre_site}</span>
            </div>
            <div style="padding-top: 5px; padding-left: 25px;">
                <span style="font-size: 14px; color:#fff; font-weight: bolder;">{$config.slogan_site}</span>
            </div>
        </div>
		
		<div id="wrap">
			<!-- START CONTENEUR GAUCHE -->
			<div id="blockGauche" style="position:relative;">
				{$blokGauche}
                
                <!-- Affichage autre en fonction de la page -->
               
			</div>
			<!-- END CONTENEUR GAUCHE -->
			
			<div id="blockCentre">
				<!-- START CONTENU PAGE -->
				<div class="">{$content}</div>
				<!-- END CONTENU PAGE -->

				<!-- START CODE SOCIAL PLUGIN -->
				{if !empty($config.social_plugin_code)}
				<div class="fright">
					{$config.social_plugin_code}
				</div>
				<div class="clear"></div>
				{/if}
				<!-- END CODE SOCIAL PLUGIN -->

				{strip}
			</div><!-- END #blockCentre -->
			<div class="clear"></div>
		</div><!-- END #wrap -->
		<div class="bot"></div>			
	</div><!-- END #contenu -->
	<div id="footer">
        <div id="footer_contener">
            <div class="footer_agences">
                <h1>{$lang.Nos_agences}</h1>
                {foreach $Agences as $Row name=loopagence}
                 <span><a href="{getLink("agence/detail/{$Row.id}/{$Row.nom|urlencode}")}" title="{$Row.nom}">{$Row.nom}</a></span><br/>
                 {if $smarty.foreach.loopagence.iteration == 3}
                 {break}
                 {/if}
                {/foreach}
            </div>
            <div class="footer_biens">
                <h1>{$lang.Nos_annonces}</h1>
                {foreach $Categories as $Row name=loopacategorie}
                <span><a href="{getLink("annonce?criteres[categorie]={$Row.id}")}" title="{$Row.name}">{$Row.name}</a></span><br/>
                {if $smarty.foreach.loopacategorie.iteration == 3}
                 {break}
                 {/if}
                {/foreach}
            </div>
            <div class="footer_links">
                {$config.footer_link}
            </div>
        </div>
	</div>
	<div class="clear"></div>{/strip}
	<div id="diag-utils"></div>
	{$config.code_stat}
<script type="text/javascript">
<!--
$(function() {
    $("a.simulateur_pret").fancybox({
		'width'				: '75%',
		'height'			: '75%',
		'autoScale'			: false,
		'transitionIn'		: 'none',
		'transitionOut'		: 'none',
		'type'				: 'iframe'
    });
});
//-->
</script>
</body>
</html>