<!--
START PROSPECT/INDEX.TPL
-->
{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Prospect}</li>
</ul>

<div class="well">

    <div class="fright">
        <a href="#formFiltre" id="fbfomsearch"><i class="icon-search"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="{getLinkAdm("prospect/add")}" title=""><i class="icon-plus"></i></a>
    </div>

    <h4>{$lang.Prospect}</h4>

    <div class="clear"></div>

    <div class="fright">
        <div class="input-append">
            <input type="text" id="nom_search" /><button onclick="searchByNom();" class="btn btp-primary"><i class="icon-search"></i></button>
        </div>
    </div>
    <div class="clear"></div>

    <div id="listes_prospects">
        <table class="table table-bordered  table-condensed table-striped">
            <thead>
                <tr>
                    <th>{$lang.Prospect}</th>
                    <th>{$lang.Acheteur}</th>
                    <th>{$lang.Vendeur}</th>
                    <th>{$lang.Ajouter_le}</th>
                    <th>{$lang.Ajouter_par}</th>
                </tr>
            </thead>
            <tbody>
                {foreach $Prospects as $Row}
                <tr>
                    <td><a href="{$Helper->getLinkAdm("prospect/fiche/{$Row.id}")}" title="">{$Row.nom} {$Row.prenom}</a></td>
                    <td style="text-align:center;">{if $Row.acheteur == 1}<img src="{$config.url}{$config.url_dir}web/images/okSmall.png" alt="" />{else}<img src="{$config.url}{$config.url_dir}web/images/noSmall.png" alt="" />{/if}</td>
                    <td style="text-align:center;">{if $Row.vendeur == 1}<img src="{$config.url}{$config.url_dir}web/images/okSmall.png" alt="" />{else}<img src="{$config.url}{$config.url_dir}web/images/noSmall.png" alt="" />{/if}</td>
                    <td>{$Row.add_on_sql}</td>
                    <td>{$Row.user_add}</td>
                </tr>
                {/foreach}
            </tbody>
        </table>
        {if isset($Pagination) && !empty($Pagination)}
        <div id="pagination">
        {$Pagination}
        </div>
        {/if}
    </div>
</div><!-- /well -->

<div style="display:none">
    <div id="formFiltre">

        <form method="get" class="form-horizontal well">

            <div class="control-group">
                <label class="control-label">Vendeur :</label>
                <div class="controls">
                    <select name="filtre[vendeur]">
                        <option></option>
                        <option value="1">Oui</option>
                        <option value="0">Non</option>
                    </select>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label">Acheteur :</label>
                <div class="controls">
                    <select name="filtre[acheteur]">
                        <option></option>
                        <option value="1">Oui</option>
                        <option value="0">Non</option>
                    </select>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Agence :</label>
                <div class="controls">
                    <select name="filtre[agence_id]">
                        <option></option>
                        {foreach $Agences as $Row}
                        <option value="{$Row.id}">{$Row.nom}</option>
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary" name="seuil_mensuel">Recherche</button>
            </div>

        </form>

    </div>
</div>

{/strip}
<script>
function searchByNom(){
    search = $("#nom_search").val()
    $.get(
        '{getLinkAdm("prospect/ajaxSearchByNom/'+ search +'")}', {literal}
        {nohtml:'nohtml'},
        function(data){ $('#listes_prospects').html(data); }
    );{/literal}    
}

$(document).ready(function() {
    $("a#fbfomsearch").fancybox();
});
</script>
<!--
END PROSPECT/INDEX.TPL
-->