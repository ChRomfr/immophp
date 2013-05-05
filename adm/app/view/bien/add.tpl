{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>

<div class="well">

<!-- FORMULAIRE -->
<form method="post" action="{getLinkAdm("bien/add")}" class="form-horizontal" id="FormBienAdd" target="uploadFrame" enctype="multipart/form-data">
	<fieldset>
    <legend>{$lang.Nouveau_bien}</legend>
    <!-- PROSPECT -->
    
    <div class="control-group" >
        <label class="control-label"  for="vendeur_id">{$lang.Vendeur} :</label>
        <div class="controls">
            <select name="bien[vendeur_id]" id="vendeur_id" class="chzn-select">
                <option></option>
                {foreach $Vendeurs as $Row}
                <option value="{$Row.id}">{$Row.nom} {$Row.prenom}</option>
                {/foreach}
            </select>
        </div>
    </div>
    
	<!-- TYPE DE TRANSACTION -->
	<div class="control-group" >
		<label class="control-label"  for="transaction">{$lang.Transaction} :</label>
		<div class="controls">
			<select name="bien[transaction]" id="transaction" required>
				<option></option>
				{foreach $TRANS as $Row}
				<option value="{$Row.value}">{$Row.libelle}</option>
				{/foreach}
			</select>
		</div>
	</div>
	<!-- REFERENCE -->
	<div class="control-group" >
		<label class="control-label"  for="reference">{$lang.Reference} :</label>
		<div class="controls">
			<input type="text" name="bien[reference]" id="reference" class="input-small" required/>
		</div>
	</div>
		
	<!-- CATEGORIE -->
	<div class="control-group" >
		<label class="control-label"  for="categorie_id">{$lang.Categorie} :</label>
		<div class="controls">
			<select name="bien[categorie_id]" id="categorie_id" required>
				<option></option>
				{foreach $Categories as $Row}
				<option value="{$Row.id}">{$Row.name}</option>
				{/foreach}
			</select>
		</div>
	</div>
	<!-- AGENCE -->
	<div class="control-group" >
		<label class="control-label"  for="agence_id">{$lang.Agence} :</label>
		<div class="controls">
			<select name="bien[agence_id]" id="agence_id" required>
				<option></option>
				{foreach $Agences as $Row}
				<option value="{$Row.id}">{$Row.nom}</option>
				{/foreach}
			</select>
		</div>
	</div>
	<!-- TITRE DU BIEN -->
	<div class="control-group" >
		<label class="control-label"  for="nom">{$lang.Titre}</label>
		<div class="controls"><input type="text" name="bien[nom]" id="nom" required /></div>
	</div>
	<div class="control-group" >
		<!-- DESCRIPTION -->
		<label class="control-label"  for="description">{$lang.Description}</label>
		<div class="controls">
			<textarea name="bien[description]" id="description" class="input-xxlarge" rows="5"></textarea>
		</div>
	</div>
	<div class="control-group" >
		<!-- ADRESSE -->
		<label class="control-label"  for="adress">{$lang.Adresse} :</label>
		<div class="controls"><textarea name="bien[adresse]" id="adresse" rows="3" class="input-xxlarge" cols="40"></textarea></div>
	</div>
	
	<!-- Code postal -->
	<div class="control-group" >
		<label class="control-label"  for="code_postal">{$lang.Code_postal} :</label>
		<div class="controls"><input type="text" name="bien[code_postal]" id="code_postal" size="7" required /></div>
	</div>
	
	<!-- Ville -->
	<div class="control-group" >
		<label class="control-label"  for="ville">{$lang.Ville} :</label>
		<div class="controls"><input type="text" name="bien[ville]" id="ville" required /></div>
	</div>	
		
	<!-- PAYS -->
	<div class="control-group" >
		<label class="control-label"  for="pays">{$lang.Pays} :</label>
		<div class="controls"><input type="text" name="bien[pays]" id="pays" required value="{$config.pays_default}"/></div>
	</div>
	
	<!-- PRIX -->
	<div class="control-group" >
		<label class="control-label"  for="prix">{$lang.Prix} :</label>
		<div class="controls">
			<div class="input-append">
				<input type="text" name="bien[prix]" id="prix" size="6" class="input-small"/>
				<span class="add-on">{$config.devise}</sapn>
			</div>
		</div>
	</div>
		
	<!-- SURFACE -->
	<div class="control-group" >
		<label class="control-label"  for="surface">{$lang.Surface} :</label>
		<div class="controls">
			<div class="input-append">
				<input type="text" name="bien[surface]" size="6" class="input-small"/>
				<span class="add-on">m&sup2;</span>
			</div>
		</div>
	</div>
		
	<!-- PIECES -->
	<div class="control-group" >
		<label class="control-label"  for="piece">{$lang.Pieces} :</label>
		<div class="controls"><input type="text" size="2" class="validate[custom[integer]] input-mini" id="piece" name="bien[piece]" /></div>
	</div>
		
	<!-- CHAMPBRE -->
	<div class="control-group" >
		<label class="control-label"  for="chambre">{$lang.Chambres} :</label>
		<div class="controls"><input type="text" size="2" class="validate[custom[integer]] input-mini" id="chambre" name="bien[chambre]" /></div>
	</div>
		
	<!-- SALLE DE BAIN -->
	<div class="control-group" >
		<label class="control-label"  for="sdb">{$lang.Salle_de_bain} :</label>
		<div class="controls"><input type="text" size="2" class="validate[custom[integer]] input-mini" id="sbd" name="bien[sdb]" /></div>
	</div>
		
	<!-- WC -->
	<div class="control-group" >
		<label class="control-label"  for="piece">{$lang.WC} :</label>
		<div class="controls"><input type="text" size="2" class="validate[custom[integer]] input-mini" id="wc" name="bien[wc]" /></div>
	</div>	
	
	<!-- PARKING -->
	<div class="control-group" >
		<label class="control-label"  for="parking">{$lang.Parking} :</label>
		<div class="controls"><input type="text" size="2" class="validate[custom[integer]] input-mini" id="parking" name="bien[parking]" /></div>
	</div>	
		
	<!-- CONSO ENERGETIQUE -->
	<div class="control-group" >
		<label class="control-label"  for="conso_energ">{$lang.Consommation_energetique} :</label>
		<div class="controls">
			<select name="bien[conso_energ]" id="conso_energ">
				<option></option>
				{foreach $DEP as $Row}
				<option value="{$Row.value}">{$Row.libelle}</option>
				{/foreach}
			</select>
		</div>
	</div>
	<!-- GAZ A EFFET DE SERRE -->
	<div class="control-group" >
		<label class="control-label"  for="emission_ges">{$lang.Emission_ges} :</label>
		<div class="controls">
			<select name="bien[emission_ges]" id="emission_ges">
				<option></option>
				{foreach $DEP as $Row}
				<option value="{$Row.value}">{$Row.libelle}</option>
				{/foreach}
			</select>
		</div>
	</div>
	
	<!-- VISIBLE SITE INTERNET -->
    <div class="control-group" >
        <label class="control-label"  for="visible">{$lang.En_ligne} :</label>
        <div class="controls">
            <select name="bien[visible]" id="visible">
                <option value="0">{$lang.Non}</option>
                <option value="1">{$lang.Oui}</option>
            </select>
        </div>
    </div>  
    
    <!-- COUP DE COEUR -->
    <div class="control-group" >
        <label class="control-label"  for="coup_de_coeur">{$lang.Coup_de_coeur} :</label>
        <div class="controls">
            <select name="bien[coup_de_coeur]" id="coup_de_coeur">
                <option value="0">{$lang.Non}</option>
                <option value="1">{$lang.Oui}</option>
            </select>
        </div>
    </div> 

    <!-- EXCLUSIF -->
    <div class="control-group">
    	<label class="control-label"  class="control-label">Exclusif :</label>
    	<div class="controls">
    		<select name="bien[exclusif]" id="exclusif">
    			<option value="0">{$lang.Non}</option>
    			<option value="1">{$lang.Oui}</option>
    		</select>
    	</div>
    </div>
    
	<!-- PHOTOS -->
	<div class="control-group" >
		<label class="control-label"  for="photo">{$lang.Photos} :</label>
		<div class="controls">
			<div class="uploader">
				<input type="file" name="photo1" id="photo1" class="uniform-fileInput"/>
				<span class="filename">No file selected</span>
				<span class="action">Choose File</span>
			</div>
			<br/>
			<div class="uploader">
				<input type="file" name="photo2" id="photo2" class="uniform-fileInput"/>
				<span class="filename">No file selected</span>
				<span class="action">Choose File</span>
			</div>
			<br/>
			<div class="uploader">
				<input type="file" name="photo3" id="photo3" class="uniform-fileInput"/>
				<span class="filename">No file selected</span>
				<span class="action">Choose File</span>
			</div>
		</div>
	</div>

	<!-- VIDEO -->
	<div class="control-group">
		<label class="control-label"  for="video_code" class="control-label">{$lang.Code_de_la_video} :</label>
		<div class="controls">
			<textarea name="bien[video_code]" id="video_code" class="input-xxlarge" rows="3"></textarea>
			<span class="help-block">{$lang.Explication_taille_video}</span>
		</div>
	</div>
		
	<div class="form-actions">
		<button type="submit" class="btn btn-primary"><i class="icon icon-white icon-save"></i>&nbsp;{$lang.Enregistrer}</button>
	</div>
</fieldset>
</form>

</div><!-- /well ->
<!-- IFRAME SOUMISSION FORMULAIRE -->		
<div id="uploadInfos">
    <div id="uploadStatus"></div>
    <iframe id="uploadFrame" name="uploadFrame" style="display:none;"></iframe>
</div>
{/strip}
<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	//jQuery("#FormBienAdd").validationEngine();
	
	$('#code_postal').autocomplete({
		source:'{getLink("ajax/getVilleByCp?nohtml=nohtml")}',
		minLength:3,
		dataType:"json",
		delay:0,
		select: function(e,ui){			
			$("#ville").val(ui.item.label);	
			$("#code_postal").val(ui.item.value);
			$('#prix').focus();		
			return false;
		}		
	});
});

