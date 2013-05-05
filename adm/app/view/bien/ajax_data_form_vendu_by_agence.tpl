{strip}
<!-- Collaborateur -->
<dl>
	<dt><label for="vendu_by">Collaborateur :</label></dt>
	<dd>
		<select name="bien[vendu_by]">
			<option></option>
			{foreach $Colabs as $Row}
			<option value="{$Row.id}">{$Row.identifiant}</option>
			{/foreach}
		</select>
	</dd>
</dl>

<!-- Prospect -->
<dl>
	<dt><label for="acheteur_id">{$lang.Prospect} :</label></dt>
	<dd>
		<select name="bien[acheteur_id]" class="chzn-select">
			<option value=""></option>
			{foreach $Prospects as $Row}
			<option value="{$Row.id}">{$Row.nom} {$Row.prenom}</option>
			{/foreach}
		</select>
	</dd>
</dl>

<!-- Date de la vente -->
<dl>
	<dt><label for="date_vente">{$lang.Date} :</label></dt>
	<dd><input type="text" name="date_vente" id="date_vente" required class="validate[required,custom[date]] input-small"/></dd>
</dl>

<!-- Prix de la vente -->
<dl>
	<dt><label for="prix_vente">{$lang.Prix_de_vente} :</label></dt>
	<dd>
		<div class="input-append">
			<input type="text" name="prix_vente" id="prix_vente" class="input-small"/>
			<span class="add-on">€</span>
		</div>
	</dd>
</dl>

<!-- Montant des frais agences -->
<dl>
	<dt><label for="prix_vente">{$lang.Montant_frais_agence} :</label></dt>
	<dd>
		<div class="input-append">
			<input type="text" name="montant_frais_agence" id="montant_frais_agence" class="input-small"/>
			<span class="add-on">€</span>
		</div>
	</dd>
</dl>

<!-- Montant commission vendeur -->
<dl>
	<dt><label for="prix_vente">{$lang.Montant_commission_vendeur} :</label></dt>
	<dd>
		<div class="input-append">
			<input type="text" name="montant_com_vendeur" id="montant_com_vendeur" class="input-small"/>
			<span class="add-on">€</span>
		</div>
	</dd>
</dl>

<!-- BOUTON DE SOUMISSION -->
<div class="center">
	<input type="submit" value="{$lang.Enregistrer}" class="btn btn-primary" />
</div>

{/strip}
<!-- JS SPECIFIQUE -->
<script type="text/javascript">
<!--
$(function() {
	$( "#date_vente" ).datepicker({ dateFormat: 'dd/mm/yy', changeMonth:true, changeYear:true, showButtonPanel: true });
});
$('#date_vente').mask("99/99/9999");
$(".chzn-select").chosen();
-->
</script>