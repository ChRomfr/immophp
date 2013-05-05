{strip}    
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/<span></li>
	<li><a href="{$Helper->getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a><span class="divider">/<span></li>
	<li>{$lang.Fiche}</li>
</ul>
    
<div class="well">
    
    <div class="pull-right">
        <a href="{$Helper->getLinkAdm("")}" title="Edit"><i class="icon icon-edit"></i></a>
    </div>

    <h4>{$Bien.nom}</h4>

    <div class="clearfix"></div>

    <table class="table">
        <tr>
            <td>{$lang.Reference}</td>
            <td>{$Bien.reference}</td>
        </tr>
        <tr>
            <td>{$lang.Bien}</td>
            <td>{$Bien.nom}</td>
        </tr>
        <tr>
            <td>Vu :</td>
            <td>{$Bien.view}</td>
        </tr>

        <tr>
            <td>Adresse : </td>
            <td>{$Bien.adresse}<br/>{$Bien.code_postal} {$Bien.ville}</td>
        </tr>
        
        <tr>
            <td>Nombre de visite :</td>
            <td>{count($Visites)}</td>
        </tr>

    </table>
    
    <div class="center">
        <a href="{getLink("annonce/detail/{$Bien.id}")}" title="{$lang.Voir}" id="fbfichebiensite" class="btn btn-primary">{$lang.Voir}</a>
    </div>

    <!-- Tab -->
    <ul id="tabFicheBien" class="nav nav-tabs">
        <li class="active"><a href="#tabPhotos" data-toggle="tab">{$lang.Photos}</a></li>

        <li><a href="#tabVisites" data-toggle="tab">{$lang.Visites}</a></li>

        <li><a href="#tabVente" data-toggle="tab">{$lang.Vente}</a></li>

        <li><a href="#tabHistoriquePrix" data-toggle="tab">Prix historique</a></li>

        <li><a href="#tabHistorique" data-toggle="tab">Historique</a></li>
    </ul><!-- /tabFicheBien -->

    <div class="tab-content">

        <!-- Tab Photo -->
        <div id="tabPhotos" class="tab-pane active">
            <div class="fright"><a href="#FormAddPhoto" id="fbformphoto"><i class="icon-plus"></i></a></div>
            <h4>{$lang.Photos}</h4>
            <div class="clear"></div>

            <div id="gallery">
                <table class="table">
                    <tr>
                        {foreach $Photos as $k => $v name=foo}
                            <td style="text-align:center;">
                                <img src="{$config.url}{$config.url_dir}web/upload/bien/{$Bien->id}/{$v}" style="width:200px;" alt="" /><br/>
                                <a href="javascript:deletePhoto('{$v}','{$Bien->id}')" title=""><i class="icon-trash"></i></a>
                            </td>
                            {if $smarty.foreach.foo.iteration%3 == 0}
                            </tr><tr>
                            {/if}
                        {/foreach}
                    </tr>
                </table>   
            </div>
        </div><!-- /tabPhotos -->

        <!-- Tab Visites -->
        <div id="tabVisites" class="tab-pane">
            <div class="fright">
                <a href="#modalvisite" role="button" data-toggle="modal"><i class="icon-plus"></i></a> 
            </div>
            <h4>{$lang.Visites}</h4>
            <div class="clear"></div>

            {if count($Visites) > 0}
            <table class="table table-bordered table-condensed table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>{$lang.Prospect}</th>
                        <th>{$lang.Date}</th>
                        <th>{$lang.Collaborateur}</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $Visites as $Row}
                <tr>
                    <td><a href="{getLinkAdm("visite/detail/{$Row.id}")}" title="">{$Row.id}</a></td>
                    <td><a href="{getLinkAdm("prospect/fiche/{$Row.prospect_id}")}" title="">{$Row.p_nom} {$Row.p_prenom}</a></td>
                    <td>{$Row.date_visite} {$Row.heure_visite}</td>
                    <td>{$Row.identifiant}</td>
                </tr>
                {/foreach}
                </tbody>
            </table>
            {/if}

        </div><!-- /tabVisites -->

        <div id="tabVente" class="tab-pane">
            <h4>{$lang.Vente}</h4>

            {if $Bien->vendu == 1 && $Bien->vendu_by_agence == 1}
    
            <table class="table">
                <tr>
                    <td>Vendu le</td>
                    <td>{$Bien->vendu_on|date_format:$config.format_date_day}</td>
                </tr>
                <tr>
                    <td>{$lang.Acheteur} :</td>
                    <td>{$Bien->acheteur_nom} {$Bien->acheteur_prenom}</td>
                </tr>
                <tr>
                    <td>{$lang.Vendeur} :</td>
                    <td>{$Bien->vendeur_identifiant}</td>
                </tr>
            </table>
        
            {/if}
            <form method="post" id="formBienVendu" action="{$Helper->getLinkAdm("bien/setVendu/{$Bien->id}")}">
                <dl>
                    <dt><label for="vendu">Vendu :</label></dt>
                    <dd>
                        <select name="bien[vendu]" id="vendu" onchange="javascript:checkVendu($('#vendu').val())">
                            <option value="0" {if $Bien->vendu == 0}selected="selected"{/if}>{$lang.Non}</option>
                            <option value="1" {if $Bien->vendu == 1}selected="selected"{/if}>{$lang.Oui}</option>
                        </select>
                    </dd>
                </dl>
                <div id="formBienVenduPart1"></div>
            </form>

        </div><!-- /tabVente -->

        <!-- Historique prix -->
        <div id="tabHistoriquePrix" class="tab-pane">
            <table id="tableauHistoriquePrix" class="table">
                <thead>
                    <tr>
                        <th>Prix</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div><!-- /tabHistoriquePrix -->


        <div id="tabHistorique" class="tab-pane">
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

    </div><!-- /tab-content -->