function sendUpload(){    
	$("#uploadStatus").html('<div class="alert alert-info"><img src="{$config.url}{$config.url_dir}web/images/lightbox-ico-loading.gif" alt="" /><br/>Enregistrement en cour ...</div></div>');
	$("#FormBienAdd").css('display','none');
	return true;
}

function endUpload(result){
	if( result == 'echec'){
		$("#uploadStatus").html('<div class="alert alert-error">Une erreur est survenu pendant le traitement</div>');
		$("#FormBienAdd").css('display','block');
	}else{
		$("#uploadStatus").html('<div class="alert alert-success">Bien enregistre</div>');
	    setTimeout(function(){ window.location.href = '{getLinkAdm("bien")}'; }, '3000');
	}
}

$(".chzn-select").chosen();
{literal}
jQuery(document).ready(function(){
	$('#FormBienAdd').validate({
		rules: {
			'bien[nom]': 'required',
			'bien[transaction]': 'required',
			'bien[reference]':{ required:true },
			'bien[categorie_id]': 'required',
			'bien[prix]':{ number:true },
			'bien[surface]': {number:true},
			'bien[chambre]': {number:true},
			'bien[sdb]': {number:true},
			'bien[wc]': {number:true},
			'bien[parking]': {number:true},
		},
		highlight:function(element)
        {
            $(element).parents('.control-group').removeClass('success');
            $(element).parents('.control-group').addClass('error');
        },
        unhighlight: function(element)
        {
            $(element).parents('.control-group').removeClass('error');
            $(element).parents('.control-group').addClass('success');
        },
        submitHandler: function(form) {
        	if ($("#FormBienAdd").valid()) {
        	    form.submit();            	
            	return sendUpload();
        	}        	
        }
	});
});
{/literal}
$(document).ready(function()	{
   $('#description').markItUp(mySettings);
});
//-->
</script>