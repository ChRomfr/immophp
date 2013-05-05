<htmlpageheader name="MyHeader1">
<div style="text-align: right; border-bottom: 1px solid #000000; font-weight: bold; font-size: 10pt;">{$config.titre_site}</div>
</htmlpageheader>

<htmlpagefooter name="MyFooter1">
<div style="text-align: right; border-bottom: 1px solid #000000; font-weight: bold; font-size: 10pt;">{$config.url}{$config.url_dir}annonce/detail/{$Bien->id}</div>
</htmlpagefooter>

<sethtmlpageheader name="MyHeader1" value="on" show-this-page="1" />
<sethtmlpagefooter name="MyFooter1" value="on" />

<h3>{$Bien->nom}</h3>
<br/>
<div style="width:95%, margin:auto;">{$Bien.description}</div>
<br/><br/>   
<table class="table">
    <tr>
        <td>{$lang.Type} :</td><td><strong>{if $Bien->categorie != ''} {$Bien->categorie}{/if}</strong></td>
    </tr><tr>
    	<td>{$lang.Ville} :</td><td><strong>{$Bien->ville}</strong></td>>
    </tr><tr> 
	   <td>{$lang.Prix} :</td><td><strong>{$Bien->prix}</strong> {$config.devise} <em><small>F.A.I.</small></em></td>
    </tr><tr>
	   <td>{$lang.Reference} :</td><td><strong>{$Bien->reference}</strong></td>
    </tr><tr>
	   <td>{$lang.Agence} :</td><td><strong>{$Bien->agence}</strong></td>
    </tr>
</table>
<br/>

<table class="table">
    {if !empty($Bien->surface)}<tr><td>{$lang.Surface} :</td><td><strong>{$Bien->surface} m&sup2;</strong></td></tr>{/if}
    {if !empty($Bien->piece)}<tr><td>{$lang.Pieces} :</td><td><strong>{$Bien->piece}</strong></td></tr>{/if}
    {if !empty($Bien->champbre)}<tr><td>{$lang.Chambres} :</td><td><strong>{$Bien->chambre}</strong></td></tr>{/if}
    {if !empty($Bien->sdb)}<tr><td>{$lang.Salle_de_bain} :</td><td><strong>{$Bien->sdb}</strong></td></tr>{/if}
    {if !empty($Bien->wc)}<tr><td>WC :</td><td><strong>{$Bien->wc}</strong></td></tr>{/if}
    {if !empty($Bien->parking)}<tr><td>{$lang.Parking} :</td><td><strong>{$Bien->parking}</strong></td></tr>{/if}
</table>

{if !empty($Bien->conso_energ) && !empty($Bien->emission_ges)}
<div style="text-align:center">
    <img src="{$config.url}{$config.url_dir}web/images/ce/{$Bien->conso_energ}.gif" alt="" style="width:149px;"/>    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="{$config.url}{$config.url_dir}web/images/eg/{$Bien->emission_ges}.gif" alt="" style="width:149px;"/>
</div>
{/if}
<br/><br/>
<!-- TABLEAU PHOTOS-->
<table style="margin:auto; width:95%" cellpadding="1" cellspacing="3">
    <tr>
        {foreach $Bien->photos as $k => $v name=photosliste}
        <td><img src="{$config.url}{$config.url_dir}web/upload/bien/{$Bien->id}/{$v}" alt="" style="width:200px;" /></td>
        {if $smarty.foreach.photosliste.iteration % 3 == 0}
    </tr><tr>
        {/if}
        {/foreach}
    </tr>
</table>