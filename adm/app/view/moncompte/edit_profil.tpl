{strip}
<form method="post" action="#" id="formEdit" class="form">
	<h1>{$lang.Edition}</h1>
    <dl>
		<dt><label for="email">{$lang.Email}:</label></dt>
		<dd><input type="email" name="user[email]" id="email" value="{$smarty.session.utilisateur.email}" size="50"/></dd>
    </dl>	
    <dl>
    	<dt><label for="nom">{$lang.Nom} :</label></dt>
    	<dd><input type="text" name="user[nom]" id="nom" value="{$smarty.session.utilisateur.nom}" size="50" /></dd>
	</dl>
	<dl>
    	<dt><label for="prenom">{$lang.Prenom} :</label></dt>
    	<dd><input type="text" name="user[prenom]" id="prenom" value="{$smarty.session.utilisateur.prenom}" size="50" /></dd>
	</dl>
	<dl>
		<dt><label for="gmail_adr">{$lang.Compte} GMAIL :</label></dt>
		<dd><input type="email" name="user[gmail_adr]" id="gmail_adr" value="{$smarty.session.utilisateur.gmail_adr}" size="50"/></dd>
	</dl>
	<dl>
		<dt><label for="gmail_password">{$lang.Password} GMAIL :</label></dt>
		<dd><input type="password" name="user[gmail_password]" id="gmail_password" value="{$smarty.session.utilisateur.gmail_password}" size="50" /></dd>
	</dl>
	<dl>
		<dt><label for="gmail_id_prv">{$lang.ID_private_calendar} :</label></dt>
		<dd><input type="text" name="user[gmail_id_prv]" id="gmail_id_prv" value="{$smarty.session.utilisateur.gmail_id_prv}" size="50" /></dd>
	</dl>
	<div class="center">
		<input type="submit" value="{$lang.Enregistrer}" />
	</div>
</form>
{/strip}