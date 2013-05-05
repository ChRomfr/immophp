<html>
	<head></head>
	<body>
		<p>Merci de vous etre enregistre sur le site : {$config.titre_site}</p>
		<p>Voici vos identifiants : </p>
		<ul>
			<li>Identifiant : {$user->identifiant}</li>
			<li>Mot de passe : {$smarty.post.user.password2}</li>
		</ul>
		{if $config.user_activation == 'mail'}
		<p>Votre compte a été crée, avant de vous connectez vous devez l'activer en cliquant sur le lien suivant : <a href="{$config.url}{$config.url_dir}index.php/utilisateur/activation?reg={$user->id}|{$user->getTokenActivation()}">{$config.url}{$config.url_dir}index.php/utilisateur/activation?reg={$user->id}|{$user->getTokenActivation()}</a></p>
		{/if}
		<hr/>
		<p><a href="{$config.url}{$config.url_dir}">{$config.url}{$config.url_dir}</a></p>
	</body>
</html>