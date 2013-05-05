<!--
	base_app/utilisateur/profil.tpl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("utilisateur")}" title="{$lang.Profil}">{$lang.Profil}</a><span class="divider">/</span></li>
	<li>Edition</li>
</ul>

<form method="post" action="#" id="formProfil" class="form-horizontal well">
	
	<fieldset>
		<legend>Informations</legend>

		<div class="control-group">
			<label class="control-label">Prénom :</label>
			<div class="controls">
				<input type="text" name="user[prenom]" id="prenom" value="{$smarty.session.utilisateur.prenom}" />
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">Date de naissance :</label>
			<div class="controls">
				<input type="text" name="user[date_naissance]" id="date_naissance" value="{$smarty.session.utilisateur.date_naissance}"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">Sexe :</label>
			<div class="controls">
				<select name="user[sexe]">
					<option value=""></option>
					<option value="h" {if $smarty.session.utilisateur.sexe == 'h'}selected="selected"{/if}>Homme</option>
					<option value="f" {if $smarty.session.utilisateur.sexe == 'f'}selected="selected"{/if}>Femme</option>
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">Site internet :</label>
			<div class="controls">
				<input type="url" name="user[url]" id="url" value="{$smarty.session.utilisateur.url}"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">Signature :</label>
			<div class="controls">
				<textarea  name="user[signature]" id="signature" class="input-xxlarge" rows="5">{$smarty.session.utilisateur.signature}</textarea>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">Facebook :</label>
			<div class="controls">
				<input type="url" name="user[facebook]" id="facebook" value="{$smarty.session.utilisateur.facebook}"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">Twitter :</label>
			<div class="controls">
				<input type="url" name="user[tweeter]" id="tweeter" value="{$smarty.session.utilisateur.tweeter}"/>
			</div>
		</div>

	</fieldset>


	<fieldset>
		<legend>Localisation</legend>
		<div class="control-group">
			<label class="control-label">Ville :</label>
			<div class="controls">
				<input type="text" name="user[ville]" id="ville" value="{$smarty.session.utilisateur.ville}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">Pays :</label>
			<div class="controls">
				<input type="text" name="user[pays]" id="pays" value="{$smarty.session.utilisateur.pays}"/>
			</div>
		</div>
	</fieldset>

	<fieldset>
		<legend>Preferences</legend>	
		
		<div class="control-group">
			<label class="control-label">Mailing :</label>
			<div class="controls">
				<select name="user[mailing]">
					<option value="0">Non</option>
					<option value="1" {if $smarty.session.utilisateur.mailing == 1}selected="selected"{/if}>Oui</option>
				</select>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">Newsletter :</label>
			<div class="controls">
				<select name="user[newsletter]">
					<option value="0">Non</option>
					<option value="1" {if $smarty.session.utilisateur.newsletter == 1}selected="selected"{/if}>Oui</option>
				</select>
			</div>
		</div>

	</fieldset>
	
	<div class="form-actions">
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</div>

</form>
{/strip}
<script type="text/javascript">
<!--
	$(function() {
		$( "#date_naissance" ).datepicker({ dateFormat: 'yy-mm-dd', changeMonth:true, changeYear:true, showButtonPanel: true });
	});
//-->
</script>