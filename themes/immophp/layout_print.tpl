<!DOCTYPE html>
<head>
	<title>{$config.titre_site}{if isset($ctitre)} :: {$ctitre}{else} :: {$config.slogan_site}{/if}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="title" content="{$config.titre_site} {if isset($ctitre)} :: {$ctitre}{/if}" />
	<meta name="description" content="{if isset($Description_this_page)}{$Description_this_page}{else}{$config.description_site}{/if}" />
	<meta name="keywords" content="{$config.keywords}" />
	<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/immophp/style_print.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/immophp/style_print.css" type="text/css" media="print" />
	<link rel="stylesheet" href="{$config.url}{$config.url_dir}themes/default/design.css" type="text/css" media="screen" />
	{if !empty($css_add)}
    {foreach $css_add as $k => $v}
    <link rel="stylesheet" href="{$config.url}{$config.url_dir}web/css/{$v}" type="text/css" media="screen" />
    {/foreach}
	{/if}
	<script type="text/javascript" src="{$config.url}{$config.url_dir}web/js/javascript.js"></script>
	{if !empty($js_add)}
    {foreach $js_add as $k => $v}
    <script type="text/javascript" src="{$config.url}{$config.url_dir}web/js/{$v}"></script>
    {/foreach}
	{/if}
	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
    <script type="text/javascript">
    <!--
    $(function() {
        $( "#diag-utils" ).dialog({ autoOpen: false, width:600 });
    });
    </script>
</head>
<body>
	<div id="contenu">
        {$content}
    </div>
</html>