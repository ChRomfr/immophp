{strip}
<div id="menu_admin_immo">
    <div class="menu_admin_immo_titre bloc_gauche_titre">Immobilier</div>
    <div class="menu_admin_immo_navigation bloc_gauche_corp">
        <ul class="rang1">
            
            <!-- BIENS -->
            <li class="smenu">
                <a href="{getLinkAdm("bien")}" title="{$lang.Biens}">{$lang.Biens}</a>
                
                    <ul class="rang2">
                        <li><a href="{getLinkAdm("bien/add")}" title="">{$lang.Ajouter}</a></li>
                        <li class="smenu">
                            <a href="{getLinkAdm("categorie?c=bien")}" title="">{$lang.Categorie}</a>                            
                            <ul class="rang3">
                                <li><a href="javascript:getFormCategorie();" title="">{$lang.Ajouter}</a></li>
                            </ul>                            
                        </li>
                    </ul>                 
            </li>
            
            <!-- AGENCES -->
            <li class="smenu">
                <a href="{getLinkAdm("agence")}" title="{$lang.Agences}">{$lang.Agences}</a>                
                    <ul class="rang2">
                        <li><a href="{getLinkAdm("agence/add")}" title="">{$lang.Ajouter}</a></li>
                    </ul>
            </li>
            
            <!-- CONTACT -->
            <li class="smenu">
                <a href="{getLinkAdm("contact")}" title="">{$lang.Contact}</a>
                <ul class="rang2">
                    <li><a href="{getLinkAdm("contact?type=biens")}" title="">{$lang.Biens}</a></li>
                    <li><a href="{getLinkAdm("contact?type=agences")}" title="">{$lang.Agences}</a></li>
                </ul>
            </li>
            
            <!-- PROSPECT -->
            {if $InfoInstall.prospect == 1}
            <li class="smenu">
                <a href="{getLinkAdm("prospect")}" title="{$lang.Prospects}">{$lang.Prospects}</a>
                <ul class="rang2">
                    <li><a href="{getLinkAdm("prospect/add")}" title="">{$lang.Ajouter}</a></li>
                </ul>
            </li>
            {/if}
            
            <!-- VISITES -->
            {if $InfoInstall.visite == 1}
            <li class="smenu">
                <a href="{getLinkAdm("visite")}" title="{$lang.Visites}">{$lang.Visites}</a>
                <ul class="rang2">
                    <li><a href="{getLinkAdm("visite/calendrier?nohtml")}" id="fbcalendriervisitemenu"><img src="{$config.url}{$config.url_dir}web/images/calendar.png" style="height:20px;" /></a></li>
                </ul>
            </li>
            {/if}
            
            <!-- MON COMPTE -->
            <li class="smenu">
                <a href="{getLinkAdm("moncompte")}" title="{$lang.Mon_compte}">{$lang.Mon_compte}</a>
                <ul class="rang2">
                    <li><a href="{getLinkAdm("moncompte/edit")}">{$lang.Edition}</a></li>
                </ul>
            </li>
            
            <!-- DECONNEXION -->
            <li class="smenu">
                <a href="{getLink("connexion/logout")}" title="{$lang.Deconnexion}">{$lang.Deconnexion}</a>
            </li>
        
        </ul>
    </div>
</div>
{/strip}