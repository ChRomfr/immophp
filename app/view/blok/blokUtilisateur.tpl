{if $smarty.session.utilisateur.id == 'Visiteur'}{strip}
		
<div class="blok">
	<div class="bloc_gauche_titre">{$lang.Identification}</div>
	<div class="bloc_gauche_corp">
		<form method="post" action="{getLink("connexion")}">
			<div class="login center">
				<span class="login-pseudo"><input type="text" name="login[identifiant]" id="login" required /></span>
				<span class="login-password"><input type="password" name="login[password]" id="mdp" required /></span>
			</div>
			<br/>
			<div class="center" >
				<input type="submit" value="{$lang.Envoyer}" class="submit" />
			</div>
			<br/>
			<div class="center">
				<a href="{getLink("utilisateur/register")}" title="{$lang.S_enregistrer}" class="submit">{$lang.S_enregistrer}</a>
			</div>
		</form>		
		<span>&nbsp;</span>
	</div>
</div>
		
{else}
<div class="blok">

		<div class="bloc_gauche_titre">{$lang.Utilisateur}</div>
		<div class="bloc_gauche_corp">		
			<span>Hello {$smarty.session.utilisateur.identifiant}</span>&nbsp;&nbsp;
			<span><a href="{getLink("connexion/logout")}" title="{$lang.Deconnexion}">{$lang.Deconnexion}</a></span>
			{*
			{if $nbNotReadMessage > 0}
			<p><a href="{getLink("discussion")}" style="font-weight:bold; color:red;">{$lang.Vous_avez} {$nbNotReadMessage} {$lang.message_non_lus}</a></p>
			{/if}
			*}
			{if empty($smarty.session.utilisateur.avatar)}
			<p style="margin:0px; padding:0px; text-align:center;"><br/><img src="{$config.url}{$config.url_dir}web/images/avatar/avatar_default.png" style="width:75px;" /></p>
			{/if}

			{if $smarty.session.utilisateur.isAdmin > 0}
			<ul class="menu">
				<li><a href="{$config.url}{$config.url_dir}adm/" title="{$lang.Administration}">{$lang.Administration}</a></li>
			</ul>
			{/if}
			<ul class="menu">
				<li><a href="{getLink("utilisateur")}" title="{$lang.Profil}">{$lang.Profil}</a></li>
			</ul>
		</div>

</div>
{/if}{/strip}