{strip}

<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Utilisateurs}</li>
</ul>

<div class="well">

	<div class="pull-right">
		<a href="{$Helper->getLinkAdm("utilisateur/add")}" title=""><i class="icon-plus"></i></a>
	</div>
	
	<h4>{$lang.Utilisateurs}</h4>

	<div class="clearfix"></div>

	<table class="table table-bordered table-striped table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>{$lang.Identifiant}</th>
				<th>{$lang.Administrateur}</th>
				<th>{$lang.Actif}</td>
				<th>{$lang.Email}</th>
				<th>{$lang.Action}</th>
			</tr>
		</thead>
		<tbody>
		{foreach $Utilisateurs as $user name=loop}
			<tr>
				<td>{$smarty.foreach.loop.iteration}</td>
				<td>{$user.identifiant}</td>
				<td>
					{if $user.isAdmin > 0}<span style="color:green">{$lang.Oui} ({$user.isAdmin}){else}<span style="color:red">{$lang.Non}{/if}</span>
				</td>
				<td>
					{if $user.actif == 1}<span style="color:green">{$lang.Oui}{else}<span style="color:red">{$lang.Non}{/if}</span>
				</td>
				<td>{$user.email}</td>
				<td style="text-align:center;">
					<a href="{$Helper->getLinkAdm("utilisateur/edit/{$user.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>&nbsp;
					<a href="javascript:deleteUtilisateur({$user.id});" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
				</td>
			</tr>
		{/foreach}
		</tbody>
	</table>
	<div class="pagination">{$Pagination->render()}</div>
</div><!-- /well -->
{/strip}
<script type="text/javascript">
<!--
function deleteUtilisateur(id){
	if( confirm('{$lang.Confirm_suppression_utilisateur} ?') ){
		window.location.href='{$Helper->getLinkAdm("utilisateur/delete/")}'+id;
	}
}
//-->
</script>