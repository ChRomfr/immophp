<ul class="breadcrumb">
	<li><a href="{$Helper->getLink('index')}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	{if isset($smarty.get.cid)}
	<li><a href="{$Helper->getLink('article')}" title="{$config.article_nom}">{$config.article_nom}</a><span class="divider">/</span></li>
	{else}
	<li>{$config.article_nom}</li>
	{/if}
	{if isset($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("article/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
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
				<a href="{$Helper->getLink("article/index?cid={$Categorie.id}")}" title="{$Categorie.name}"><strong>{$Categorie.name}</strong></a><br/>
				{$Categorie.description}
			</div>
			<div style="clear:both"></div>
		</div>
		{if $smarty.foreach.lcat.iteration%2 == 0}<div class="clear"></div>{/if}
	{/foreach}
	<div class="clear"></div>
</div>
{/if}

{if $Articles > 0}
	{foreach $Articles as $Article}
		<div class="well">			
			<div style="float:left; width:85%;">
				<h4><a href="{$Helper->getLink("article/read/{$Article.id}")}" title="{$Article.title}">{$Article.title}</a></h4>			
				<div>{$Article.article|strip_tags|html_entity_decode|truncate:200}</div>
			</div>	
			{if !empty($Article.image)}
			<div style="float:left"><img src="{$config.url}{$config.url_dir}web/upload/article/{$Article.id}/{$Article.image}" alt="" style="width:100px;"/></div>
			{/if}
			<div class="clear"></div>	
			<hr/>
			<div><i class="icon-user"></i>&nbsp;{$Article.utilisateur}&nbsp;&nbsp;<i class="icon-calendar"></i>{$Article.creat_on|date_format:$config.format_date_day}</div>
			{if !empty($Article.fichier) || $Article.video == 1} 
			<div class="fright">
				{if !empty($Article.fichier) }<i class="icon-download"></i>&nbsp;&nbsp;&nbsp;{/if}
				{if $Article.video == 1}<i class="icon-film"></i>{/if}
			</div>
			{/if}
		</div>
	{/foreach}
{else}
<div class="alert alert-block">
	Aucun article dans cette categorie ...
</div>
{/if}