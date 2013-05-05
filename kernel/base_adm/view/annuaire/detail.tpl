<!--
	base_adm/view/annuaire/detail.pl
-->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('annuaire')}" title="Annuaire">Annuaire</a><span class="divider">/</span></li>
	<li>Detail : {$Site.name}</li>
</ul>

<div class="well">
	<form method="post" action="#">
	<h4>{$Site.name}</h4>
	<table class="table table-condensed">
		<tr>
			<td>Site :</td>
			<td>{$Site.name}</td>
		</tr>
		<tr>
			<td>Url :</td>
			<td>{$Site.url}</td>
		</tr>
		<tr>
			<td>Catégorie :</td>
			<td>
				{if isset($Site->categories_parent)}
					{foreach $Site->categories_parent as $Parent}
						{$Parent.name}&nbsp;&gt;&gt;&nbsp;
					{/foreach}
				{/if}
				{$Site->categorie}
			</td>
		</tr>
		<tr>
			<td>Resume :</td>
			<td>{$Site.resume|nl2br}</td>
		</tr>
		<tr>
			<td>Description :</td>
			<td>{$Site.description|nl2br}</td>
		</tr>
		
		{if $config.annuaire_site_rss == 1}
		 
			{if !empty($Site->flux_rss_1)}
			<!-- Flux 1 -->
			<tr>
				<td><i class="icon-rss icon-large"></i> :</td>
				<td><a href="{$Site->flux_rss_1}" target="_blank" title"">{$Site->flux_rss_1}</a></td>
			</tr>
			{/if}

			{if !empty($Site->flux_rss_2)}
			<!-- Flux 2 -->
			<tr>
				<td><i class="icon-rss icon-large"></i> :</td>
				<td><a href="{$Site->flux_rss_2}" target="_blank" title"">{$Site->flux_rss_2}</a></td>
			</tr>
			{/if}

		{/if}
		
		{if !empty($Site->facebook)}
		<!-- Facebook -->
		<tr>
			<td><i class="icon-facebook-sign icon-large"></i></td>
			<td><a href="{$Site->facebook}" target="_blank" title"">{$Site->facebook}</a></td>
		{/if}

		{if !empty($Site->twitter)}
		<!-- twitter -->
		<tr>
			<td><i class="icon-twitter-sign icon-large"></i></td>
			<td><a href="{$Site->twitter}" target="_blank" title"">{$Site->twitter}</a></td>
		{/if}

		{if !empty($Site->googleplus)}
		<!-- Google+ -->
		<tr>
			<td><i class="icon-google-plus-sign icon-large"></i></td>
			<td><a href="{$Site->googleplus}" target="_blank" title"">{$Site->googleplus}</a></td>
		{/if}

		<tr>
			<td>Lien de retour :</td>
			<td>{if empty($Site->backlink)}<span class="label label-important">Non</span>{else}{$Site->backlink}{/if}</td>
		</tr>

		<!-- Start Informations sur l utilisateur -->
		<tr>
			<td>Email :</td>
			<td>{$Site->email}</td>
		</tr>


		<!-- End informations sur l utilisateur -->

		<tr>
			<td>Status :</td>
			<td>
				<select name="site[status]" id="status">
					<option value="new" {if $Site.status == 'new'}selected="selected"{/if}>Nouveau</option>
					<option value="wait" {if $Site.status == 'wait'}selected="selected"{/if}>En attente</option>
					<option value="valid" {if $Site.status == 'valid'}selected="selected"{/if}>Valider</option>
					<option value="refused" {if $Site.status == 'refused'}selected="selected"{/if}>Refuser</option>
				</select>
			</td>
		</tr>

		<tr>
			<td>Raison refus :</td>
			<td>
				<textarea name="site[raison_refus]" id="raison_refus" class="input-xxlarge" rows="4">{$Site->raison_refus}</textarea>
			</td>
		</tr>

		<!-- Visible -->
		<tr>
			<td>Visible :</td>
			<td>
				<select name="site[visible]" id="visible">
					<option value="1" {if $Site->visible == 1}selected="selected"{/if}>{$lang.Oui}</option>
					<option value="0" {if $Site->visible == 0}selected="selected"{/if}>{$lang.Non}</option>
				</select>
			</td>
		</tr>

	</table>
	<div class="form-actions">
		<input type="hidden" name="site[id]" value="{$Site->id}" />
		<button type="submit" class="btn btn-primary">Enregistrer</button>

	</div>
</form>
</div>