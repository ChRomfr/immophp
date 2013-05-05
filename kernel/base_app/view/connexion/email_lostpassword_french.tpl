<p>Bonjour,</p>
<br/>
<p>Une requete de changement de mot de passe vient d'etre effectuee sur : {$config.titre_site}</p>
<br/>
<p>Si vous n'avez pas fait cette demande, vous pouvez supprimer cet email</p>
<br/>
<p>Pour changer votre mot de passe, cliquer sur le lien suivant : <a href="{$config.url}{$config.url_dir}index.php/connexion/resetPassword?token={$Data.token}" title="">{$config.url}{$config.url_dir}index.php/connexion/resetPassword?token={$Data.token}</a></p>
<br/>
<p>Information sur la requete : </p>
<ul>
	<li>Demande faite a : {$Data.time_on_demand|date_format:$config.format_date}</li>
	<li>IP du demandeur : {$smarty.server.REMOTE_ADDR}</li>
</ul>
<br/>
<p>Cordialement</p>