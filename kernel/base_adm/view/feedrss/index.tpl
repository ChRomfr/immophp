{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>Gestionnaire de flux Rss<li>
</ul>

<div class="well">

	<div class="fright">
		<a href="{$Helper->getLinkAdm("feedRss/add")}" title=""><i class="icon-plus"></i></a>
	</div>
	<h4>Gestionnaire de flux Rss</h4>
	<div class="clear"></div>

	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>Site</th>
				<th>Adresse</th>
				<th>Actif</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $Flux as $Row}
			<tr>
				<td>{$Row.id}</td>
				<td>{$Row.name}</td>
				<td>{$Row.link}</td>
				<td>
					{if $Row.actif == 1}
					<span class="label label-success">Oui</span>
					{else}
					<span class="label">Non</span>
					{/if}
				</td>
				<td>
					<a href="{$Helper->getLinkAdm("feedRss/edit/{$Row.id}")}" title=""><i class="icon-pencil"></i></a>
					&nbsp;&nbsp;&nbsp;
					<a href="javascript:deleteLink({$Row.id});" title=""><i class="icon-trash"></i></a>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>
</div>
{/strip}
<script>
function deleteLink(id){
	if( confirm('Etes vous sur de vouloir supprimer ce flux ?') ){
		window.location.href = '{$Helper->getLinkAdm("feedRss/delete/'+ id +'")}';
	}
}
</script>