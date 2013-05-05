<!-- 
	base_app/view/link/detail.tpl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("link")}" title="Liens">Liens</a><span class="divider">/</span></li>
	{if isset($Parents) && !empty($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("link/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
		{/foreach}
	{/if}
	
	{if !empty($Link->categorie_id)}
		<li><a href="{$Helper->getLink("link/index?cid={$Link->categorie_id}")}" title="{$Link->categorie}">{$Link->categorie}</a><span class="divider">/</span></li>
	{/if}
	<li>{$Link->name}</li>
</ul>

<div class="well">

	<h4>{$Link->name}</h4>
	
	<table class="table">

		<tr>
			<td>
				<!-- apersite -->
				<img src="http://www.apercite.fr/api/apercite/240x180/oui/oui/{$Link->url}" alt="{$Link->name}" />
			</td>
			<td>
				{$Link->description}
			</td>
		</tr>

		<tr>
			<td>Ajouté le :</td>
			<td>{$Link->add_on}</td>
		</tr>

		<tr>
			<td colspan="2" style="text-align:center">
				<a href="{$Link->url}" title="{$Link->name}" target="_blank" class="btn">Visiter</a>
			</td>
		</tr>
	</table>

</div>
{/strip}