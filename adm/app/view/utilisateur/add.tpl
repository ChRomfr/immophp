<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#registerForm").validationEngine();
});

function checkSubmit(){
	
	if( $('#resultIdentifiant').val() == 'alreadyUse'){
		return false;
	}
	
	if( $('#resultEmail').val() == 'alreadyUse'){
		return false;
	}
	
	return true;
}

function checkIdentifiant(){
	var result = '';
    var xhr = getXMLHttpRequest();
	xhr.open("GET", '{getLink("utilisateur/check_identifiant/'+document.getElementById('identifiant').value+'?nohtml")}', true);
	xhr.onreadystatechange = function () {
        if(xhr.readyState == 4){
            result = xhr.responseText;
            if(result == 'alreadyUse'){
                 document.getElementById('identifiantVerif').innerHTML = '<span style="color:#FF0000;"><img src="{$config.url}{$config.url_dir}web/images/noSmall.png" /> <strong>{$lang.Identifiant_deja_utilise}</strong></span>';
				 document.getElementById('resultIdentifiant').value = 'alreadyUse';			
            }else{
                 document.getElementById('identifiantVerif').innerHTML = '<img src="{$config.url}{$config.url_dir}web/images/okSmall.png" />';
				 document.getElementById('resultIdentifiant').value = '';
            }
        }
	}
	xhr.send(null);
}

function checkEmail(){
	var result = '';
    var xhr = getXMLHttpRequest();
	xhr.open("GET", '{getLink("utilisateur/check_email/'+document.getElementById('email').value+'?nohtml")}', true);
	xhr.onreadystatechange = function () {
        if(xhr.readyState == 4){
            result = xhr.responseText;
            if(result == 'alreadyUse'){
                 document.getElementById('emailVerif').innerHTML = '<span style="color:#FF0000;"><img src="{$config.url}{$config.url_dir}web/images/noSmall.png" /> <strong>{$lang.Email_deja_utilise}</strong></span>';
				 document.getElementById('resultEmail').value = 'alreadyUse';			
            }else{
                 document.getElementById('emailVerif').innerHTML = '<img src="{$config.url}{$config.url_dir}web/images/okSmall.png" />';
				 document.getElementById('resultEmail').value = '';
            }
        }
	}
	xhr.send(null);
}

//-->
</script>
{strip}
<!-- BREAD -->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("utilisateur")}" title="{$lang.Utilisateurs}">{$lang.Utilisateurs}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>

<!-- FORMULAIRE -->
<form class="form-horizontal well" method="post" action="#" onsubmit="return checkSubmit();" id="registerForm">
	<fielset>
		<legend>{$lang.Enregistrement}</legend>
		<div class="control-group">
			<label class="control-label" for="identifiant">{$lang.Identifiant} :</label>
			<div class="controls"><input type="text" name="user[identifiant]" {if isset($smarty.post.user.identifiant)}value=""{/if} id="identifiant" class="validate[required]" onchange="checkIdentifiant();" /><span id="identifiantVerif"></span></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="email">{$lang.Email} :</label>
			<div class="controls"><input type="email" name="user[email]" id="email" placeholder="{$lang.Votre_email}" class="validate[required,custom[email]]" onchange="checkEmail();" autocomplete="off" /><span id="emailVerif"></span></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="password">{$lang.Mot_de_passe} :</label>
			<div class="controls"><input type="password" name="user[password]" id="password" class="validate[required]" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="password2">{$lang.Confirmation} :</label>
			<div class="controls"><input type="password" name="user[password2]" id="password2" class="validate[required,equals[password]]" /></div>
		</div>

		<div class="control-group">
			<label class="control-label" class="control-label">{$lang.Agence} :</label>
			<div class="controls">
				<select name="user[agence_id]" id="agence_id">
					<option></option>
					{foreach $Agences as $Row}
					<option value="{$Row.id}">{$Row.nom}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="form-actions">
			<input type="hidden" id="resultIdentifiant" value="" />
			<input type="hidden" id="resultEmail" value="" />
			<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
		</div>
	</fieldset>
</form>
{/strip}