<ul class="breadcrumb">
	<li><a href="{getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{getLinkAdm('utilisateur/index')}" title="{$lang.Utilisateurs}">{$lang.Utilisateurs}</a><span class="divider">/</span></li>
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

			<div class="control-group">
			<label class="control-label" class="control-label">{$lang.Agence} :</label>
			<div class="controls">
				<select name="user[agence_id]" id="agence_id">
					<option></option>
					{foreach $Agences as $Row}
					<option value="{$Row.id}" {if $user.agence_id == $Row.id}selected="selected"{/if}>{$Row.nom}</option>
					{/foreach}
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

<div class="well">
	<h4>{$lang.Infos}</h4>
	<dl class="dl-horizontal">
		<dt>{$lang.Enregistrer_le} :</dt>
		<dd>{$user.register_on|date_format:$config.format_date}</dd>
	</dl>
	<dl class="dl-horizontal">
		<dt>{$lang.Derniere_visite} :</dt>
		<dd>{$user.last_connexion|date_format:$config.format_date}</dd>
	</dl>
</div><!-- /well -->