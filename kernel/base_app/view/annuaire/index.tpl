<!-- 
base_app/view/annuaire/index.tpl
//-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink('index')}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	{if isset($smarty.get.cid)}
		<li><a href="{$Helper->getLink('annuaire')}" title="Annuaire">Annuaire</a><span class="divider">/</span></li>
	{else}
		<li>Annuaire</li>
	{/if}
	{if isset($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("annuaire/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
		{/foreach}
	{/if}
	{if isset($Categorie)}<li>{$Categorie.name}</li>{/if}
</ul>

{if isset($Categories) && count($Categories) > 0}
<div id="categories_list" class="well" style="min-height:100px;">
	<h4>{$lang.Categories}</h4>
	{foreach $Categories as $Categorie name=lcat}
		<div class="{if $smarty.foreach.lcat.iteration%2 == 0}fright{else}fleft{/if}" style="width:45%; margin-bottom:5px; padding-bottom:5px; ">
			{if !empty($Categorie.image)}
			<div style="float:left">
				<img src="{$config.url}{$config.url_dir}web/upload/categorie/{$Categorie.image}" alt="" style="width:50px;"/>
			</div>
			{/if}
			<div style="float:left">
				<a href="{$Helper->getLink("annuaire/index?cid={$Categorie.id}")}" title="{$Categorie.name}"><strong>{$Categorie.name}</strong></a><br/>
				{$Categorie.description}
			</div>
			<div style="clear:both"></div>
		</div>
		{if $smarty.foreach.lcat.iteration%2 == 0}<div class="clear"></div>{/if}
	{/foreach}
	<div class="clear"></div>
</div>
{/if}

{if isset($Sites) && count($Sites) > 0}
	{foreach $Sites as $Site name=loopsite}
		<div class="well">
			<h4><a href="{$Helper->getLink("annuaire/detail/{$Site.id}/{$Site.name|urlencode}")}" title="Fiche de {$Site.name}">{$Site.name}</a></h4>
			<hr/>
			<div class="pull-left" style="width:250px;">
				<img src="http://www.apercite.fr/api/apercite/160x120/oui/oui/{$Site.url}" alt="{$Site.name}" />
			</div>
			<div class="pull-left" style="width:700px;">
				{$Site.resume|nl2br}
				<br/><br/>
				<a href="{$Site.url}" title="{$Site.name}" target="_blank">{$Site.url}</a>
			</div>
			<div class="pull-right">
				<a href="{$Helper->getLink("annuaire/detail/{$Site.id}/{$Site.name|urlencode}")}" title="Fiche de {$Site.name}" class="btn">Consulter la fiche</a>
			</div>
			<div class="clearfix"></div>
		</div>
		{if $smarty.foreach.loopsite.iteration == 1}
		<div class="well" style="text-align:center">
			{$config.annuaire_code_pub}
		</div>
		{/if}
	{/foreach}
{else}
	{if isset($smarty.get.cid)}
	<div class="alert alert-block">
		Aucun sites dans cette categorie ...
	</div>
	{/if}
{/if}
{if isset($Pagination)}
<!-- Pagination -->
<div class="pagination">{$Pagination->render()}</div>
{/if}
<div style="text-align:center;">
	<a href="{$Helper->getLink("annuaire/proposer")}" title="Proposer un site" class="btn">Proposer un site</a>
</div>
{/strip}