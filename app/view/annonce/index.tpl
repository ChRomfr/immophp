
<!--
    START ANNONCE/INDEX.TPL
-->
{strip}
<ul class="breadcrumb">
    <li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
    <li>{$lang.Annonces}</li>
</ul>

{if count($Annonces) > 0}
<div id="annonces_liste">
    <!-- START LINKS ORDER -->
        <div style="float:right; padding-right:25px; padding-bottom:3px;" id="annonce_link_order"></div>
        <div class="clear"></div>
    <!-- END LINKS ORDER -->
    {foreach $Annonces as $Annonce name=lannonce}
        <a href="{getLink("annonce/detail/{$Annonce.id}/{$Annonce.nom|urlencode}")}" title="{$Annonce.nom}" class="link_annonces_liste">
        <div class="annonce_contener">
            <div class="annonce_titre">{$Annonce.nom}</div>
            <div class="annonce_photo">
                {if count($Annonce.photos) > 0}
                    <img src="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce.id}/{$Annonce.photo}" alt="" style="width:220px; height:170;"/>                    
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
{if isset($Pagination) && !empty($Pagination)}
<div class="pagination">{$Pagination}</div>
{/if}
{else}
    <div class="center"><strong>Auncunes annonces</strong></div>
{/if}

<!-- Lien RSS si active -->
{if isset($xml_param)}
<div id="xmlSearch">
    <a href="{$Helper->getLink("xml/rss?nohtml{$xml_param}")}"><img src="{$config.url}{$config.url_dir}web/images/rss2.png" style="width:14px" alt="Flux RSS" /></a>
</div>
{/if}
{/strip}
<script>
<!--
// Recuperation de l url complete
var fullPath = $(location).attr('href');

// Suppression des parametres order si present
fullPath = fullPath.replace('&order=pc','');
fullPath = fullPath.replace('&order=pd','');
fullPath = fullPath.replace('&order=dc','');
fullPath = fullPath.replace('&order=dd','');
fullPath = fullPath.replace('?order=pc','');
fullPath = fullPath.replace('?order=pd','');
fullPath = fullPath.replace('?order=dc','');
fullPath = fullPath.replace('?order=dd','');

// Construction des liens de tri en JS
{if !isset($smarty.get.order)}
    var links = 'Trier par : Date <strong>+</strong>&nbsp;&nbsp;<a href="'+fullPath+'&order=dc" title="">-</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Prix <a href="'+fullPath+'&order=pd" title="">+</a>&nbsp;&nbsp;<a href="'+fullPath+'&order=pc" title="">-</a>';
    $('#annonce_link_order').html(links);
{else}

function getParameterByName(name)
{
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null)
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
}

var ThisOrder = getParameterByName('order');
var links = null;

// traitement des cas
if( ThisOrder == 'dd'){
    links = 'Trier par : Date <strong>+</strong>&nbsp;&nbsp;<a href="'+fullPath+'&order=dc" title="">-</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Prix <a href="'+fullPath+'&order=pd" title="">+</a>&nbsp;&nbsp;<a href="'+fullPath+'&order=pc" title="">-</a>';
}else if(ThisOrder == 'dc'){
    links = 'Trier par : Date : <a href="'+fullPath+'" title="">+</a> <strong>-</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Prix : <a href="'+fullPath+'&order=pd" title="">+</a> <a href="'+fullPath+'&order=pc" title="">-</a>';
}else if(ThisOrder == 'pc'){
    links = 'Trier par : Date : <a href="'+fullPath+'" title="">+</a> <a href="'+fullPath+'?order=dc" title="">-</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Prix : <a href="'+fullPath+'&order=pd" title="">+</a> <strong>-</strong>';
}else if(ThisOrder == 'pd'){
    links = 'Trier par : Date : <a href="'+fullPath+'" title="">+</a> <a href="'+fullPath+'?order=dc" title="">-</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Prix : <strong>+</strong> <a href="'+fullPath+'&order=pc" title="">-</a>';
}

$('#annonce_link_order').html(links);
{/if}

//-->
</script>
<!--
    END ANNONCE/INDEX.TPL
-->