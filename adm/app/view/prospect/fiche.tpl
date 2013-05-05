<!-- ADM/APP/VIEW/PROSPECT/FICHE -->
<script type="text/javascript">
<!--
function getBiens(prospect_id){
    $.get(
        '{getLinkAdm("prospect/ajaxFindBiens/'+prospect_id+'")}', {literal}
        {nohtml:'nohtml'},
        function(data){ $('#biens_prosposition').html(data); }
    );{/literal}
}

function deleteProspect(prospect_id){
    if( confirm('{$lang.Confirm_suppression_prospect} ?') ){
        window.location.href='{getLinkAdm("prospect/delete/'+ prospect_id +'")}';
    }
}

function deleteSuivi(suivi_id){
    if( confirm('Etes vous sur de vouloir supprimer ce suivi ?') ){
        window.location.href = '{$Helper->getLinkAdm("prospect/suiviDelete/'+ suivi_id +'?prospect_id={$Prospect.id}")}';
    }
}
//--->
</script>
{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{getLinkAdm("prospect")}" title="{$lang.Prospect}">{$lang.Prospect}</a><span class="divider">/</span></li>
	<li>{$Prospect.prenom} {$Prospect.nom}</li>
</ul>

<div class="well">

    <div class="fright">
        <a href="{getLinkAdm("prospect/edit/{$Prospect.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>
        &nbsp;&nbsp;
        <a href="javascript:deleteProspect({$Prospect.id})" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
    </div>

    <h4>{$Prospect.prenom} {$Prospect.nom}</h4>

    <div class="clear"></div>

    <table class="table">
        <tr>
            <td>{$lang.Type} :</td>
            <td>{if $Prospect.vendeur == 1}{$lang.Vendeur}<br/>{/if}{if $Prospect.acheteur == 1}{$lang.Acheteur}{/if}</td>
        </tr>
        <tr>
            <td>{$lang.Prospect} :</td>
            <td>{$Prospect.nom} {$Prospect.prenom}</td>
        </tr>
        <tr>
            <td>{$lang.Adresse} :</td>
            <td>{$Prospect.adresse|nl2br}<br/>{$Prospect.code_postal}&nbsp;&nbsp;{$Prospect.ville}</td>
        </tr>
        <tr>
            <td>{$lang.Telephone} :</td>
            <td>{$Prospect.telephone}</td>
        </tr>
        <tr>
            <td>{$lang.Portable} :</td>
            <td>{$Prospect.portable}</td>
        </tr>
        <tr>
            <td>{$lang.Email} :</td>
            <td><a href="mailto:{$Prospect.email}" title="">{$Prospect.email}</a></td>
        </tr>
        {if !empty($Prospect.agence_id)}
        <tr>
            <td>{$lang.Agence} :</td>
            <td>{$Prospect.agence}</td>
        </tr>
        {/if}

        {if !empty($Prospect.autres)}
        <tr>
            <td></td>
            <td>{$Prospect.autres|nl2br}</td>
        </tr>
        {/if}
    </table>

    <!-- Tab -->
    <div class="tab-content">

        <ul id="tabFicheProspect" class="nav nav-tabs">
            {if $Prospect.acheteur == 1}<li><a href="#tabCriteres" data-toggle="tab">Criteres</a></li>{/if}
            {if $Prospect.acheteur == 1}<li><a href="#tabVisites" data-toggle="tab">Visites</a></li>{/if}
            {if $Prospect.vendeur == 1}<li><a href="#tabBiens" data-toggle="tab">Biens</a></li>{/if}
            <li><a href="#tabSuivis" data-toggle="tab">Suivi</a></li>
            <li class="active"><a href="#tabHistorique" data-toggle="tab">Historique</a></li>
        </ul><!-- /tabFicheProspect -->

        <div id="tabHistorique" class="tab-pane active">
            <table id="tableauHistorique" class="table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Utilisateur</th>
                        <th>Log</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>

        {if $Prospect.vendeur == 1}
        <div id="tabBiens" class="tab-pane">
            <table class="table table-bordered table-striped  table-condensed" id="tableauBiens">
                <thead>
                    <tr>
                        <th>{$lang.Reference}</th>
                        <th>{$lang.Bien}</th>
                        <th>{$lang.Categorie}</th>
                        <th>{$lang.Transaction}</th>
                        <th>{$lang.En_ligne}</th>
                        <th>{$lang.Vendu}</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div><!-- /tabBiens -->
        {/if}
    
        {if $Prospect.acheteur == 1}
        <div id="tabCriteres" class="tab-pane">
            <h4>{$lang.Criteres_de_recherche}</h4>
            
            <table class="table">
                <tr>
                    <td>{$lang.Type_de_bien} :</td>
                    <td>{$Prospect.criteres.categorie_name.name}</td>
                </tr>
                {if !empty($Prospect.criteres.prix_max)}
                <tr>
                    <td>{$lang.Budget} :</td>
                    <td>{$Prospect.criteres.prix_max}</td>
                </tr>
                {/if}
                {if !empty($Prospect.criteres.piece)}
                <tr>
                    <td>{$lang.Pieces} :</td>
                    <td>{$Prospect.criteres.pieces}</td>
                </tr>
                {/if}
                {if !empty($Prospect.criteres.chambre)}
                <tr>
                    <td>{$lang.Chambres} :</td>
                    <td>{$Prospect.criteres.chambre}</td>
                </tr>
                {/if}
                {if !empty($Prospect.criteres.ville) || !empty($Prospect.criteres.departement)}
                <tr>
                    <td>{$lang.Situation_geographique} :</td>
                    <td>
                        {if !empty($Prospect.criteres.ville)}{$lang.Ville} : {$Prospect.criteres.ville}<br/>{/if}
                        {if !empty($Prospect.criteres.departement)}{$lang.Departement} : {$Prospect.criteres.departement}<br/>{/if}
                    </td>
                </tr>
                {/if}
                {if !empty($Prospect.criteres.autre)}
                <tr>
                    <td>{$lang.Autre} :</td>
                    <td>{$Prospect.criteres.autre|nl2br}</td>
                </tr>
                {/if}
            </table>

            
            <div class="fright"><button type="button" class="btn" onclick="getBiens({$Prospect.id})">{$lang.Biens}</button></div>
            <div class="clear"></div>
            <div id="biens_prosposition"></div>
        </div><!-- /tabCriteres -->
        {/if}
    
        
        <div id="tabVisites" class="tab-pane">
            <h4>{$lang.Visites}</h4>
            {if count($Visites) > 0}
            <table class="table table-condensed table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>{$lang.Prospect}</th>
                        <th>{$lang.Date}</th>
                        <th>{$lang.Bien}</th>
                        <th>{$lang.Collaborateur}</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $Visites as $Row}
                <tr>
                    <td><a href="{$Helper->getLinkAdm("visite/detail/{$Row.id}?nohtml")}" class="fbdetailvisite" title="">{$Row.id}</a></td>
                    <td>{$Row.p_nom} {$Row.p_prenom}</td>
                    <td>{$Row.date_visite} {$Row.heure_visite}</td>
                    <td>{$Row.bien} #{$Row.reference}</td>
                    <td>{$Row.identifiant}</td>
                </tr>
                {/foreach}
                </tbody>            
            </table>
            {else}
            <div class="alert alert-info">
                <div style="text-align:center">Aucune visite</div>
            </div>
            {/if}
        </div><!-- /tabVisites -->

        <!-- Suivi -->
        <div id="tabSuivis" class="tab-pane">
            <table id="tableauSuivi" class="table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Utilisateur</th>
                        <th>Suivi</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>

            <!-- Formulaire suivi -->
            <form method="post" action="{$Helper->getLinkAdm("prospect/suiviAdd/{$Prospect.id}")}" id="formSuiviAdd">
                <fieldset>
                    <legend>Nouveau</legend>
                    <div class="control-group">
                        <div class"=controls"><textarea class="input-xxlarge" name="suivi[suivi]" id="suivi[suivi]"></textarea></div>
                    </div>
                    <div class="form-actions">
                        <input type="hidden" name="suivi[prospect_id]" value="{$Prospect.id}" />
                        <button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
                    </div>
                </fieldset>
            </form>

        </div><!-- /tabSuivis -->
        
    </div><!-- /tabs-content -->
</div><!-- /well -->
{/strip}

<script>
(function($){
    $.get(
        '{$Helper->getLinkAdm("prospect/getHistorique/{$Prospect.id}")}', {literal}
        {nohtml:'nohtml'},
        function(data){ 
            var tplHistorique = "<tr><td>{{log_on}}</td><td>{{identifiant}}</td><td>{{log}}</td></tr>";
            for( var i in data ){
                $('#tableauHistorique').append( Mustache.render(tplHistorique, data[i]) );
            }
;
        },'json'); {/literal}
})(jQuery);

(function($){
    $.get(
        '{$Helper->getLinkAdm("prospect/getSuivi/{$Prospect.id}")}', {literal}
        {nohtml:'nohtml'},
        function(data){ 
            var tplHistorique = "<tr><td>{{add_on}}</td><td>{{identifiant}}</td><td>{{suivi}}</td><td><a href=\"javascript:deleteSuivi({{id}})\"><i class=\"icon-trash\"></i></tr>";
            for( var i in data ){
                $('#tableauSuivi').append( Mustache.render(tplHistorique, data[i]) );
            }
;
        },'json'); {/literal}
})(jQuery)

$(document).ready(function(){
    $("a.fbdetailvisite").fancybox();

    $("#formSuiviAdd").validate({
        rules:{
            'suivi[suivi]':"required"
        },
        messages:{
            'suivi[suivi]':"Veuillez saisir le suivi"
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
        }
    });
});

{if $Prospect.vendeur == 1}
(function($){
    $.get(
        '{$Helper->getLinkAdm("prospect/getBiens/{$Prospect.id}")}', {literal}
        {nohtml:'nohtml'},
        function(data){ 
            var tplHistorique = '<tr><td><a href="javascript:goToAnnonce({{id}});">{{reference}}</a></td><td>{{nom}}</td><td>{{categorie}}</td><td>{{transaction_type}}</td><td style="text-align:center">{{#visible}}<span class="label label-success">Oui</span>{{/visible}}{{^visible}}<span class="label label-error">Non</span>{{/visible}}</td><td style="text-align:center">{{#vendu}}<span class="label label-success">Oui</span>{{/vendu}}{{^vendu}}<span class="label label-error">Non{{/vendu}}</span></td></tr>';

            for( var i in data ){
                
                if( data[i].visible != '1' ){
                    data[i].visible = null;
                }

                if( data[i].vendu != '1' ){
                    data[i].vendu = null;
                }

                $('#tableauBiens').append( Mustache.render(tplHistorique, data[i]) );
            }
;
        },'json'); {/literal}
})(jQuery);
{/if}

function goToAnnonce(bien_id){
    window.location.href = '{$Helper->getLinkAdm("bien/fiche/'+ bien_id +'")}';
}
</script>