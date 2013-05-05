<div id="CarteAgencesContener">
    <div class="carteAgenceTitre">{$lang.Nos_agences}</div>
    <div>{$CarteAgence}</div>
</div>
<div class="clear"></div>

<div id="annonces_liste">
    <!-- START LINKS ORDER -->
        <div style="float:right; padding-right:25px; padding-bottom:3px;" id="annonce_link_order"></div>
        <div class="clear"></div>
    <!-- END LINKS ORDER -->
    {foreach $Agences as $Agence name=lannonce}
        <a href="{getLink("agence/detail/{$Agence.id}/{$Agence.nom|urlencode}")}" title="{$Agence.nom}" class="link_annonces_liste">
        <div class="annonce_contener">
            <div class="annonce_titre">{$Agence.nom}</div>
            <div class="annonce_photo">
                {if !empty($Agence.photo)}
                    <img src="{$config.url}{$config.url_dir}web/upload/agence/{$Agence.id}/{$Agence.photo}" alt="" style="width:220px; height:170px;"/>                    
                {/if}
            </div>
            <div class="annonce_description">{$Agence.description|truncate:140}</div>
            <div class="annonce_infos_pied">
               
            </div>
        </div>
        </a>
        <div class="annonce_separator"></div>
        {if $smarty.foreach.lannonce.iteration%3 == 0}<div class="clear"></div><div class="annonce_separator_line"></div>{/if}
    {/foreach}
    <div class="clear"></div>
</div>