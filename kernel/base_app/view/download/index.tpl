<!-- 
base_app/view/download/index.tpl
//-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink('index')}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	{if isset($smarty.get.cid)}
		<li><a href="{$Helper->getLink('download')}" title="{$lang.Telechargement}">{$lang.Telechargement}</a><span class="divider">/</span></li>
	{else}
		<li>{$lang.Telechargement}</li>
	{/if}
	{if isset($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("download/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
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
				<a href="{$Helper->getLink("download/index?cid={$Categorie.id}")}" title="{$Categorie.name}"><strong>{$Categorie.name}</strong></a><br/>
				{$Categorie.description}
			</div>
			<div style="clear:both"></div>
		</div>
		{if $smarty.foreach.lcat.iteration%2 == 0}<div class="clear"></div>{/if}
	{/foreach}
	<div class="clear"></div>
</div>
{/if}

{if count($Downloads) > 0}
	{foreach $Downloads as $Download}
		<div class="well">
			{if !empty($Download.apercu)}
			<div class="fright"><img src="{$Download.apercu}" alt="" style="width:100px;"/></div>
			{/if}
			<h4><a href="{$Helper->getLink("download/detail/{$Download.id}")}" title="{$Download.name}">{$Download.name}</a></h4>
			<div class="clear"></div>
			<div class="fleft">	{$Download.description|strip_tags|wordwrap:50}</div>		
			<div class="clear"></div>
			<hr/>
			<div><i class="icon-calendar"></i>{$Download.add_on}</div>
		</div>
	{/foreach}
{else}
	{if isset($smarty.get.cid)}
	<div class="alert alert-block">
		Aucun telechargement dans cette categorie ...
	</div>
	{/if}
{/if}
<!-- Pagination -->
<div class="pagination">{$Pagination->render()}</div>
{/strip}