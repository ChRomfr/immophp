{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Systeme}</li>
</ul>

<div class="well">
	<h4>Informations</h4>
	<dl class="dl-horizontal">
		<dt>Site map</dt>
		<dd>{$config.url}{$config.url_dir}index.php/xml/sitemap</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>Flux news</dt>
		<dd>{$config.url}{$config.url_dir}index.php/xml/fluxRSSNews</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>Flux articles</dt>
		<dd>{$config.url}{$config.url_dir}index.php/xml/fluxRSSArticle</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>Flux telechargements</dt>
		<dd>{$config.url}{$config.url_dir}index.php/xml/fluxRSSDownload</dd>
	</dl>
</div>

<div class="well">
	<legend>{$lang.Cache}</legend>
	<table>
		<tr>
			<td><a href="javascript:clearCache();" class="btn btn-primary">{$lang.Supprimer}</a></td>
		</tr>
	</table>
	<div id="resultClearCache"></div>
</div>

<div class="well">
	<legend>{$lang.Visiteurs_en_ligne}</legend>
	<table class="table table-condensed table-striped">
	{foreach $uonline as $u}
	<tr>
		<td>{$u.identifiant}</td>
        <td>{$u.user_id}</td>
        <td>{$u.ip}</td>
	</tr>
	{/foreach}
	</table>
</div>

<!-- Information hebergements -->
<div class="well">
	<h4>Information system</h4>
	<table class="table table-striped">
		<tr>
			<td>PHP :</td>
			<td>{phpversion()}</td>
		</tr>
		{if apache_get_version()}
		<tr>
			<td>Apache :</td>
			<td>{apache_get_version()}</td>
		</tr>
		{/if}
	</table>
</div>

{/strip}

<script>
function clearCache(){
    $.get(
        '{$Helper->getLinkAdm("systeme/deleteCache")}', {literal}
        {nohtml:'nohtml'},
        function(data){ $('#resultClearCache').html(data); }
    );
}
{/literal}
</script>