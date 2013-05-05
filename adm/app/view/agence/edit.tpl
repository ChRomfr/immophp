<!-- AGENCE EDIT -->
{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{getLinkAdm("agence")}" title="{$lang.Agence}">{$lang.Agence}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>
<!-- FORMULAIRE -->
<form method="post" action="#" id="formAgenceEdit" enctype="multipart/form-data" class="form-horizontal well">
	<fieldset>
	<legend>{$lang.Edition_agence}</legend>
	
	<!-- Nom -->
	<div class="control-group">
		<label class="control-label" for="nom">{$lang.Agence} :</label>
		<div class="controls"><input type="text" name="agence[nom]" id="nom" required class="validate[required]" value="{$Agence.nom}" /></div>
	</div>
		
	<!-- Description -->
	<div class="control-group">
		<label class="control-label" for="description">{$lang.Description} :</label>
		<div class="controls"><textarea name="agence[description]" id="description" cols="50" rows="4">{$Agence.description}</textarea></div>
	</div>
		
	<!-- Adresse -->
	<div class="control-group">
		<label class="control-label" for="adresse">{$lang.Adresse} :</label>
		<div class="controls"><textarea name="agence[adresse]" id="adresse" cols="50" rows="4">{$Agence.adresse}</textarea></div>
	</div>
		
	<!-- Code postal -->
	<div class="control-group">
		<label class="control-label" for="code_postal">{$lang.Code_postal} :</label>
		<div class="controls"><input type="text" name="agence[code_postal]" id="code_postal" size="7" required class="validate[required]" value="{$Agence.code_postal}" /></div>
	</div>
	
	<!-- Ville -->
	<div class="control-group">
		<label class="control-label" for="ville">{$lang.Ville} :</label>
		<div class="controls"><input type="text" name="agence[ville]" id="ville" required class="validate[required]" value="{$Agence.ville}"/></div>
	</div>
		
	<!-- Pays -->
	<div class="control-group">
		<label class="control-label" for="pays">{$lang.Pays} :</label>
		<div class="controls"><input type="text" name="agence[pays]" id="pays" value="{$Agence.pays}" /></div>
	</div>
	
	<!-- TELEPHONE -->
	<div class="control-group">
		<label class="control-label" for="telephone">{$lang.Telephone} :</label>
		<div class="controls"><input type="text" name="agence[telephone]" id="telephone" value="{$Agence.telephone}"/></div>
	</div>
		
	<div class="control-group">
		<label class="control-label" for="fax">{$lang.Fax} :</label>
		<div class="controls"><input type="text" name="agence[fax]" id="fax" value="{$Agence.fax}" /></div>
	</div>
		
	<!-- EMAIL -->
	<div class="control-group">
		<label class="control-label" for="email">{$lang.Email} :</label>
		<div class="controls"><input type="email" name="agence[email]" id="email" class="validate[custom[email]]" value="{$Agence.email}"/></div>
	</div>
		
	<!-- PHOTO -->
	<div class="control-group">
		<label class="control-label" for="photo">{$lang.Photo} :</label>
		<div class="controls">
			<div class="uploader">
				<input type="file" name="photo" id="photo" class="uniform-fileInput"/>
				<span class="filename">No file selected</span>
				<span class="action">Choose File</span>
			</div>
		</div>
	</div>
		
	<!-- DIRECTEURS -->
	<div class="control-group">
		<label class="control-label" for="directeur_id">{$lang.Directeur} :</label>
		<div class="controls">
			<select name="agence[directeur_id]" id="directeur_id">
				<option></option>
				{foreach $Utilisateurs as $Row}
				<option value="{$Row.id}" {if $Agence.directeur_id == $Row.id}selected="selected"{/if}>{$Row.identifiant}</option>
				{/foreach}
			</select>
		</div>
	</div>
	</fieldset>
	<div class="form-actions">
        <input type="hidden" name="agence[id]" value="{$Agence.id}" />
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</div>		
			
</form>
{/strip}
<script type="text/javascript">
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#formAgenceEdit").validationEngine();
	
	$('#code_postal').autocomplete({
		source:'{getLink("ajax/getVilleByCp?nohtml=nohtml")}',
		minLength:3,
		dataType:"json",
		delay:0,
		select: function(e,ui){			
			$("#ville").val(ui.item.label);	
			$("#code_postal").val(ui.item.value);		
			return false;
		}		
	});
});
</script>