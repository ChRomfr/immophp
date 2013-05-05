{strip}
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="Administration">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Agences}</li>
</ul>

<div class="well">
	<h4>{$lang.Agences}</h4>
	<table class="table table-condensed table-striped table-bordered">
		<thead>
			<tr>
				<th>{$lang.Agence}</th>
				<th>{$lang.Ville}</th>
				<th>{$lang.Telephone}</th>
                <th>{$lang.Email}</th>
				<th></th>
			</tr>			
		</thead>
		<tbody>
			{foreach $Agences as $Row}
			<tr>
				<td>
					<a href="{getLinkAdm("agence/detail/{$Row.id}")}" title="">
					{$Row.nom}
					</a>
				</td>
				<td>{$Row.ville}</td>
				<td>{$Row.telephone}</td>
                <td>{$Row.email}</td>
                <td style="text-align: center">
                    <a href="{$Helper->getLinkAdm("agence/edit/{$Row.id}")}" title="{$lang.Edition}"><i class="icon icon-edit"></i></a>
                    &nbsp;&nbsp;
                    <a href="{getLinkAdm("agence/delete/{$Row.id}")}" title="{$lang.Supprimer}"><i class="icon icon-trash"></i></a>
                </td>
			</tr>
			{/foreach}
		</tbody>
	</table>
</div>
{/strip}