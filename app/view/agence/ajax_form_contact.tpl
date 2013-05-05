 <!-- CONTACT -->
<div class="annonce_detail_form_contact">
    <form id="formContactAgence" method="post" action="{getLink("agence/contact/{$agence_id}")}">
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
        <div style="float:left;">
            <!-- Message -->
            <div class="ChampForm">
                <label for="message">{$lang.Message} *</label>
                <textarea name="contact[message]" id="message" class="validate[required]" required></textarea>
            </div>
        </div>
        <div class="clear"></div>
        <input type="hidden" name="contact[agence_id]" value="{$agence_id}" />
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