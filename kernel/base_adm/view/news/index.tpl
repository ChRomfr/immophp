<!--
	BASE_ADM/VIEW/NEWS/INDEX.TPL
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.News}</li>
</ul>

<div class="well">

	<div style="float:right;">
		<a href="{$Helper->getLinkAdm("news/add")}" title="{$lang.Ajouter}"><i class="icon-plus"></i></a>
	</div>

	<h4>{$lang.News}</h4>

	<div class="clear"></div>

<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<td>#</td>
			<td>{$lang.Titre}</td>
			<td>{$lang.Categorie}</td>
			<td>{$lang.Auteur}</td>
			<td>{$lang.Poste_le}</td>
			<td>{$lang.Action}</td>			
		</tr>
	</thead>
	<tbody>
		{foreach $news as $new}
		<tr>
			<td>{$new.id}</td>
			<td>{$new.sujet}</td>
			<td>
				{foreach $new.categories_parent as $parent}{$parent.name} > {/foreach}				
				{$new.categorie}
			</td>
			<td>{$new.identifiant}</td>
			<td>{$new.post_on|date_format:$config.format_date}</td>
			<td class="center">
				<a href="{$Helper->getLinkAdm("news/edit/{$new.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>&nbsp;
				<a href="javascript:deleteNews({$new.id});" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
			</td>
		</tr>
		{/foreach}
	</tbody>
</table>
{if !empty($pagination)}
<div class="pagination">{$pagination}</div>
{/if}
</div><!-- /well -->
{/strip}

<script type="text/javascript">
<!--
function deleteNews(id){
	if( confirm('{$lang.Confirm_suppression_news} ?') ){
		window.location.href='{$Helper->getLinkAdm("news/delete/")}'+id;
	}
}
//-->
</script>	