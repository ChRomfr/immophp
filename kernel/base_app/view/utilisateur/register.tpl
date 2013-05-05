{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li>{$lang.Enregistrement}</li>
</ul>

<form class="form-horizontal well" method="post" action="{$Helper->getLink("utilisateur/register")}" id="registerForm">
	<fieldset>
		<legend>{$lang.Enregistrement}</legend>
		{if $config.user_register_by_fb == 1}
		<!-- Affichage du bouton facebook -->
		<div style="text-align:center">
			<div id="fb-login-button"></div>
		</div>
		{/if}
		<div class="control-group">
			<label class="control-label" for="identifiant">{$lang.Identifiant} :</label>
			<div class="controls"><input type="text" name="user[identifiant]" {if isset($smarty.post.user.identifiant)}value=""{/if} id="identifiant" required /></div>
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
		<div class="form-actions">
			<input type="submit" name="send" value="{$lang.Enregistrer}" class="btn btn-primary"/>
		</div>
	</fieldset>	
</form>
{/strip}
{if $config.user_register_by_fb == 1 && isset($smarty.get.fb)} 
<script src="http://connect.facebook.net/fr_FR/all.js" ></script>
{/if}
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
			'user[passwordc]':{
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

{if $config.user_register_by_fb == 1 && isset($smarty.get.fb)} 
// Utilisation de facebook pour enregistrement
function handleFacebook() {
	{literal}
    FB.init({appId: '{$config.fb_app_id}', xfbml: true, cookie: true});
    FB.getLoginStatus(function(response) {
            onStatus(response); // once on page load
            FB.Event.subscribe('auth.statusChange', onStatus); // every status change
        });
	{/literal}
}

/**
* This will be called once on page load, and every time the status changes.
*/
function onStatus(response) {
    console.info('onStatus', response);
	
    if (response.status == 'connected') {
        console.info('User logged in');
        if (response.perms) {
            console.info('User granted permissions');
        }else{
            console.info('User has not granted permissions');
        }
        document.getElementById('fb-login-button').innerHTML='';
        showAccountInfo(response.authResponse.userID);
    } else {
        console.info('User is logged out');
        showLoginButton();
		showAccountInfo();
    }
}

/**
* This assumes the user is logged out, and renders a login button.
*/
function showLoginButton() {
    var button = '<fb:login-button perms="email,user_birthday" />';
    document.getElementById('fb-login-button').innerHTML = button;
    FB.XFBML.parse(document.getElementById('fb-login-button'));
}

function showAccountInfo(userID) {
	console.info("Query facebook for informations form");
    FB.api(
        {
        method: 'fql.query',
        query: 'SELECT name, first_name, last_name, uid, email, birthday_date, sex  FROM user WHERE uid='+userID
        },
		
        function(response) {
            console.info('API Callback', response);
            var user = response[0];
			$("#identifiant").val(user.name);
			checkIdentifiant(user.name);
			$('#email').val(user.email);
			checkEmail(user.email);
			//$('#date_anniversaire').val(user.birthday_date);
			//$('#nom').val(user.last_name);
			//$('#prenom').val(user.first_name);
			//$('#fb_uid').val(userID);
			
           // document.getElementById('firstName').value = user.first_name;
            //document.getElementById('lastName').value = user.last_name;
 
           // var d = new Date(Date.parse(user.birthday_date));
           // document.getElementById('birthdayDate').value = d.toString('dd/MM/yyyy');
 
           // var sex = user.sex.charAt(0).toUpperCase();
           // document.getElementById('gender').value = sex;
        }
    );
}
handleFacebook();
{/if}
</script>