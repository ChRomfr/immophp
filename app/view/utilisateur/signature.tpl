<script>
	$.fn.mColorPicker.defaults.imageFolder = "{$config.url}{$config.url_dir}web/images/";
</script>
{strip}
{if $config.bread}
<div id="bread">
	<a href="{getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a>&nbsp;>>&nbsp;
	<a href="{getLink("utilisateur")}" title="{$lang.Profil}">{$lang.Profil}</a>&nbsp;>>&nbsp;
	{$lang.Signature}
</div>
{/if}
<form method="post" action="#" id="formSignature" class="form">
	<h1>{$lang.Signature}</h1>
	<dl>
		<dt>{$lang.Choix_du_modele} :</dt>
		<dd>
			<table>
				<tr>
					{foreach $Tpls as $k => $v name=foo}
					<td>
						<img src="{$config.url}{$config.url_dir}web/images/signature/signature.php?pid={$smarty.session.utilisateur.id}&amp;tpl={$v}" alt="Non dispo" /><br/><input type="radio" name="signature[signature_img]" value="{$v}" id="{$v}" {if $v == $smarty.session.utilisateur.signature_img}checked="checked"{/if} />
					</td>
					{if $smarty.foreach.foo.iteration % 1 == 0}</tr></tr>{/if}
					{/foreach}
				</tr>
			</table>
		</dd>
	</dl>
	<dl>
		<dt>{$lang.Couleur_du_text} :</dt>
		<dd><input value="rgb({$smarty.session.utilisateur.signature_color_text})" type="color" name="signature[signature_color_text]" id="color_0" class="color" style="background-color:none;"/></dd>
	</dl>
	<div class="center">
		<input type="submit" value="{$lang.Enregistrer}" />
		<a href="{getLink("utilisateur")}" title="{$lang.Retour}" class="submit">{$lang.Retour}</a>
	</div>
</form>{/strip}