{strip}
<!-- START BLOK COUP DE COEUR -->
<div class="blok">

	<div class="bloc_gauche_titre">{$Annonce.nom}</div>
	<div class="bloc_gauche_corp center">
		<a href="{getLink("annonce/detail/{$Annonce.id}/{$Annonce.nom|urlencode}")}" title="{$Annonce.nom}">
		{if !empty($Annonce.photo)}
			<img src="{$config.url}{$config.url_dir}web/upload/bien/{$Annonce.id}/{$Annonce.photo}" alt="{$Annonce.nom}" style="width:230px;"/>
		{/if}
		{if !empty($Annonce.prix)}
		<span style="font-weight: bold;">{$Annonce.prix|number_format:0:'.':' '} {$config.devise} FAI</span>
		{/if}
		</a>
	</div>
</div>
<br/>
<!-- END BLOK COUP DE COEUR -->
{/strip}