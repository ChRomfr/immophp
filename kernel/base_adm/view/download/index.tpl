
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Telechargement}<li>
</ul>

<div class="well">
	<div class="pull-right">
		<a href="{$Helper->getLinkAdm('download/add')}" title="New download"><i class="icon-plus"></i></a>
	</div>
	<h4>{$lang.Telechargement}</h4>
	<div class="clearfix"></div>
	<table class="table table-bordered table-striped table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>{$lang.Nom}</th>
				<th>{$lang.Categorie}</th>
				<th>{$lang.Action}</th>
			</tr>
		</thead>
		<tbody>
			{foreach $downloads as $download}
			<tr>
				<td>{$download.id}</td>
				<td>{$download.name}</td>
				<td>
					{foreach $download.categories_parent as $row}
					{$row.name} >> 
					{/foreach}
					{$download.categorie}
				</td>
				<td style="text-align:center">
					<a href="{$Helper->getLinkAdm("download/edit/{$download.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:deleteDownload({$download.id});" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>
</div><!-- /well -->
{/strip}
<script type="text/javascript">
<!--
function deleteDownload(id){
	if( confirm('{$lang.Confirm_suppression_telechargement|html_entity_decode|utf8_encode} ?') ){
		window.location.href='{$Helper->getLinkAdm("download/delete/")}'+id;
	}
}
//-->
</script>