{strip}
{if $config.annuaire_submit_onlymember == 1 && $smarty.session.utilisateur.id == 'Visiteur'}
<div style="padding-top:100px">
	<div class="alert alert-info">
		<div style="text-align:center;">
			Vous devez être <a href="{$Helper->getLink("connexion")}" title="M'identifier">identifier</a> ou <a href="{$Helper->getLink("utilisateur/register")}" title="Devenir membre">être membre</a> pour proposer un site dans notre annuaire
		</div>
	</div>
</div>
{else}

<form method="post" action="" id="FormProposer" class="form-horizontal well">
	{if isset($Error) && !empty($Error)}
	<div class="alert">
		<ul>
			{$Error}
		</ul>
	</div>
	{/if}
	<fielset>
		
		<legend>Proposer un site</legend>

		{if $config.annuaire_site_backlink_required}
		<div class="alert alert-warning">
			<div style="text-align:center">Lien de retour obligatoire</div>
		</div>
		{/if}

		{if !empty($config.annuaire_regle_soumission)}
		<div class="alert alert-info">
			<div style="text-align:center">{$config.annuaire_regle_soumission}</div>
		</div>
		{/if}
		
		<!-- Nom du site -->
		<div class="control-group">
			<label for="name" class="control-label">Nom du site :</label>
			<div class="controls">
				<input type="text" name="site[name]" id="name" required/>
			</div>
		</div>

		<!-- Url -->
		<div class="control-group">
			<label for="url" class="control-label">Adresse :</label>
			<div class="controls">
				<input type="url" name="site[url]" id="url" required/>
			</div>
		</div>

		<!-- Categorie -->
		<div class="control-group">
			<label class="control-label" for="categorie_id">{$lang.Categorie} :</label>
			<div class="controls">
				<select name="site[categorie_id]">
					<option></option>
					{foreach $categories as $cat}
					<option value="{$cat.id}">{str_repeat(">",{$cat.level})}{$cat.name}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<!-- Resume -->
		<div class="control-group">
			<label for="resume" class="control-label">Resume :</label>
			<div class="controls">
				<textarea name="site[resume]" id="resume" required class="input-xxlarge" rows="4"></textarea>
			</div>
		</div>

		<!-- Description -->
		<div class="control-group">
			<label for="description" class="control-label">Description :</label>
			<div class="controls">
				<textarea name="site[description]" id="description" required class="input-xxlarge" rows="4"></textarea>
			</div>
		</div>

		{if $config.annuaire_site_keyword == 1}
		<!-- Keyword -->
		<div class="control-group">
			<label for="keywords" class="control-label">Mots clé :</label>
			<div class="controls">
				<textarea name="site[keywords]" id="keywords" required class="input-xxlarge" rows="2"></textarea>
				<span class="help-block">Mot clé separé par des ,</span>
			</div>
		</div>
		{/if}

		<!-- Facebook -->
		<div class="control-group">
			<label for="facebook" class="control-label"><i class="icon-facebook-sign icon-large"></i></label>
			<div class="controls">
				<input type="url" name="site[facebook]" id="facebook" />
			</div>
		</div>

		<!-- Twitter -->
		<div class="control-group">
			<label for="twitter" class="control-label"><i class="icon-twitter-sign icon-large"></i></label>
			<div class="controls">
				<input type="url" name="site[twitter]" id="twitter" />
			</div>
		</div>
		
		<!-- Googleplus -->
		<div class="control-group">
			<label for="googleplus" class="control-label"><i class="icon-google-plus-sign icon-large"></i></label>
			<div class="controls">
				<input type="url" name="site[googleplus]" id="googleplus" />
			</div>
		</div>

		{if $config.annuaire_site_rss == 1}
		<!-- Flux 1 -->
		<div class="control-group">
			<label for="flux_rss_1" class="control-label"><i class="icon-rss icon-large"></i></label>
			<div class="controls">
				<input type="url" name="site[flux_rss_1]" id="flux_rss_1" />
			</div>
		</div>

		<!-- Flux 2 -->
		<div class="control-group">
			<label for="flux_rss_2" class="control-label"><i class="icon-rss icon-large"></i></label>
			<div class="controls">
				<input type="url" name="site[flux_rss_2]" id="flux_rss_2" />
			</div>
		</div>
		{/if}
		
		<!-- Url backling-->
		<div class="control-group">
			<label for="backlink" class="control-label">Adresse du lien de retour :</label>
			<div class="controls">
				<input type="url" name="site[backlink]" id="backlink" />
				<span class="help-block"><a href="{$Helper->getLink("annuaire/lienderetour")}" target="_blank"><small>{$lang.Lien_de_retour}</small></a></span>
			</div>
		</div>

		<div class="control-group">
			<label for="backlink" class="control-label">Email :</label>
			<div class="controls">
				<input type="email" name="site[email]" id="email" required {if isset($smarty.session.utilisateur.email)}value="{$smarty.session.utilisateur.email}"{/if}/>
			</div>
		</div>

	</fielset>

	<div class="form-actions">
		{if $smarty.session.utilisateur.id != 'Visiteur'}
		<input type="hidden" name="site[user_id]" value="{$smarty.session.utilisateur.id}" />
		{/if}

		<button type="submit" class="btn btn-primary"><i class="icon-save"> Soumettre</i></button>
	</div>

</form>
{/if}
{/strip}
<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	$("#FormProposer").validate({
		rules:{
			"site[name]":{
				required:true,
				minlength:4,
			},
			"site[url]":{
				required:true,
				url:true,
			},
			"site[categorie_id]":{
				required:true
			},
			"site[resume]":{
				required:true,
				minlength:{$config.annuaire_min_length_resume},
			},
			"site[description]":{
				required:true,
				minlength:{$config.annuaire_min_length_description},
			},
			"site[facebook]":{
				url:true,
			},
			"site[twitter]":{
				url:true,
			},
			"site[googleplus]":{
				url:true,
			},
			"site[backlink]":{
				{if $config.annuaire_site_backlink_required == 1}
				required:true,
				{/if}
				url:true,
			},
			"site[email]":{
				required:true,
				email:true,
			},
		},
		messages:{
		},
		highlight:function(element)
        {
            $(element).parents('.control-group').removeClass('success');
            $(element).parents('.control-group').addClass('error');
        },
        unhighlight: function(element)
        {
            $(element).parents('.control-group').removeClass('error');
            $(element).parents('.control-group').addClass('success');
        }
	});
});
$(document).ready(function()	{
    $('#description').markItUp(mySettings);

   // $('#emoticons a').click(function() {
    //    emoticon = $(this).attr("title");
    //    $.markItUp( { replaceWith:emoticon } );
   // });
});
//-->
</script>