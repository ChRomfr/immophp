{strip}<div class="blok">
    <div id="blokRechercheBien">
        <!-- START TITRE BLOK -->
        <div class="bloc_gauche_titre">{$lang.Recherche}</div>
        <!-- END TITRE BLOK -->

        <!-- START CONTENU BLOK-->
        <div class="bloc_gauche_corp">
            <form method="get" action="{getLink("annonce")}">
                <div class="center">
                <input type="radio" name="criteres[transaction]" value="vente" {if isset($smarty.get.criteres.transaction) && $smarty.get.criteres.transaction == 'vente'}checked="checked"{elseif !isset($smarty.get.criteres.transaction)}checked="checked"{/if}/>&nbsp;<span><strong>{$lang.Vente}</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="criteres[transaction]" value="loc" {if isset($smarty.get.criteres.transaction) && $smarty.get.criteres.transaction == 'loc'}checked="checked"{/if} />&nbsp;<span><strong>{$lang.Location}</strong></span>
                </div>

                {if count($Agences) > 0}
                <label for="">Agence :</label><br/>
                <select name="criteres[agence]">
                    <option>{$lang.Indifferent}</option>
                    {foreach $Agences as $Row}
                    <option value="{$Row.id}" {if isset($smarty.get.criteres.agence) && ($smarty.get.criteres.agence == $Row.id)}selected="selected"{/if}>{$Row.nom}</option>
                    {/foreach}
                </select>
                {/if}

                <br/>
                
                <!-- TYPE DE BIEN -->
                <label for="">{$lang.Type_de_bien} :</label><br/>
                <select name="criteres[categorie]">
                    <option>{$lang.Indifferent}</option>
                    {foreach $Categories as $Row}
                    <option value="{$Row.id}" {if isset($smarty.get.criteres.categorie) && $smarty.get.criteres.categorie == $Row.id}selected="selected"{/if}>{$Row.name}</option>
                    {/foreach}
                </select>
                
                <br/>
                
                <!-- BUDGET -->
                <label for="">{$lang.Budget} :</label><br/>
                <input type="text" name="criteres[prix_min]" value="{if isset($smarty.get.criteres.prix_min) && !empty($smarty.get.criteres.prix_min)}{$smarty.get.criteres.prix_min}{else}{$lang.Min}{/if}" /><span class="devise">{$config.devise}</span>
                <div class="blokRechercheSeparator"></div>
                <input type="text" name="criteres[prix_max]" value="{if isset($smarty.get.criteres.prix_max) && !empty($smarty.get.criteres.prix_max)}{$smarty.get.criteres.prix_max}{else}{$lang.Max}{/if}" /><span class="devise">{$config.devise}</span>
                <div class="clear"></div>
                <br/>
                
                <!-- SURFACE -->
                <label for="">{$lang.Surface} :</label><br/>
                <input type="text" name="criteres[surface_min]" value="{if isset($smarty.get.criteres.surface_min) && !empty($smarty.get.criteres.surface_min)}{$smarty.get.criteres.surface_min}{else}{$lang.Min}{/if}" /><span class="devise">m&sup2;</span>
                <div class="blokRechercheSeparator"></div>
                <input type="text" name="criteres[surface_max]" value="{if isset($smarty.get.criteres.surface_max) && !empty($smarty.get.criteres.surface_max)}{$smarty.get.criteres.surface_max}{else}{$lang.Max}{/if}" /><span class="devise">m&sup2;</span>
                <div class="clear"></div>
                
                <br/>
                
                <!-- BOUTON RECHERCHE -->
                <div class="blokRechercheSubmit">
                    <input type="submit" value="{$lang.Rechercher}" />
                </div>
            </form>
        </div>
        <!-- END CONTENU BLOK-->

        <!-- START FOOTER BLOK -->
        <div class="bloc_gauche_footer"></div>
        <!-- END FOORTER BLOK -->
    </div>
</div>{/strip}