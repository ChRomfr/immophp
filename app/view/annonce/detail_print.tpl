<div id="annonce_detail_contener">
    <div class="annonce_detail_header"></div>
    <div class="annonce_detail_titre">
        <div class="adt_titre"><h1>{$Annonce.nom}</h1></div>
    </div>
    
        <ul>
            <li>{$lang.Reference} : {$Annonce.reference}</li>
            <li>{$lang.Prix} : {$Annonce.prix|number_format:0:'.':' '} {$config.devise} FAI</li>
            <li>{$lang.Surface} : {if !empty($Annonce.surface) && $Annonce.surface > 0}{$Annonce.surface} m²{else}-{/if}</li>
           {if !empty($Annonce.piece) && $Annonce.piece > 0}<li>{$lang.Pieces} : {$Annonce.piece}</li>{/if}
           {if !empty($Annonce.champbre) && $Annonce.champbre > 0}<li>{$lang.Chambres} : {$Annonce.champbre}</li>{/if}
           {if !empty($Annonce.sdb) && $Annonce.sdb > 0}<li>{$lang.Salle_de_bain} : {$Annonce.sdb}</li>{/if}
           {if !empty($Annonce.wc) && $Annonce.wc > 0}<li>{$lang.WC} : {$Annonce.wc}</li>{/if}
           {if !empty($Annonce.parking) && $Annonce.parking > 0}<li>{$lang.Parking} : {$Annonce.parking}</li>{/if}
        </ul>
     <hr/>
     <div>{$Annonce.description|nl2br}</div>
     <hr/>
    
    <div class="annonce_detail_dep">
        {if !empty($Annonce.conso_energ)}
        <img src="{$config.url}{$config.url_dir}web/images/ce/{$Annonce.conso_energ}.gif" alt="" style="width:149px;"/>
        {/if}
        {if !empty($Annonce.emission_ges)}
        <img src="{$config.url}{$config.url_dir}web/images/eg/{$Annonce.emission_ges}.gif" alt="" style="width:149px;"/>
        {/if}
    </div>
    <hr/>
    <!-- AFFICHAGE DES PHOTOS -->
    {foreach $Annonce.photos as $k => $v}
     <img src="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce.id}/{$v}" alt="{$Annonce.nom}" style="width:300px;" />   
    {/foreach}
</div>
