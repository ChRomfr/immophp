{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("utilisateur")}" title="{$lang.Utilisateurs}">{$lang.Utilisateurs}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>

<!-- FORMULAIRE -->
<form class="form-horizontal well" method="post" action="{$Helper->getLinkAdm("utilisateur/add")}" id="registerForm">
	<fielset>
		<legend>{$lang.Nouveau}</legend>
		<div class="control-group">
			<label class="control-label" for="identifiant">{$lang.Identifiant} :</label>
			<div class="controls"><input type="text" name="user[identifiant]" id="identifiant" required /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email">{$lang.Email} :</label>
			<div class="controls"><input type="email" name="user[email]" id="email" placeholder="{$lang.Votre_email}" required autocomplete="off" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="password">{$lang.Mot_de_passe} :</label>
			<div class="controls"><input type="password" name="user[password]" id="password" required /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="password2">{$lang.Confirmation} :</label>
			<div class="controls"><input type="password" name="user[password2]" id="password2" required /></div>
		</div>

		<div class="control-group">
				<label class="control-label" for="isAdmin">{$lang.Administrateur} :</label>
				<div class="controls">
					<select name="user[isAdmin]" id="isAdmin">
						<option value="0">{$lang.Non}</option>
						<option value="1">{$lang.Oui} - 1</option>
						<option value="2">{$lang.Oui} - 2</option>
						<option value="3">{$lang.Oui} - 3</option>
						<option value="4">{$lang.Oui} - 4</option>
						<option value="5">{$lang.Oui} - 5</option>
						<option value="6">{$lang.Oui} - 6</option>
						<option value="7">{$lang.Oui} - 7</option>
						<option value="8">{$lang.Oui} - 8</option>
						<option value="9">{$lang.Oui} - 9</option>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="actif">{$lang.Actif} :</label>
				<div class="controls">
					<select name="user[actif]">
						<option value="1">{$lang.Oui}</option>
						<option value="0">{$lang.Non}</option>
					</select>
				</div>
			</div>

		<div class="form-actions">
			<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
		</div>
	</fieldset>
</form>
{/strip}
<script>
jQuery(document).ready(function(){
	$('#registerForm').validate({
		rules: {
			'user[identifiant]': {
				required:true,
				minlength:4,
				remote: '{$Helper->getLink("utilisateur/checkIdentifiant/'+$('#identifiant').val()+'?nohtml")}',
			},
			'user[email]':{
				required:true,
				email:true,
				remote: '{$Helper->getLink("utilisateur/checkEmail/'+$('#email').val()+'?nohtml")}',
			},
			'user[password]':{
				required: true,
				minlength:6
			},
			'user[password]':{
				required:true,
				equalTo:'#password',
				minlength:6
			},	
		},
		messages: {
			'user[identifiant]':{
				required: "Veuillez entrer un identifiant",
				minlength: "Votre identifiant doit faire 4 caracteres minumum",
				remote: "Identifiant deja utilise",
			},
			'user[email]':{
				required: "Veuillez entrer une email",
				email: "Email invalide",
				remote: "Email deja utilise",
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
</script>