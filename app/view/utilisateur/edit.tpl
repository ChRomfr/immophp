<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#edit").validationEngine();
});
-->
</script>

<div id="bread">
	<a href="{getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a>&nbsp;>>&nbsp;
	<a href="{getLink("utilisateur")}" title="{$lang.Profil}">{$lang.Profil}</a>&nbsp;>>&nbsp;
	{$lang.Edition}
</div>

<form method="post" id="edit" class="form">
	<h1>{$lang.Edition}</h1>
	<dl>
		<dt><label>{$lang.Email} :</label></dt>
		<dd><input type="text" name="user[email]" value="{$smarty.session.utilisateur.email}" class="validate[required,custom[email]]" id="email" /></dd>
	</dl>
		
	<dl>
		<dt><label for="nom">Nom :</label></dt>
		<dd><input type="text" name="user[nom]" value="{$smarty.session.utilisateur.nom}" id="nom" /></dd>
	</dl>
		
	<dl>
		<dt><label for="prenom">Prenom :</label></dt>
		<dd><input type="text" name="user[prenom]" value="{$smarty.session.utilisateur.prenom}" id="prenom" /></dd>
	</dl>
	
	<dl>
		<dt><label for="ville">Ville :</label></dt>
		<dd><input type="text" name="user[ville]" value="{$smarty.session.utilisateur.ville}" id="ville" /></dd>
	</dl>
	
	<dl>
		<dt><label for="profil_public">Profil visible dans la liste des membres :</label></dt>
		<dd>
			<select name="user[profil_public]" id="profil_public">
				<option value="0">Non</option>
				<option value="1" {if $smarty.session.utilisateur.profil_public == 1}selected="selected"{/if}>Oui</option>
			</select>
		</dd>
	</dl>
	
	<!-- BIOGRAPHIE -->
	<dl>
		<dt><label for="biographie">Biographie :</label></dt>
		<dd><textarea name="user[biographie]" rows="3" cols="40" id="biographie"></textarea></dd>
	</dl>
	
	<!-- RECEVOIR EMAIL DEPUIS LE SITE -->
	<dl>
		<dt><label for="receive_email_site">Recevoir des emails depuis le site :</label></dt>
		<dd>
			<select name="user[receive_email_site]" id="receive_email_site">
				<option value="0">Non</option>
				<option value="1" {if $smarty.session.utilisateur.receive_email_site == 1}selected="selected"{/if}>Oui</option>
			</select>
			<br/>
			<span><small>Autorise les membres et les visiteurs a vous envoyer des email depuis le site. En aucun cas votre adresse email est divulge!</small></span>
		</dd>
	</dl>
	
	<!-- NEWSLETTER -->
	<dl>
		<dt><label for="newsletter">Recevoir la newsletter :</label></dt>
		<dd>
			<select name="user[newsletter]" id="newsletter">
				<option value="0">Non</option>
				<option value="1" {if $smarty.session.utilisateur.newsletter == 1}selected="selected"{/if}>Oui</option>
			</select>
		</dd>
	</dl>
				
		
{*
	<dl>
		<dt><label for="avatar">{$lang.Avatar} :</label></dt>
		<dd><input type="file" name="avatar" id="avatar" /></dd>
	</dl>
*}
	
	<div class="form_submit center">
		<input type="hidden" name="user[id]" value="{$smarty.session.utilisateur.id}" />
		<input type="submit" name="send" value="{$lang.Enregistrer}" />
	</div>
</form>