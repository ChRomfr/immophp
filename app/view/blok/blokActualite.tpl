{strip}
<!-- START BLOK COUP DE COEUR -->
<div class="blok">

	<div class="bloc_gauche_titre">Actualités</div>
	<div class="bloc_gauche_corp center">
		<div class="bloc_actualite" style="text-align:left;">
		<ul>
		{foreach $News as $Row}
			<li><a href="{getLink("news/view/{$Row.id}/{$Row.sujet|urlencode}")}" title="{$Row.sujet}">{$Row.sujet}</a></li>
		{/foreach}
		</ul>
		</div>
	</div>
</div>
<br/>
<!-- END BLOK COUP DE COEUR -->
{/strip}