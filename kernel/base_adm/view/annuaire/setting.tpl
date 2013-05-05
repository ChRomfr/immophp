<!--
	base_adm/view/annuaire/setting.pl
-->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('annuaire')}" title="Annuaire">Annuaire</a><span class="divider">/</span></li>
	<li>{$lang.Preferences}</li>
</ul>

<form method="post" action="#" id="AnnuaireSettingForm" class="form-horizontal well">
	<fieldset>
		<legend>{$lang.Preferences}</legend>

		<div class="control-group">
			<label for="annuaire_submit_onlymember" class="control-label">Annuaire ouvert à </label>
			<div class="controls">
				<select name="config[annuaire_submit_onlymember]" id="annuaire_submit_onlymember">
					<option value="0" {if $config.annuaire_submit_onlymember == 0}selected="selected"{/if}>Tout le monde</option>
					<option value="1" {if $config.annuaire_submit_onlymember == 1}selected="selected"{/if}>Aux membres</option>
				</select>
				<span class="help-block">Cette option determine qui peut proposer un site dans l'annuaire</span>
			</div>
		</div>
		
		<div class="control-group">
			<label for="annuaire_site_rss" class="control-label">Flux RSS </label>
			<div class="controls">
				<select name="config[annuaire_site_rss]" id="annuaire_site_rss">
					<option value="0" {if $config.annuaire_site_rss == 0}selected="selected"{/if}>{$lang.Non}</option>
					<option value="1" {if $config.annuaire_site_rss == 1}selected="selected"{/if}>{$lang.Oui}</option>
				</select>
				<span class="help-block">Cette option permet de soumettre deux flux rss</span>
			</div>
		</div>
		
		<div class="control-group">
			<label for="annuaire_site_keyword" class="control-label">Mot clé :</label>
			<div class="controls">
				<select name="config[annuaire_site_keyword]" id="annuaire_site_keyword">
					<option value="0" {if $config.annuaire_site_keyword == 0}selected="selected"{/if}>{$lang.Non}</option>
					<option value="1" {if $config.annuaire_site_keyword == 1}selected="selected"{/if}>{$lang.Oui}</option>
				</select>
				<span class="help-block">Cette option permet de soumettre des mots clés</span>
			</div>
		</div>

		<div class="control-group">
			<label for="annuaire_site_backlink_required" class="control-label">Lien de retour obligatoire :</label>
			<div class="controls">
				<select name="config[annuaire_site_backlink_required]" id="annuaire_site_backlink_required">
					<option value="0" {if $config.annuaire_site_backlink_required == 0}selected="selected"{/if}>{$lang.Non}</option>
					<option value="1" {if $config.annuaire_site_backlink_required == 1}selected="selected"{/if}>{$lang.Oui}</option>
				</select>
			</div>
		</div>
		
		<div class="control-group">
			<label for="annuaire_pub_afert_first" class="control-label">Publicité :</label>
			<div class="controls">
				<select name="config[annuaire_pub_afert_first]" id="annuaire_pub_afert_first">
					<option value="0" {if $config.annuaire_pub_afert_first == 0}selected="selected"{/if}>{$lang.Non}</option>
					<option value="1" {if $config.annuaire_pub_afert_first == 1}selected="selected"{/if}>{$lang.Oui}</option>
				</select>
			</div>
			<span class="help-block">Affiche un bloc de pub après le 1er site</span>
		</div>

		<div class="control-group">
			<label for="annuaire_code_pub" class="control-label">Code publicité</label>
			<div class="controls">
				<textarea name="config[annuaire_code_pub]" id="annuaire_code_pub" class="input-xxlarge" rows="4">{$config.annuaire_code_pub}</textarea>
			</div>
		</div>
		

		<div class="control-group">
			<label for="annuaire_code_backlink" class="control-label">Code html des liens de retours :</label>
			<div class="controls">
				<textarea name="config[annuaire_code_backlink]" id="annuaire_code_backlink" class="input-xxlarge" rows="4">{$config.annuaire_code_backlink}</textarea>
			</div>
		</div>

		<div class="control-group">
			<label for="annuaire_regle_soumission" id="annuaire_regle_soumission" class="control-label">Charte de l'annuaire :</label>
			<div class="controls">
				<textarea name="config[annuaire_regle_soumission]" id="annuaire_regle_soumission" class="input-xxlarge" rows="4">{$config.annuaire_regle_soumission}</textarea>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="annuaire_min_length_resume">Caractères minimum pour le resumé :</label>
			<div class="controls">
				<input type="text" name="config[annuaire_min_length_resume]" id="annuaire_min_length_resume" value="{$config.annuaire_min_length_resume}" class="input-small" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="annuaire_min_length_description">Caractères minimum pour la description :</label>
			<div class="controls">
				<input type="text" name="config[annuaire_min_length_description]" id="annuaire_min_length_description" value="{$config.annuaire_min_length_description}" class="input-small" />
			</div>
		</div>

	</fieldset>

	<div class="form-actions">
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</div>
</form>