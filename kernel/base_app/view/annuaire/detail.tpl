<!-- 
	base_app/view/annuaire/detail.tpl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("annuaire")}" title="Annuaire">Annuaire</a><span class="divider">/</span></li>
	{if isset($Parents) && !empty($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("Annuaire/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
		{/foreach}
	{/if}
	
	{if !empty($Site->categorie_id)}
		<li><a href="{$Helper->getLink("Annuaire/index?cid={$Site->categorie_id}")}" title="{$Site->categorie}">{$Site->categorie}</a><span class="divider">/</span></li>
	{/if}
	<li>{$Site->name}</li>
</ul>

<div class="well">

	<h4>{$Site->name}</h4>
	
	<table class="table">

		<tr>
			<td>
				<!-- apersite -->
				<img src="http://www.apercite.fr/api/apercite/240x180/oui/oui/{$Site->url}" alt="{$Site->name}" />
			</td>
			<td>
				{$Site->description}
			</td>
		</tr>

		<tr>
			<td>Adresse :</td>
			<td><a href="{$Site->url}" title="{$Site->name}" target="_blank">{$Site->url}</a></td>
		</tr>

		<tr>
			<td>Ajouté le :</td>
			<td>{$Site->add_on}</td>
		</tr>

		{if !empty($Site->facebook) || !empty($Site->twitter) || !empty($Site->googleplus)}
		<tr>
			<td></td>
			<td>
				{if !empty($Site->facebook)}<a href="{$Site->facebook}" target="_blank"><i class="icon-facebook-sign icon-large"></i></a>&nbsp;&nbsp;{/if}
				{if !empty($Site->twitter)}<a href="{$Site->twitter}" target="_blank"><i class="icon-twitter-sign icon-large"></i></a>&nbsp;&nbsp;{/if}
				{if !empty($Site->googleplus)}<a href="{$Site->googleplus}" target="_blank"><i class="icon-google-plus-sign icon-large"></i></a>&nbsp;&nbsp;{/if}
			</td>
		</tr>
		{/if}

		<tr>
			<td colspan="2" style="text-align:center">
				<a href="{$Site->url}" title="{$Site->name}" target="_blank" class="btn">Visiter</a>
			</td>
		</tr>
	</table>

	{if $config.annuaire_site_rss == 1}
	<table class="table">
		{if !empty($Site->flux_rss_1) || !empty($Site->flux_rss_2) }
		<tr>
			{if !empty($Site->flux_rss_1)}
			<td>
				<ul class="unstyled">
					{foreach $Flux1->find(10) as $item}
					<li><a href="{if isset($item->link)}{$item->link}{else}{$item->url}{/if}" title="" target="_blank"><small>{$item->title}</small></a></li>
					{/foreach}
				</ul>
			</td>
			{/if}

			{if !empty($Site->flux_rss_2)}
			<td>
				<ul class="unstyled">
					{foreach $Flux2->find(10) as $item}
					<li><a href="{if isset($item->link)}{$item->link}{else}{$item->url}{/if}" title="" target="_blank"><small>{$item->title}</small></a></li>
					{/foreach}
				</ul>
			</td>
			{/if}
		</tr>
		{/if}
	</table>
	{/if}

</div>
{/strip}