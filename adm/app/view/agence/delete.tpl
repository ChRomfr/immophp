<script type="text/javascript">
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#formAgenceDelete").validationEngine();
});
</script>
<!-- BREAD -->
<div id="bread">
	<a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a>{$smarty.const.BREAD_SEP}
	<a href="{getLinkAdm("agence")}" title="{$lang.Agence}">{$lang.Agence}</a>{$smarty.const.BREAD_SEP}
	{$lang.Supprimer}
</div>

<div class="showData">
    <h1>{$lang.Supprimer_une_agence}</h1>
    {if $NbAgence < 2}
        <div class="center"><span style="color:red; font-weight: bold;">{$lang.Impossible_de_supprimer_cette_agence}</span></div>
    {else}
        <form method="post" id="formAgenceDelete" action="#">
        
            <label for="agence_id">{$lang.Transferer_les_annonces_vers_agence} :</label>
            <select name="agence[agence_id_remplace]" required class="validate[required]" id="agence_id">
                <option></option>
                {foreach $Agences as $Row}
                <option value="{$Row.id}">{$Row.nom}</option>
                {/foreach}
            </select>
            <input type="submit" value="{$lang.Supprimer}" />
        </form>
    {/if}
</div>
 