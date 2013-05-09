{strip}
    {if $config.index_carte_agence == 1}
    <!-- TROUVER UNE AGENCES -->
    <div id="CarteAgencesContener">
        <div class="carteAgenceTitre">{$lang.Trouver_une_agence}</div>
        <div>{$CarteAgence}</div>
    </div>
    {/if}

    {if !empty($config.index_contenu)}
    <!-- BLOC PUB GOOGLE -->
    <div id="PubInIndex">
        {$config.index_contenu}
    </div>
    {/if}

    <div class="clear"></div>

    {if !empty($config.index_page) && isset($Page) && !empty($Page->contenu)}
    <br/>
    <div class="well">{$Page->contenu}</div>
    {/if}

    {if $config.index_last_annonce == 1}
    <!-- DERNIERES ANNONCES -->
    <div class="well">
        <h3>{$lang.Dernieres_annonces}</h3>
        <div id="annonces_liste">
            {foreach $Annonces as $Annonce name=lannonce}
                <a href="{getLink("annonce/detail/{$Annonce.id}/{$Annonce.nom|urlencode}")}" title="{$Annonce.nom}" class="link_annonces_liste">
                <div class="annonce_contener">
                    <div class="annonce_titre">{$Annonce.nom}</div>
                    <div class="annonce_photo">
                        {if count($Annonce.photos) > 0 && isset($Annonce.photo)}
                            <img src="{$config.url}web/upload/bien/{$Annonce.id}/{$Annonce.photo}" alt="" style="width:220px; height:170;"/>                    
                        {/if}
                    </div>
                    <div class="annonce_description">{$Annonce.description|truncate:140}</div>
                    <div class="annonce_infos_pied">
                        {if !empty($Annonce.prix)}<span class="annonce_infos_prix">{$lang.Prix} : {$Annonce.prix|number_format:0:'.':' '} {$config.devise} FAI</span><br/>{/if}
                        <span class="annonce_infos_reference">{$lang.Reference} : {$Annonce.reference}</span>
                    </div>
                </div>
                </a>
                <div class="annonce_separator"></div>
                {if $smarty.foreach.lannonce.iteration%3 == 0}<div class="clear"></div><div class="annonce_separator_line"></div>{/if}
            {/foreach}
            <div class="clear"></div>
        </div>
    </div>
    {/if}
{/strip}