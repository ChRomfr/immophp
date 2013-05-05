<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('utilisateur')}" title="{$lang.Utilisateurs}">{$lang.Utilisateurs}</a><span class="divider">/</span></li>
	<li>{$lang.Groupes}</li>
</ul>

<div class="well">

	<div class="pull-right">
		<a href="{$Helper->getLinkAdm("utilisateur/groupeadd")}" title="{$lang.Ajouter_un_groupe}"><i class="icon icon-plus"></i></a>
	</div>

	<h4>{$lang.Groupes}</h4>

	<div class="clearfix"></div>

	<table class="table table-striped">
		<thead>
			<th>#</th>
			<th>{$lang.Groupe}</th>
			<th>{$lang.Description}</th>
			<th></td>
		</thead>
		<tbody>
		{foreach $Groupes as $groupe}
			{if $groupe.systeme == 0}
			<tr>
				<td>{$groupe.id}</td>
				<td>{$groupe.name}</td>
				<td>{$groupe.description|nl2br}</td>
				<td>
					<a href="{$Helper->getLinkAdm("utilisateur/groupeedit/{$groupe.id}")}" title="Edit"><i class="icon icon-edit"></i></a>
					&nbsp;&nbsp;
					<a href="javascript:deletegroupe({$groupe.id});" title="Delete"><i class="icon icon-trash"></i></a>
				</td>
			</tr>
			{/if}
		{/foreach}
		</tbody>
	</table>

</div>
<script type="text/javascript">
<!--
function deletegroupe(id){
	if(confirm('{$lang.Confirm_suppression_groupe} ?')){ 
		window.location.href='{$Helper->getLinkAdm("utilisateur/groupedelete/'+id+'")}';
	}
}
//-->
</script>