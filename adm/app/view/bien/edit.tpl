{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<div class="well">

<!-- FORMULAIRE -->
<form method="post" action="{$Helper->getLinkAdm("bien/edit/{$Bien->id}")}" class="form-horizontal" id="FormBienEdit" target="uploadFrame" >
<fielset>	
	<legend>{$lang.Edition}</legend>
    
    <!-- PROSPECT -->
    <div class="control-group">
        <label class="control-label" for="vendeur_id">{$lang.Vendeur} :</label>
        <div class="controls">
            <select name="bien[vendeur_id]" class="chzn-select">>
                <option value=""></option>
                {foreach $Vendeurs as $Row}
                <option value="{$Row.id}" {if $Bien->vendeur_id == $Row.id}selected="selected"{/if}>{$Row.nom} {$Row.prenom}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <!-- TYPE DE TRANSACTION -->
	<div class="control-group">
		<label class="control-label" for="transaction">{$lang.Transaction} :</label>
		<div class="controls">
			<select name="bien[transaction]" id="transaction" class="validate[required]" required>
				<option></option>
				{foreach $TRANS as $Row}
				<option value="{$Row.value}" {if $Bien->transaction == $Row.value}selected="selected"{/if}>{$Row.libelle}</option>
				{/foreach}
			</select>
		</div>
	</div>
	<!-- REFERENCE -->
	<div class="control-group">
		<label class="control-label" for="reference">{$lang.Reference} :</label>
		<div class="controls"><input type="text" name="bien[reference]" id="reference" required size="10" value="{$Bien->reference}"/></div>
	</div>
		
	<!-- CATEGORIE -->
	<div class="control-group">
		<label class="control-label" for="categorie_id">{$lang.Categorie} :</label>
		<div class="controls">
			<select name="bien[categorie_id]" id="categorie_id" required>
				<option></option>
				{foreach $Categories as $Row}
				<option value="{$Row.id}" {if $Bien->categorie_id == $Row.id}selected="selected"{/if}>{$Row.name}</option>
				{/foreach}
			</select>
		</div>
	</div>
	<!-- AGENCE -->
	<div class="control-group">
		<label class="control-label" for="agence_id">{$lang.Agence} :</label>
		<div class="controls">
			<select name="bien[agence_id]" id="agence_id" required>
				<option></option>
				{foreach $Agences as $Row}
				<option value="{$Row.id}" {if $Bien->agence_id == $Row.id}selected="selected"{/if}>{$Row.nom}</option>
				{/foreach}
			</select>
		</div>
	</div>

	<!-- TITRE DU BIEN -->
	<div class="control-group">
		<label class="control-label" for="nom">{$lang.Titre}</label>
		<div class="controls"><input type="text" name="bien[nom]" id="nom" required value="{$Bien->nom}"/></div>
	</div>
	<div class="control-group">
		<!-- DESCRIPTION -->
		<label class="control-label" for="description">{$lang.Description}</label>
		<div class="controls"><textarea name="bien[description]" id="description" cols="40" rows="3">{$Bien->description}</textarea></div>
	</div>
	<div class="control-group">
		<!-- ADRESSE -->
		<label class="control-label" for="adress">{$lang.Adresse} :</label>
		<div class="controls"><textarea name="bien[adresse]" id="adresse" rows="3" class="input-xxlarge" cols="40">{$Bien->adresse}</textarea></div>
	</div>
	
	<!-- Code postal -->
	<div class="control-group">
		<label class="control-label" for="code_postal">{$lang.Code_postal} :</label>
		<div class="controls"><input type="text" name="bien[code_postal]" id="code_postal" size="7" required class="input-small" value="{$Bien->code_postal}"/></div>
	</div>
	
	<!-- Ville -->
	<div class="control-group">
		<label class="control-label" for="ville">{$lang.Ville} :</label>
		<div class="controls"><input type="text" name="bien[ville]" id="ville" required class="validate[required]" value="{$Bien->ville}"/></div>
	</div>	
		
	<!-- PAYS -->
	<div class="control-group">
		<label class="control-label" for="pays">{$lang.Pays} :</label>
		<div class="controls"><input type="text" name="bien[pays]" id="pays" required class="validate[required]" value="{$Bien->pays}"/></div>
	</div>
	
	<!-- PRIX -->
	<div class="control-group" >
		<label class="control-label"  for="prix">{$lang.Prix} :</label>
		<div class="controls">
			<div class="input-append">
				<input type="text" name="bien[prix]" id="prix" size="6" value="{$Bien->prix}" class="input-small"/>
				<span class="add-on">{$config.devise}</sapn>
			</div>
		</div>
	</div>
		
	<!-- SURFACE -->
	<div class="control-group" >
		<label class="control-label"  for="surface">{$lang.Surface} :</label>
		<div class="controls">
			<div class="input-append">
				<input type="text" name="bien[surface]" size="6" value="{$Bien->surface}" class="input-small"/>
				<span class="add-on">m&sup2;</span>
			</div>
		</div>
	</div>
		
	<!-- PIECES -->
	<div class="control-group">
		<label class="control-label" for="piece">{$lang.Pieces} :</label>
		<div class="controls"><input type="text" size="2" class="input-mini" id="piece" name="bien[piece]" value="{$Bien->piece}" /></div>
	</div>
		
	<!-- CHAMPBRE -->
	<div class="control-group">
		<label class="control-label" for="chambre">{$lang.Chambres} :</label>
		<div class="controls"><input type="text" size="2" class="input-mini" id="chambre" name="bien[chambre]" value="{$Bien->chambre}" /></div>
	</div>
		
	<!-- SALLE DE BAIN -->
	<div class="control-group">
		<label class="control-label" for="sdb">{$lang.Salle_de_bain} :</label>
		<div class="controls"><input type="text" size="2" class="input-mini" id="sbd" name="bien[sdb]" value="{$Bien->sdb}" /></div>
	</div>
		
	<!-- WC -->
	<div class="control-group">
		<label class="control-label" for="piece">{$lang.WC} :</label>
		<div class="controls"><input type="text" size="2" class="input-mini" id="wc" name="bien[wc]" value="{$Bien->wc}" /></div>
	</div>	
	
	<!-- PARKING -->
	<div class="control-group">
		<label class="control-label" for="parking">{$lang.Parking} :</label>
		<div class="controls"><input type="text" size="2" class="input-mini" id="parking" name="bien[parking]" value="{$Bien->parking}" /></div>
	</div>	
		
	<!-- CONSO ENERGETIQUE -->
	<div class="control-group">
		<label class="control-label" for="conso_energ">{$lang.Consommation_energetique} :</label>
		<div class="controls">
			<select name="bien[conso_energ]" id="conso_energ">
				<option></option>
				{foreach $DEP as $Row}
				<option value="{$Row.value}" {if $Bien->conso_energ == $Row.value}selected="selected"{/if}>{$Row.libelle}</option>
				{/foreach}
			</select>
		</div>
	</div>
	<!-- GAZ A EFFET DE SERRE -->
	<div class="control-group">
		<label class="control-label" for="emission_ges">{$lang.Emission_ges} :</label>
		<div class="controls">
			<select name="bien[emission_ges]" id="emission_ges">
				<option></option>
				{foreach $DEP as $Row}
				<option value="{$Row.value}" {if $Bien->emission_ges == $Row.value}selected="selected"{/if}>{$Row.libelle}</option>
				{/foreach}
			</select>
		</div>
	</div>
	
	<!-- VISIBLE SITE INTERNET -->
    <div class="control-group">
        <label class="control-label" for="visible">{$lang.En_ligne} :</label>
        <div class="controls">
            <select name="bien[visible]" id="visible">
                <option value="0" {if $Bien->visible == 0}selected="selected"{/if}>{$lang.Non}</option>
                <option value="1" {if $Bien->visible == 1}selected="selected"{/if}>{$lang.Oui}</option>
            </select>
        </div>
    </div> 

    <!-- COUP DE COEUR -->
    <div class="control-group">
        <label class="control-label" for="coup_de_coeur">{$lang.Coup_de_coeur} :</label>
        <div class="controls">
            <select name="bien[coup_de_coeur]" id="coup_de_coeur">
                <option value="0" {if $Bien->coup_de_coeur == 0}selected="selected"{/if}>{$lang.Non}</option>
                <option value="1" {if $Bien->coup_de_coeur == 1}selected="selected"{/if}>{$lang.Oui}</option>
            </select>
        </div>
    </div>
    
    <!-- VENDU -->
    <div class="control-group">
        <label class="control-label" for="vendu">{$lang.Vendu} :</label>
        <div class="controls">
            <select name="bien[vendu]" id="vendu">
                <option value="0" {if $Bien->vendu == 0}selected="selected"{/if}>{$lang.Non}</option>
                <option value="1" {if $Bien->vendu == 1}selected="selected"{/if}>{$lang.Oui}</option>
            </select>
        </div>
    </div>
    
    <!-- LISTE DES PROSPECTS ACHETEURS -->
    <div class="control-group">
        <label class="control-label" for="acheteur_id">{$lang.Acheteur} :</label>
        <div class="controls">
            <select name="bien[acheteur_id]">
                <option></option>
                {foreach $Achateurs as $Row}
                <option value="{$Row.id}" {if $Bien->acheteur_id == $Row.id}selected="selected"{/if}>{$Row.nom} {$Row.prenom}</option>
                {/foreach}
            </select>
        </div>
    </div>

    <!-- EXCLUSIF -->
    <div class="control-group">
    	<label class="control-label" class="control-label"  class="control-label">Exclusif :</label>
    	<div class="controls">
    		<select name="bien[exclusif]" id="exclusif">
    			<option value="0" {if $Bien->exclusif == 0}selected="selected"{/if}>{$lang.Non}</option>
    			<option value="1" {if $Bien->exclusif == 1}selected="selected"{/if}>{$lang.Oui}</option>
    		</select>
    	</div>
    </div>
		
	<!-- VIDEO -->
	<div class="control-group">
		<label class="control-label" for="video_code" class="control-label">{$lang.Code_de_la_video} :</label>
		<div class="controls">
			<textarea name="bien[video_code]" id="video_code" class="input-xxlarge">{$Bien->video_code}</textarea>
			<span class="help-block">{$lang.Explication_taille_video}</span>
		</div>
	</div>

	<div class="form-actions">
        <input type="hidden" name="bien[id]" value="{$Bien->id}" />
        <input type="hidden" name="bien[add_on]" value="{$Bien->add_on}" />
        <input type="hidden" name="bien[add_by]" value="{$Bien->add_by}" />
        <input type="hidden" name="old_prix" value="{$Bien->prix}" />
        <button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</div>
</fielset>
</form>
       
<!-- IFRAME SOUMISSION FORMULAIRE -->		
<div id="uploadInfos">
    <div id="uploadStatus"></div>
    <iframe id="uploadFrame" name="uploadFrame" style="display:none;"></iframe>
</div>

</div><!-- /well -->
{/strip}
<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	//jQuery("#FormBienEdit").validationEngine();
	
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

function sendUpload(){    
	$("#uploadStatus").html('<div class="alert alert-info"><img src="{$config.url}{$config.url_dir}web/images/lightbox-ico-loading.gif" alt="" /><br/>Enregistrement en cour ...</div></div>');
	$("#FormBienEdit").css('display','none');
	return true;
}

function endUpload(result){
	if( result == 'echec'){
		$("#uploadStatus").html('<div class="alert alert-error">Une erreur est survenu pendant le traitement</div>');
		$("#FormBienEdit").css('display','block');
	}else{
		$("#uploadStatus").html('<div class="alert alert-success">Bien enregistre</div>');
	    setTimeout(function(){ window.location.href = '{getLinkAdm("bien")}'; }, '3000');
	}
}

$(".chzn-select").chosen();
{literal}
jQuery(document).ready(function(){
	$('#FormBienEdit').validate({
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
        	if ($("#FormBienEdit").valid()) {
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