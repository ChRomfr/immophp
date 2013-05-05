
<script>
<!--
{if !isset($smarty.get.nohtml)}
$(document).ready(function() {
    jQuery("#formAddCompteRendu").validationEngine();
    $("a#fbprospectfiche").fancybox();
    $("a#fbbienfiche").fancybox();
    $("a#fbformcompterendu").fancybox();
});
{/if}

{if isset($smarty.get.showform)}
$(document).ready(function() {
    $("#fbformcompterendu").fancybox().trigger('click');
})
{/if}

//-->
</script>
{strip}
{if !isset($smarty.get.nohtml)}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{getLinkAdm("visite")}" title="{$lang.Visites}">{$lang.Visites}</a><span class="divider">/</span></li>
	<li>{$lang.Detail}</li>
</ul>
{/if}

<div class="well">
    <h4>{$lang.Visite} : {$Visite.date_visite} {$Visite.heure_visite}</h4>
    <div class="table">
        <table>
            <tr>
                <td>{$lang.Date}</td>
                <td>{$Visite.date_visite} {$Visite.heure_visite}</td>
            </tr>
            <tr>
                <td>{$lang.Prospect}</td>
                <td><a href="{getLinkAdm("prospect/fiche/{$Visite.prospect_id}")}" id="fbprospectfiche">{$Visite.p_nom} {$Visite.p_prenom}</a></td>
            </tr>
            <tr>
                <td>{$lang.Bien}</td>
                <td><a href="{getLink("annonce/detail/{$Visite.bien_id}")}" id="fbbienfiche">{$Visite.bien}</td>
            </tr>
            <tr>
                <td>{$lang.Compte_rendu}</td>
                <td>
                    {if empty($Visite.compte_rendu)}
                        {if isset($smarty.get.nohtml)}
                            <a href="{$Helper->getLinkAdm("visite/detail/{$Visite.id}?showform")}" title)"" class="btn">{$lang.Compte_rendu}</a>
                        {else}
                            <a href="#formcompterendu" id="fbformcompterendu" title="" class="btn">{$lang.Compte_rendu}</a>
                        {/if}
                    {else}
                        {$Visite.compte_rendu|nl2br}
                    {/if}
                </td>
            </tr>
        </table>
    </div>
</div>

{if empty($Visite.compte_rendu)}
<div style="display:none">
    <div id="formcompterendu">   
        <form method="post" action="{getLinkAdm("visite/addCompteRendu/{$Visite.id}")}" class="" id="formAddCompteRendu">
            <div>
                <label for="compte_rendu">{$lang.Compte_rendu} :</label><br/>
                <textarea name="visite[compte_rendu]" id="compte_rendu" rows="5" cols="50" class="validate[required]" required></textarea>
            </div>
            <div class="center">
                <input type="hidden" name="visite[id]" value="{$Visite.id}" />
                <input type="submit" value="{$lang.Enregistrer}" />
            </div>
        </form>
    </div>
</div>
{/if}

{/strip}