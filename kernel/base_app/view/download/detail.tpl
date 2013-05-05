<!-- 
	base_app/view/download/detail.tpl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("download")}" title="{$lang.Telechargement}">{$lang.Telechargement}</a><span class="divider">/</span></li>
	{if isset($Parents) && !empty($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("download/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
		{/foreach}
	{/if}
	
	{if !empty($Download->categorie_id)}
		<li><a href="{$Helper->getLink("download/index?cid={$Download->categorie_id}")}" title="{$Download->categorie}">{$Download->categorie}</a><span class="divider">/</span></li>
	{/if}
	<li>{$Download->name}</li>
</ul>

<div class="well">

	<h4>{$Download->name}</h4>
	
	<table class="table">
		{if !empty($Download->apercu)}
		<tr>
			<td>Aperçu :</td>
			<td><a href="{$Download->apercu}" title="" class="fbimage"><img src="{$Download->apercu}" style="width:150px;"/></a></td>
		</tr>
		{/if}

		{if !empty($Download->description)}
		<tr>
			<td>Description :</td>
			<td>{$Download->description}</td>
		</tr>
		{/if}

		<tr>
			<td>Ajouté le :</td>
			<td>{$Download->add_on}</td>
		</tr>

		<tr>
			<td colspan="2" style="text-align:center;">
				{if $Download->download_for == 'all'}
				<button class="btn" onclick="downloadFile()">{$lang.Telecharger}</button>
				{else}
					{if $smarty.session.utilisateur.id == 'Visiteur'}
					<div class="alert">
						Téléchargement reserver aux utilisateurs enregistré.<br/>
						<a href="{$Helper->getLink("connexion")}" title="S identifiant">S'identifier</a>&nbsp;&nbsp;
						<a href="{$Helper->getLink("utilisateur/register")}" title="S'enregistrer">S'enregister</a>
					</div>
					{else}
					<button class="btn" onclick="downloadFile()">{$lang.Telecharger}</button>
					{/if}
				{/if}
			</td>
		</tr>
	</table>

</div>
{/strip}

<script>
$.get(
    '{$Helper->getLink("download/updateVue/{$Download->id}")}',{literal}
    {nohtml:'nohtml'},{/literal}
    function(data){}
);

{if $Download->download_for == 'all' || ($smarty.session.utilisateur.id != 'Visiteur' && $Download->download_for == 'member')}
function downloadFile(){

	$.get(
        '{$Helper->getLink("download/updateDownloaded/{$Download->id}")}',{literal}
        {nohtml:'nohtml'},{/literal}
        function(data){}
    );

	window.location.href = '{$Download->url}';
}
{/if}
</script>