</div><!-- /well -->


<!-- Formulaire cache ajout visite -->
<div class="modal hide fade" id="modalvisite">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>Nouvelle visite</h3>
    </div>
    <div class="modal-body">
        <form class="form-stacked" id="formAddVisite" method="post" action="{$Helper->getLinkAdm("bien/visiteAdd/{$Bien.id}")}">
            <fieldset>
                <div>
                    <label for="prospect_id">{$lang.Prospect} :</label><br/>
                    <select name="visite[prospect_id]" id="prospect_id" class="validate[required] chzn-select" required>
                        <option value="">&nbsp;</option>
                        {foreach $Acheteurs as $Row}
                        <option value="{$Row.id}">{$Row.nom} {$Row.prenom}</option>
                        {/foreach}
                    </select>
                </div>
                <div>
                    <label for="date_visite">{$lang.Date} :</label><br/>
                    <input type="text" name="visite[date_visite]" id="date_visite" size="10" class="validate[required,custom[date]]"/>
                </div>
                <div>
                    <label for="heure_visite">{$lang.Heure} :</label><br/>
                    <input type="text" name="visite[heure_visite]" id="heure_visite" size="5" class="validate[required]"/>
                </div>                        
            </fieldset>
        </form>
    </div><!-- /modal-body -->
    <div class="modal-footer">
        <input type="hidden" name="visite[bien_id]" value="{$Bien.id}" />
        <input type="hidden" name="visite[user_id]" value="{$smarty.session.utilisateur.id}" />
        <button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
    </div><!-- /modal-footer -->
</div>

<!-- Formulaire cache pour ajout photo -->
<div style="display:none">
    <div id="FormAddPhoto" class="well">
        <form method="post" class="form-horizontal" action="{$Helper->getLinkAdm("bien/addPhoto/{$Bien->id}")}" enctype="multipart/form-data">

            <div class="control-group">
                <label class="control-label">{$lang.Photo} :</label>
                <div class="controls">
                    <input type="file" name="photo1" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">{$lang.Photo} :</label>
                <div class="controls">
                    <input type="file" name="photo2" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">{$lang.Photo} :</label>
                <div class="controls">
                    <input type="file" name="photo3" />
                </div>
            </div>

            <div class="form-actions">
                <input type="hidden" name="bien_id" value="{$Bien->id}" />
                <button type="submit" class="btn btn-primary">{$lang.Envoyer}</button>
            </div>

        </form>
    </div>
</div>

{/strip}
<script type="text/javascript">
<!--
$(function() {
	$( "#date_visite" ).datepicker({ dateFormat: 'dd/mm/yy', changeMonth:true, changeYear:true, showButtonPanel: true });
    $( "#date_visite" ).datepicker({ dateFormat: 'dd/mm/yy', changeMonth:true, changeYear:true, showButtonPanel: true });
});

function checkVendu(valeur){
    if( valeur == 0){
        $('#formBienVenduPart1').html('<div class="center"><input type="submit" value="Enregistrer" />');
    }else{
        $('#formBienVenduPart1').html('<dl><dt><label for="vendu_by_agence">Par l\'agence :</label></dt><dd><select name="bien[vendu_by_agence]" id="vendu_by_agence" required class="validate[required]" onchange="javascript:checkByAgence($(\'#vendu_by_agence\').val());"><option></option><option value="1">{$lang.Oui}</option><option value="0">{$lang.Non}</option></select></dl></dd><div id="formBienVenduPart2"></div>');
    }
}

function checkByAgence(valeur){
    if( valeur == 0){
        $('#formBienVenduPart2').html('<div class="text-center"><input class="btn btn-primary" type="submit" value="Enregistrer" />');
    }else if( valeur == 1){
        // Requete ajax pour recuperer le reste du formulaire
        $('#formBienVenduPart2').html("");
        $.get(
            '{getLinkAdm("bien/ajaxGetDataForVenduByAgence/{$Bien->id}")}', {literal}
            {nohtml:'nohtml'},
            function(data){ $('#formBienVenduPart2').html(data); }
        );{/literal}
    }
}

(function($){
    $.get(
        '{$Helper->getLinkAdm("bien/getHistorique/{$Bien->id}")}', {literal}
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
        '{$Helper->getLinkAdm("bien/getPrixHistorique/{$Bien->id}")}', {literal}
        {nohtml:'nohtml'},
        function(data){ 
            var tplHistorique = "<tr><td>{{prix}}</td><td>{{prix_on}}</td>";
            for( var i in data ){
                $('#tableauHistoriquePrix').append( Mustache.render(tplHistorique, data[i]) );
            }
;
        },'json'); {/literal}
})(jQuery);

$(document).ready(function() {
    jQuery("#formAddVisite").validationEngine();
    jQuery("#formBienVendu").validationEngine();
    $("a#fbfichebiensite").fancybox();
    $("a#fbformphoto").fancybox();
    $('#date_visite').mask("99/99/9999");
    $('#heure_visite').mask("99:99");
});

function deletePhoto(photo, bien){
    if( confirm('{$lang.Confirm_suppression_photo} ?') ){
        /* REQUETE AJAX SUPPRESSION */
        $.get(
            '{$Helper->getLinkAdm("bien/photoDelete/'+bien+'")}', {literal}
            {nohtml:'nohtml',photo:photo},
            function(data){ $('#gallery').html(data); }
        );{/literal}
    }
}

$(".chzn-select").chosen();
//-->
</script>