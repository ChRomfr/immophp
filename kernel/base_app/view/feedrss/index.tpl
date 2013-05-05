<ul class="breadcrumb">
	<li><a href="{$Helper->getLink('index')}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	{if isset($smarty.get.cid)}
	<li><a href="{$Helper->getLink('feedRss')}" title="Fil d actualite">Fil d'actualité</a><span class="divider">/</span></li>
	{else}
	<li>Fil d'actualité</li>
	{/if}
	{if isset($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("feedRss/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
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
				<a href="{$Helper->getLink("feedRss/index?cid={$Categorie.id}")}" title="{$Categorie.name}"><strong>{$Categorie.name}</strong></a><br/>
				{$Categorie.description}
			</div>
			<div style="clear:both"></div>
		</div>
		{if $smarty.foreach.lcat.iteration%2 == 0}<div class="clear"></div>{/if}
	{/foreach}
	<div class="clear"></div>
</div>
{/if}

{if isset($smarty.get.cid)}
	<h4>Fil d'actualité : {$Categorie.name}</h4>
{else}
	<h4>Tous les fils d'actualités</h4>
{/if}

{foreach $Items as $Row}
<div class="well">
	<h4>{$Row.title}</h4>
	{$Row.description}
	<div class="clear"></div>
	<hr/>
	<div class="fright">
		<a href="{$Row.link}" target="_blank" alt="{$Row.source}">{$Row.source}</a>
	</div>
</div>
{/foreach}
<div class="pagination">{$Pagination->render()}</div>
<script type="text/javascript">
<!--
(function($){
$.get(
    '{$Helper->getLink("feedRss/burn")}', {literal}
    {nohtml:'nohtml'},
    function(data){        
    })
    {/literal}
})(jQuery);
//-->
</script>