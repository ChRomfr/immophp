{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("utilisateur")}" title="{$lang.Profil}">{$lang.Profil}</a><span class="divider">/</span></li>
	<li>{$lang.Changement_de_mot_de_passe}</li>
</ul>

<form method="post" id="changepassword" class="form-horizontal well">
	<fieldset>
		<legend>{$lang.Changement_de_mot_de_passe}</legend>
		<div class="control-group">
			<label class="control-label">{$lang.Ancien} :</label>
			<div class="controls"><input type="password" name="password[ancien]" id="ancien" class="validate[required]" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="password">{$lang.Mot_de_passe} :</label>
			<div class="controls"><input type="password" name="password[nouveau]" id="password" class="validate[required,minSize[6]]" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="password2">{$lang.Confirmation} :</label>
			<div class="controls"><input type="password" name="password[confirmation]" id="password2" class="validate[required,equals[password]]" /></div>
		</div>
		<div class="form_submit center">
			<input type="hidden" name="token" value="{$smarty.session.token}" />
			<input type="submit" name="send" value="{$lang.Enregistrer}" />
		</div>
	</fieldset>
</form>
{/strip}
<script>
<!--
jQuery(document).ready(function(){
	$('#changepassword').validate({
		rules: {
			'password[ancien]': 'required',
			'password[nouveau]':{
				required: true,
				minlength:6
			},
			'password[confirmation]':{
				required:true,
				equalTo:'#password',
				minlength:6
			},	
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
	})
});
//-->
</script>