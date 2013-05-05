{if $blok.position == 'left' OR $blok.position == 'right'}
<div class="blok">
	<div>
		<div>
			<div>
				<h3>{$blok.name}</h3>
				{$blok.contenu}
			</div>
		</div>
	</div>
</div>
{elseif $blok.position == 'top' OR $blok.position == 'foot'}
<div class="blokTopTitre">{$blok.name}</div>
<div class="blokTop">{$blok.contenu}</div>
{/if}