<!--
base_adm/link/add.tpl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>Liens<li>
</ul>

<div class="well">
	<div class="pull-right">
		<a href="{$Helper->getLinkAdm('link/add')}" title="New link"><i class="icon-plus"></i></a>
	</div>
	<h4>Liens</h4>
	<div class="clearfix"></div>
	<table class="table table-bordered table-striped table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>{$lang.Nom}</th>
				<th>Url</th>
				<th>{$lang.Categorie}</th>
				<th>{$lang.Action}</th>
			</tr>
		</thead>
		<tbody>
			{foreach $links as $link}
			<tr>
				<td>{$link.id}</td>
				<td>{$link.name}</td>
				<td>{$link.url}</td>
				<td>
					{foreach $link.categories_parent as $row}
					{$row.name} >> 
					{/foreach}
					{$link.categorie}
				</td>
				<td style="text-align:center">
					<a href="{$Helper->getLinkAdm("link/edit/{$link.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:deleteLink({$link.id});" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>
</div><!-- /well -->
{/strip}
<script type="text/javascript">
<!--
function deleteLink(id){
	if( confirm('Etes vous sur de vouloir supprimer ce lien de la base ?') ){
		window.location.href='{$Helper->getLinkAdm("link/delete/")}'+id;
	}
}
//-->
</script>