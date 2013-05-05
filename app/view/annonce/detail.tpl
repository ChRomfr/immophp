<script>
<!--
jQuery(document).ready(function(){
    // binds form submission and fields to the validation engine
    jQuery("#formContactAnnonce").validationEngine();
});


$(function() {
    $("a[rel=group_images]").fancybox({
        'transitionIn'      : 'none',
        'transitionOut'     : 'none',
        'titlePosition'     : 'over',
        'titleFormat'       : function(title, currentArray, currentIndex, currentOpts) {
            return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
        }
    });
});
//-->
</script>
{strip}
<div id="annonce_detail_contener">
    <div class="annonce_detail_header">
        <div class="annonce_detail_header_retour">
            <a href="javascript:history.back();" title="{$lang.Retour}">{$lang.Retour}</a>
       </div>
       <div class="annonce_detail_header_print">
            <a href="{$Helper->getLink("annonce/pdf/{$Annonce->id}")}" target="_blank" title="Pdf"><i class="icon-print"></i></a>
       </div>
    </div>
    <div class="annonce_detail_titre">
        <div class="adt_titre"><h4>{$Annonce->nom}</h4> </div>
        <div class="adt_ref">{$Annonce->reference}{if $Annonce->exclusif == 1}<br/><span class="label label-info">Exclusivite</span>{/if}</div>
        <div class="clear"></div>
    </div>
        
    <!-- INFOS -->
    <div class="annonce_detail_top_infos">
        <div class="annonce_detail_top_infos_surface">{if !empty($Annonce->surface) && $Annonce->surface > 0}{$Annonce->surface} m&sup2;{else}-{/if}</div>
        <div class="annonce_detail_top_infos_prix">
            {if $Annonce->vendu == 0}
                {if !empty($Annonce->prix)}{$Annonce->prix|number_format:0:'.':' '} {$config.devise} FAI{/if}
            {else}
                {$lang.Vendu}
            {/if}
        </div>
    </div>
     <div class="clear"></div>
     
    <!-- PHOTOS -->
    <div class="annonce_detail_photo">
        {if !empty($Annonce->video_code)}
        <!-- On affiche la video -->
        <div class="annonce_detail_video">{$Annonce->video_code}</div>
        {elseif isset($Annonce->photo) && !empty($Annonce->photo)}
        <!-- On affiche une photo -->
        <a rel="group_images" href="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce->id}/{$Annonce->photo}" title="{$Annonce->nom}">
            <img src="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce->id}/{$Annonce->photo}" alt="{$Annonce->nom}" style="width:310px; height:270px;" />
        </a>
        {/if}
        {foreach $Annonce->photos as $k => $v}
            {if isset($Annonce->photo) && $v != $Annonce->photo}
            <a rel="group_images" href="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce->id}/{$v}" title="{$Annonce->nom}">
                <img src="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce->id}/{$v}" alt="{$Annonce->nom}" style="width:50px;" />   
            </a>
            {else}
            <a rel="group_images" href="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce->id}/{$v}" title="{$Annonce->nom}">
                <img src="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce->id}/{$v}" alt="{$Annonce->nom}" style="width:50px;" />   
            </a>
            {/if}
        {/foreach}
    </div>
    
    <!-- DESCRIPTION -->
    <div class="annonce_detail_description">
        {$Annonce->description|nl2br}
    </div>
    
    <div class="clear"></div>
    
    <div class="annonce_detail_dep">
        {if !empty($Annonce->conso_energ)}
        <img src="{$config.url}{$config.url_dir}web/images/ce/{$Annonce->conso_energ}.gif" alt="" style="width:149px;"/>
        {/if}
        {if !empty($Annonce->emission_ges)}
        <img src="{$config.url}{$config.url_dir}web/images/eg/{$Annonce->emission_ges}.gif" alt="" style="width:149px;"/>
        {/if}
    </div>
    
    <div class="annonce_detail_infos">
        <table class="table">
           {if !empty($Annonce->surface) && $Annonce->surface > 0}<tr><td style="width:50%;">{$lang.Surface}</td><td style="width:50%;">{$Annonce->surface} m&sup2;</td></tr>{/if}
           {if !empty($Annonce->piece) && $Annonce->piece > 0}<tr><td style="width:50%;">{$lang.Pieces}</td><td style="width:50%;">{$Annonce->piece}</td></tr>{/if}
           {if !empty($Annonce->champbre) && $Annonce->champbre > 0}<tr><td style="width:50%;">{$lang.Chambres}</td><td style="width:50%;">{$Annonce->champbre}</td></tr>{/if}
           {if !empty($Annonce->sdb) && $Annonce->sdb > 0}<tr><td style="width:50%;">{$lang.Salle_de_bain}</td><td style="width:50%;">{$Annonce->sdb}</td></tr>{/if}
           {if !empty($Annonce->wc) && $Annonce->wc > 0}<tr><td style="width:50%;">{$lang.WC}</td><td style="width:50%;">{$Annonce->wc}</td></tr>{/if}
           {if !empty($Annonce->parking) && $Annonce->parking > 0}<tr><td style="width:50%;">{$lang.Parking}</td><td style="width:50%;">{$Annonce->parking}</td></tr>{/if}
        </table>
    </div>
    <div class="clear"></div>
   
    <!-- CONTACT -->
    <div class="annonce_detail_form_contact">
        <form id="formContactAnnonce" method="post" action="{getLink("annonce/contact/{$Annonce->id}")}">
            <h1>{$lang.Nous_contacter}</h1>
             <div style="float:left; width:49%">
                <div class="ChampForm">                    
                    <input type="text" name="contact[nom]" id="nomContact" required class="validate[required]" />
                    <label for="nomContact" style="display:block;">{$lang.Nom} *</label>
                </div>
                <!-- Telephone -->
                <div class="ChampForm">
                    <label for="telephone">{$lang.Telephone} *</label>
                    <input type="text" name="contact[telephone]" id="telephone" required class="validate[required]" />
                </div>
                <!-- Email -->
                <div class="ChampForm">
                    <label for="email">{$lang.Email} *</label>
                    <input type="email" name="contact[email]" id="email" required class="validate[required,custom[email]]" />
                </div>
            </div>
            <div style="float:right;">
                <!-- Message -->
                <div class="ChampForm">
                    <label for="message">{$lang.Message} *</label>
                    <textarea name="contact[message]" id="message" class="validate[required]" required></textarea>
                </div>
            </div>
            <div class="clear"></div>
            <input type="hidden" name="contact[bien_id]" value="{$Annonce->id}" />
            <input type="submit" value="{$lang.Envoyer}" />
        </form>
    </div>
</div>
{/strip}
<script>
$(".ChampForm input, textarea").focus(function() {
    $(this).parents(".ChampForm").find("label").hide();
});

$(".ChampForm input, textarea").blur(function() {
    if ($(this).val() == "")
        $(this).parents(".ChampForm").find("label").show();
});

$(".ChampForm input, textarea").each(function() {
    if ($(this).val() != "")
        $(this).parents(".ChampForm").find("label").hide();
});
</script>