<!--
	base_adm/view/annuaire/index.pl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>Annuaire<li>
</ul>

<div class="well">
	<h4>Annuaire</h4>

	<table class="table table-bordered table-striped table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>Nom</th>
				<th>Url</th>
				<th>Categorie</th>
				<th>Status</th>
				<th>Action</th>
		</thead>
		<tbody>
			{foreach $Sites as $Site}
			<tr>
				<td>{$Site.id}</td>
				<td>{$Site.name}</td>
				<td>{$Site.url}</td>
				<td>
					{foreach $Site.categories_parent as $row}
					{$row.name} >> 
					{/foreach}
					{$Site.categorie}
				</td>
				<td>{$Site.status}</td>
				<td style="text-align:center;">
					<a href="{$Helper->getLinkAdm("annuaire/detail/{$Site.id}")}" title=""><i class="icon-pencil"></i></a>&nbsp;&nbsp;
					<a href="javascript:deleteSite({$Site.id});" title=""><i class="icon-trash"></i></a>
				</td>
			{/foreach}
		</tbody>
	</table>
	<div class="pull-right">
		<a href="{$Helper->getLinkAdm("annuaire?param[status]=new")}" title="" class="btn">Nouveau</a>
		&nbsp;
		<a href="{$Helper->getLinkAdm("annuaire?param[status]=wait")}" title="" class="btn">En attente</a>
		{if isset($smarty.get.param)}
		&nbsp;
		<a href="{$Helper->getLinkAdm("annuaire")}" title="" class="btn">Tous</a>
		{/if}
	</div>
	<div class="clearfix"></div>
	<div class="pagination">{$Pagination->render()}</div>
</div>
{/strip}
<script type="text/javascript">
<!--
function deleteSite(id){
	if(confirm('Etes vous sur de vouloir supprimé ce site ?')){
		window.location.href = '{$Helper->getLinkAdm("annuaire/delete/'+ id +'")}';
	}
}
//-->
</script>