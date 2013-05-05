{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Page}</li>
</ul>

<div class="well">
	<div class="fright">
		<a href="{$Helper->getLinkAdm("page/add")}" title=""><i class="icon-plus"></i></a>
	</div>
	<h4>{$lang.Page}</h4>
	<div class="clear"></div>

	<table class="table table-bordered table-striped table-condensed">
		<thead>
			<tr>
				<th>{$lang.Page}</th>
				<th>{$lang.Auteur}</th>
				<th>{$lang.Url}</th>
				<th>{$lang.Action}</th>
			</tr>
		</thead>
		<tbody>
			{foreach $pages as $page}
			<tr>
				<td>{$page.titre}</td>
				<td>{$page.identifiant}</td>
				<td><a href="{$Helper->getLink("page/index/{$page.id}")}" target="_blank">{$Helper->getLink("page/index/{$page.id}")}</a></td>
				<td style="text-align:center">
					<a href="{$Helper->getLinkAdm("page/edit/{$page.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:deletePage({$page.id});" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>

</div><!-- /well -->
{/strip}
<script type="text/javascript">
<!--
function deletePage(id){
	if( confirm('{$lang.Confirm_suppression_page} ?') ){
		window.location.href='{$Helper->getLinkAdm("page/delete/")}'+id;
	}
}
//-->
</script>