{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
    {if isset($smarty.get.ref)}
     <li><a href="{getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a><span class="divider">/</span></li>
     <li>#{$smarty.get.ref}</li>
    {elseif isset($smarty.get.seuil_mensuel)}
    <li><a href="{getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a><span class="divider">/</span></li>
    <li>sous le seuil de visite mensuel {$smarty.get.month_seuil} / {$smarty.get.year_seuil}</li>
    {elseif isset($smarty.get.seuil_hebdomadaire)}
    <li><a href="{getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a><span class="divider">/</span></li>
    <li>sous le seuil de visite hebdomaire : semaine : {$Date_infos.week_number} {$Date_infos.first_day_FR} - {$Date_infos.last_day_FR}</li>
    {else}
        <li>{$lang.Biens}</li>
    {/if}
</ul>

<!-- LISTE DES ANNONCES -->
<div class="well">
    
    <div class="pull-right">
        <a href="#modelfiltrebiens" role="button" data-toggle="modal"><i class="icon-search"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="{getLinkAdm("bien/add")}" title=""><i class="icon-plus"></i></a>
    </div>
    
    <h4>{$lang.Biens}</h4>
    
    <div class="clearfix"></div>
    
    <div class="pull-right">
        <form method="get" action="#">
            <div class="input-append">
                <input type="text" name="ref" placeholder="{$lang.Reference}"/>
                <button type="submit" class="btn"><i class="icon-search"></i></button>
            </div>
        </form>
    </div>
    <div class="clearfix"></div>
    <table class="table table-bordered table-striped table-condensed">
        <thead>
            <tr>
                <th>{$lang.Reference}</th>
                <th>{$lang.Bien}</th>
                <th>{$lang.Categorie}</th>
                <th>{$lang.Transaction}</th>
                <th>{$lang.Agence}</th>
                {if isset($Biens.0.nbVisite)}<th>{$lang.Visites}</th>{/if}
                <th>{$lang.En_ligne}</th>
                <th>{$lang.Vendu}</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach $Biens as $Row}
                <tr>
                    <td><a href="{getLinkAdm("bien/fiche/{$Row.id}")}" title="">{$Row.reference}</a></td>
                    <td>{$Row.nom}</td>
                    <td>{$Row.categorie}</td>
                    <td>{$Row.transaction_type}</td>
                    <td>{$Row.agence}</td>
                    {if isset($Row.nbVisite)}<td style="text-align:center">{$Row.nbVisite}</td>{/if}
                    <td style="text-align:center">
                        <img src="{$config.url}{$config.url_dir}web/images/{if $Row.visible == 1}okSmall.png{elseif $Row.visible == 0}noSmall.png{/if}" alt="" />
                    </td>
                    <td style="text-align:center">
                        <img src="{$config.url}{$config.url_dir}web/images/{if $Row.vendu == 1}okSmall.png{elseif $Row.vendu == 0}noSmall.png{/if}" alt="" />
                    </td>
                    <td style="text-align:center">
                        <a href="{getLinkAdm("bien/edit/{$Row.id}")}" title="{$lang.Edition}"><i class="icon-pencil"></i></a>&nbsp;&nbsp;
                        <a href="javascript:deleteBien({$Row.id})" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    <div class="clearfix"></div>
    <div class="Pagination">{$Pagination->render()}</div>

</div>

<div class="modal hide fade" id="modelfiltrebiens">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    </div>
    <div class="modal-body">
        <form method="get" class="form-search well">
            <label><a href="#" class="tooltip-test" title="Selectionner un jour dans la semaine a verifier">Annonce sous le seul de visite hebdomadaire</a></label>
             <input type="text" id="dayweek" name="dayweek" class="input-small"/>
             <button type="submit" class="btn btn-primary" name="seuil_hebdomadaire">Recherche</button>
        </form>

        <form method="get" class="form-search well">
            <label>Annonces sous le seuil de visite mensuel :</label>
            <select name="year_seuil" class="input-small">
                <option></option>
                {foreach $Years as $k => $v}
                <option value="{$v}">{$v}</option>
                {/foreach}
            </select>
            <span class="divider">/</span>
            <select name="month_seuil" class="input-small">
                <option></option>
                {foreach $Months as $k => $v}
                <option value="{$v}">{$v}</option>
                {/foreach}
            </select>
            <button type="submit" class="btn btn-primary" name="seuil_mensuel">Recherche</button>
        </form>
    </div>
    <div class="modal-footer"></div>
</div>
{/strip}
<script type="text/javascript">
<!--
$(function() {
    $( "#dayweek" ).datepicker({ dateFormat: 'dd/mm/yy', changeMonth:true, changeYear:true, showButtonPanel: true,showWeek:true,firstDay:1 });
});

function deleteBien(bien_id){
    if( confirm('{$lang.Confirm_suppression_bien} ?') ){
        window.location.href = '{getLinkAdm("bien/delete/'+ bien_id +'")}';
    }
}
-->
</script>