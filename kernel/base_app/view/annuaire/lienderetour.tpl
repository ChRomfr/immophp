<ul class="breadcrumb">
	<li><a href="{$Helper->getLink('index')}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink('index')}" title="{$lang.Annuaire}">{$lang.Annuaire}</a><span class="divider">/</span></li>
	<li>{$lang.Lien_de_retour}</li>
</ul>

<div class="well">
	
	<h4>{$lang.Lien_de_retour}</h4>

	<pre>{$config.annuaire_code_backlink|htmlentities}</pre>

</div>

