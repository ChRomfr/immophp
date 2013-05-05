<!-- ADM/APP/VIEW/PROSPECT/ADD -->
<script type="text/javascript">
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#formEditProspect").validationEngine();
	
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
{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{getLinkAdm("prospect")}" title="{$lang.Prospect}">{$lang.Prospect}</a><span class="divider">/</span></li>
    <li><a href="{$Helper->getLinkAdm("prospect/fiche/{$Prospect.id}")}" title="{$lang.Prospect}">{$Prospect.prenom} {$Prospect.nom}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<form method="post" action="{getLinkAdm("prospect/edit/{$Prospect.id}")}" class="form-horizontal well" id="formEditProspect">
    <fielset>
    <legend>{$lang.Edition_prospect}</legend>
    <div class="control-group">
        <label class="control-label" for="type">{$lang.Type} :</label>
        <div class="controls">
            <span><input type="checkbox" name="prospect[acheteur]" value="1" {if $Prospect.acheteur == 1}checked="checked"{/if} />{$lang.Acheteur}</span><br/>
            <span><input type="checkbox" name="prospect[vendeur]" value="1" {if $Prospect.vendeur == 1}checked="checked"{/if}/>{$lang.Vendeur}</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="nom">{$lang.Nom}</label>
        <div class="controls"><input type="text" name="prospect[nom]" id="nom" class="validate[required]" required value="{$Prospect.nom}" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="nom">{$lang.Prenom}</label>
        <div class="controls"><input type="text" name="prospect[prenom]" id="prenom" class="validate[required]" required value="{$Prospect.prenom}" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="adresse">{$lang.Adresse} :</label>
        <div class="controls"><textarea name="prospect[adresse]" id="adresse" cols="50" rows="2">{$Prospect.adresse}</textarea></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="code_postal">{$lang.Code_postal} :</label>
        <div class="controls"><input type="text" name="prospect[code_postal]" id="code_postal" size="5" value="{$Prospect.code_postal}" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="ville">{$lang.Ville} :</label>
        <div class="controls"><input type="text" name="prospect[ville]" id="ville" value="{$Prospect.ville}" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="pays">{$lang.Pays} :</label>
        <div class="controls"><input type="text" name="prospect[pays]" id="pays" value="{$Prospect.pays}" /></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="telephone">{$lang.Telephone} :</label>
        <div class="controls"><input type="text" name="prospect[telephone]" id="telephone" value="{$Prospect.telephone}"/></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="portable">{$lang.Portable} :</label>
        <div class="controls"><input type="text" name="prospect[portable]" id="portable" value="{$Prospect.portable}"/></div>
    </div>
    <div class="control-group">
        <label class="control-label" for="email">{$lang.Email} :</label>
        <div class="controls"><input type="email" name="prospect[email]" id="email" class="validate[custom[email]]" value="{$Prospect.email}"/></div>
    </div>

    <div class="control-group">
        <label class="control-label" class="control-label">{$lang.Agence} :</label>
        <div class="controls">
            <select name="prospect[agence_id]" id="agence_id">
                <option></option>
                {foreach $Agences as $Row}
                <option value="{$Row.id}" {if $Prospect.agence_id == $Row.id}selected="selected"{/if}>{$Row.nom}</option>
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
                    <option value="{$Row.id}" {if $Prospect.criteres.categorie == $Row.id}selected="selected"{/if}>{$Row.name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="prix_max">{$lang.Budget} :</label>
            <div class="controls"><input type="text" size="8" name="criteres[prix_max]" id="prix_max" class="validate[custom[integer]]" value="{$Prospect.criteres.prix_max}" />&nbsp;{$config.devise}</div>
        </div>
        <div class="control-group">
            <label class="control-label" for="piece">{$lang.Pieces} :</abel>
            <div class="controls"><input type="text" size="2" name="criteres[piece]" id="piece" class="validate[custom[integer]]" value="{$Prospect.criteres.piece}"/></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="chambre">{$lang.Chambres} :</label>
            <div class="controls"><input type="text" size="2" name="criteres[chambre]" id="chambre" class="validate[custom[integer]]" value="{$Prospect.criteres.chambre}"/></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="departement">{$lang.Departement} :</label>
            <div class="controls"><input type="text" name="criteres[departement]" id="departement" size="5" class="validate[custom[integer]]" value="{$Prospect.criteres.departement}"/></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="cville">{$lang.Ville} :</label>
            <div class="controls"><input type="text" name="criteres[ville]" id="cvile" value="{$Prospect.criteres.ville}"/></div>
        </div>
        <div class="control-group">
            <label class="control-label" for="cautre">{$lang.Autres} :</label>
            <div class="controls"><textarea name="criteres[autre]" id="cautre" rows="4" class="input-xxlarge" >{$Prospect.criteres.autre}</textarea></div>
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
                <option vlaue="0" {if $Prospect.deja_proprietaire == 0}selected="selected"{/if}>Non</option>
                <option value="1" {if $Prospect.deja_proprietaire == 1}selected="selected"{/if}>Oui</option>
            </select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="autre">{$lang.Autres} :</label>
        <div class="controls"><textarea name="prospect[autres]" id="autre" rows="4" class="input-xxlarge">{$Prospect.autres}</textarea></div>
    </div>
    </fieldset>
    <div class="form-actions">
        <input type="hidden" name="prospect[id]" value="{$Prospect.id}" />
        <button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
    </div>
        
</form>
{/strip}