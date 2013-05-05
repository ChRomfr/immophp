{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Blok}</li>
</ul>

<div class="well">

<div class="fright">
    <a href="{$Helper->getLinkAdm("blok/add")}" title="{$lang.Ajouter}"><i class="icon-plus"></i></a>
</div>

<h4>{$lang.Blok}</h4>

<div class="clear"></div>

<table class="table table-bordered table-striped table-condensed">
	<thead>
		<tr>
			<th>#</th>
			<th>{$lang.Blok}</th>
			<th>{$lang.Type}</th>
			<th>{$lang.Position}</th>
			<th>{$lang.Ordre}</th>
			<th>{$lang.Visible}</th>
			<th>{$lang.Action}</th>
		</tr>
	</thead>
	<tbody>
		{foreach $bloks as $blok}
		<tr>
			<td>{$blok.id}</td>
			<td>{$blok.name}</td>
			<td>{$blok.type}</td>
			<td>{$blok.position}</td>
			<td>{$blok.ordre}</td>
			<td style="text-align: center;">
				{if $blok.visible == 1}
				<span class="label label-success">{$lang.Oui}</span>
				{else}
				<span class="label">{$lang.Non}</span>
				{/if}
			</td>
			<td style="text-align:center">
				<a href="{$Helper->getLinkAdm("blok/edit/{$blok.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>&nbsp;&nbsp;&nbsp;
				{if $blok.type == 'HTML' || $blok.type == 'MENU' || $blok.type == 'RSS' || $blok.type == 'ADDON'}
				<a href="javascript:deleteBlok({$blok.id});" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
				{/if}
			</td>
		</tr>
		{/foreach}
	</tbody>
</table>
</div>	
{/strip}
<script type="text/javascript">
<!--
function deleteBlok(id){
	if( confirm('{$lang.Confirm_suppression_blok} ?') ){
		window.location.href='{$Helper->getLinkAdm("blok/delete/")}'+id;
	}
}
//-->
</script>