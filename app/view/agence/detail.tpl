<div id="agence_detail_contener">
    <div class="agence_detail_titre">{$Agence.nom}</div>
    <div class="agence_detail_description">{$Agence.description|nl2br}</div>
    <div class="agence_detail_photo">{if !empty($Agence.photo)}<img src="{$config.url}{$config.url_dir}web/upload/agence/{$Agence.id}/{$Agence.photo}" alt="" />{/if}</div>
    <div class="clear"></div>
    <div class="agence_detail_coordonnees">
        <strong>{$Agence.nom}</strong><br/>
        {$Agence.adresse|nl2br}<br/>
        {$Agence.code_postal} {$Agence.ville}<br/>
        {if !empty($Agence.telephone)}T&eacute;l : {$Agence.telephone}<br/>{/if}
        {if !empty($Agence.fax)}Fax : {$Agence.fax}<br/>{/if}
    </div>
    <div class="agence_detail_map">{$Map}</div>
    <div class="clear"></div>
    
     <!-- CONTACT -->
    <div class="annonce_detail_form_contact">
        <form id="formContactAgence" method="post" action="{getLink("agence/contact/{$Agence.id}")}">
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
            <input type="hidden" name="contact[agence_id]" value="{$Agence.id}" />
            <input type="submit" value="{$lang.Envoyer}" />
        </form>
    </div>
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

    <!-- DERNIERES ANNONCES -->
    <div class="well">
        <h3>{$lang.Dernieres_annonces}</h3>
        <div id="annonces_liste">
            {foreach $Annonces as $Annonce name=lannonce}
                <a href="{getLink("annonce/detail/{$Annonce.id}/{$Annonce.nom|urlencode}")}" title="{$Annonce.nom}" class="link_annonces_liste">
                <div class="annonce_contener">
                    <div class="annonce_titre">{$Annonce.nom}</div>
                    <div class="annonce_photo">
                        {if count($Annonce.photos) > 0}
                            <img src="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce.id}/{$Annonce.photo}" alt="" style="width:220px; height:170px;"/>                    
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
            <div style="text-align:right">
            <a href="{getLink("annonce?criteres[agence]={$Agence.id}")}" title="{$lang.Toutes_les_annonces}" class="btn btn-primary">{$lang.Toutes_les_annonces}</a>
        </div>
        </div>
    </div>
</div>