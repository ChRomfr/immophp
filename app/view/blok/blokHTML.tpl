{if $blok.position == 'left' OR $blok.position == 'right'}
<div class="blok">
	<div class="bloc_gauche_titre">{$blok.name}</div>
	<div class="bloc_gauche_corp">
	{$blok.contenu}
	</div>
</div>
{elseif $blok.position == 'top' OR $blok.position == 'foot'}
<div class="blokTopTitre">{$blok.name}</div>
<div class="blokTop">{$blok.contenu}</div>
{/if}