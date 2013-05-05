<!-- ADM/APP/VIEW/PROSPECT/ADD -->
<script type="text/javascript">
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#formAddProspect").validationEngine();
	
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
<!-- BREAD -->
<ul class="breadcrumb">
    <li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
    <li><a href="{$Helper->getLinkAdm("prospect")}" title="{$lang.Prospect}">{$lang.Prospect}</a><span class="divider">/</span></li>
    <li>{$lang.Nouveau}</li>
</ul>

<form method="post" action="" class="form-horizontal well" id="formAddProspect">
    <fieldset>
    <legend>{$lang.Nouveau_prospect}</legend>
    <div class="control-group">
        <label class="control-label" for="type">{$lang.Type} :</label>
        <div class="controls">
            <span><input type="checkbox" name="prospect[acheteur]" value="1" />{$lang.Acheteur}</span><br/>
            <span><input type="checkbox" name="prospect[vendeur]" value="1" />{$lang.Vendeur}</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="nom">{$lang.Nom}</label>
        <div class="controls"><input type="text" name="prospect[nom]" id="nom" class="validate[required]" required/></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="nom">{$lang.Prenom}</label>
        <div class="controls"><input type="text" name="prospect[prenom]" id="prenom" class="validate[required]" required /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="adresse">{$lang.Adresse} :</label>
        <div class="controls"><textarea name="prospect[adresse]" id="adresse" cols="50" rows="2"></textarea></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="code_postal">{$lang.Code_postal} :</label>
        <div class="controls"><input type="text" name="prospect[code_postal]" id="code_postal" size="5" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="ville">{$lang.Ville} :</label>
        <div class="controls"><input type="text" name="prospect[ville]" id="ville" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="pays">{$lang.Pays} :</label>
        <div class="controls"><input type="text" name="prospect[pays]" id="pays" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="telephone">{$lang.Telephone} :</label>
        <div class="controls"><input type="text" name="prospect[telephone]" id="telephone" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="portable">{$lang.Portable} :</label>
        <div class="controls"><input type="text" name="prospect[portable]" id="portable" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="email">{$lang.Email} :</label>
        <div class="controls"><input type="email" name="prospect[email]" id="email" class="validate[custom[email]]"/></div>
    </div>

    <div class="control-group">
        <label class="control-label" class="control-label">{$lang.Agence} :</label>
        <div class="controls">
            <select name="prospect[agence_id]" id="agence_id">
                <option></option>
                {foreach $Agences as $Row}
                <option value="{$Row.id}">{$Row.nom}</option>
                {/foreach}
            </select>
        </div>
    </div>
</fieldset>
    <!-- CRITERES DE RECHERCHE -->
    <fieldset>
        <legend>{$lang.Acheteur} :</legend>
        <div class="control-group">
            <label class="control-label" for="categorie_bien">{$lang.Categorie} :</label>
            <div class="controls">
                <select name="criteres[categorie]" id="categorie_bien">
                    <option></option>
                    {foreach $Categories as $Row}
                    <option value="{$Row.id}">{$Row.name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="prix_max">{$lang.Budget} :</label>
            <div class="controls"><input type="text" size="8" name="criteres[prix_max]" id="prix_max" class="validate[custom[integer]]"/>&nbsp;{$config.devise}</div>
        </div>
        <div class="control-group">
            <label class="control-label" for="piece">{$lang.Pieces} :</abel>
            <div class="controls"><input type="text" size="2" name="criteres[piece]" id="piece" class="validate[custom[integer]]" /></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="chambre">{$lang.Chambres} :</label>
            <div class="controls"><input type="text" size="2" name="criteres[chambre]" id="chambre" class="validate[custom[integer]]"/></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="departement">{$lang.Departement} :</label>
            <div class="controls"><input type="text" name="criteres[departement]" id="departement" size="5" class="validate[custom[integer]]"/></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="cville">{$lang.Ville} :</label>
            <div class="controls"><input type="text" name="criteres[ville]" id="cvile" /></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="cautre">{$lang.Autres} :</label>
            <div class="controls"><textarea name="criteres[autre]" id="cautre" rows="4" cols="50"></textarea></div>
        </div>
    </fieldset>
            
    <!-- Informations complemantaire -->
    <fieldset>
        <legend>Information supplementaire</legend>
    <div class="control-group">
        <label class="control-label" for="deja_proprietaire">{$lang.Proprietaire} :</label>
        <div class="controls">
            <select name="prospect[deja_proprietaire]" id="deja_proprietaire">
                <option></option>
                <option vlaue="0">Non</option>
                <option value="1">Oui</option>
            </select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="autre">{$lang.Autres} :</label>
        <div class="controls"><textarea name="prospect[autres]" id="autre" rows="4" cols="50"></textarea></div>
    </div>
    </fieldset>
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
    </div>        
</form>