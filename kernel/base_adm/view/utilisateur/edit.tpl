{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('utilisateur/index')}" title="{$lang.Utilisateurs}">{$lang.Utilisateurs}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<div class="well">
	<form method="post" class="form-horizontal">
		<fielset>
			<legend>{$lang.Edition}</legend>

			<div class="control-group">
				<label class="control-label">{$lang.Identifiant} :</label>
				<div class="controls">{$user.identifiant}</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="isAdmin">{$lang.Administrateur} :</label>
				<div class="controls">
					<select name="user[isAdmin]" id="isAdmin">
						<option value="0" {if $user.isAdmin == 0}selected="selected"{/if}>{$lang.Non}</option>
						<option value="1" {if $user.isAdmin == 1}selected="selected"{/if}>{$lang.Oui} - 1</option>
						<option value="2" {if $user.isAdmin == 2}selected="selected"{/if}>{$lang.Oui} - 2</option>
						<option value="3" {if $user.isAdmin == 3}selected="selected"{/if}>{$lang.Oui} - 3</option>
						<option value="4" {if $user.isAdmin == 4}selected="selected"{/if}>{$lang.Oui} - 4</option>
						<option value="5" {if $user.isAdmin == 5}selected="selected"{/if}>{$lang.Oui} - 5</option>
						<option value="6" {if $user.isAdmin == 6}selected="selected"{/if}>{$lang.Oui} - 6</option>
						<option value="7" {if $user.isAdmin == 7}selected="selected"{/if}>{$lang.Oui} - 7</option>
						<option value="8" {if $user.isAdmin == 8}selected="selected"{/if}>{$lang.Oui} - 8</option>
						<option value="9" {if $user.isAdmin == 9}selected="selected"{/if}>{$lang.Oui} - 9</option>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="actif">{$lang.Actif} :</label>
				<div class="controls">
					<select name="user[actif]">
						<option value="1" {if $user.actif == 1}selected="selected"{/if}>{$lang.Oui}</option>
						<option value="0" {if $user.actif == 0}selected="selected"{/if}>{$lang.Non}</option>
					</select>
				</div>
			</div>


		<div class="form-actions" style="text-align:center">
				<input type="hidden" name="token" value="{$smarty.session.token}" />
				<input type="hidden" name="user[id]" value="{$user.id}" />
				<button type="submit" name="send" class="btn btn-primary">{$lang.Enregistrer}</button>
			</div>

		</fielset>
	</form>
</div><!-- /well -->

<!-- Groupes -->
<div class="well">
	<h4>{$lang.Groupes}</h4>
	<ul class="unstyled">
		{foreach $user->groupes as $row}
		<li>{$row.name}</li>
		{/foreach}
	</ul>
	<hr/>
	<form method="post" action="{$Helper->getLinkAdm("utilisateur/useraddingroupe/{$user->id}")}" class="form-inline">
		<label for="groupe_id">{$lang.Groupe} :</label>&nbsp;
		<select name="groupe[groupe_id]" id="groupe_id" class="chzn-select">
			<option><option>
			{foreach $groupes as $row}
			<option value="{$row.id}">{$row.name}</option>
			{/foreach}
		</select>&nbsp;
		<button type="submit" class="btn btn-primary">{$lang.Ajouter}</button>
	</form>
	<hr/>
	<form method="post" action="{$Helper->getLinkAdm("utilisateur/userremovegroupe/{$user->id}")}" class="form-inline">
		<label for="gname">{$lang.Groupe} :</label>&nbsp;
		<select name="groupe[groupe_id]" id="gname" class="chzn-select">
			<option><option>
			{foreach $user->groupes as $row}
			<option value="{$row.id}">{$row.name}</option>
			{/foreach}
		</select>&nbsp;
		<button type="submit" class="btn btn-primary">{$lang.Supprimer}</button>
	</form>
</div>

<!-- Infos -->
<div class="well">
	<h4>{$lang.Infos}</h4>
	<dl class="dl-horizontal">
		<dt>{$lang.Enregistrer_le} :</dt>
		<dd>{$user.register_on|date_format:$config.format_date}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>{$lang.Derniere_visite} :</dt>
		<dd>{if $user->last_connexion != 0}{$user.last_connexion|date_format:$config.format_date}{/if}</dd>
	</dl>
</div><!-- /well -->
{/strip}
<script type="text/javascript">
<!--
$(".chzn-select").chosen();
//-->
</script>