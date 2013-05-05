{strip}
{if $blok.position == 'left' OR $blok.position == 'right'}
	<div class="blok">
		<h3>{$blok.name}</h3>
		{foreach $flux->find({$blok.contenu.nb_links}) as $item}
		<li style="list-style: none;"><a href="{if isset($item->link)}{$item->link}{else}{$item->url}{/if}" title="" target="_blank"><small>{$item->title}</small></a></li>
		{/foreach}
	</div>
{elseif $blok.position == 'top' OR $blok.position == 'foot'}
<div class="blockCenter">
	<div class="blokTopTitre">
		{$blok.name}
		<div class="fright" style="margin-right:2px;">
			<a href="javascript:HideBlok('blok_{$blok.id}');">
				<span id="blok_{$blok.id}_arrow">{if $blok.visible == true}<img src="{$config.url}{$config.url_dir}themes/{$config.theme}/images/arrow_up_small.png" alt="-" />{else}<img src="{$config.url}{$config.url_dir}themes/{$config.theme}/images/arrow_down_small.png" alt="+" />{/if}</span>
			</a>
		</div>
	</div>
	{* DIV PERMETTANT DE PLIER/DEPLIER LE BLOK *}
	<div id="blok_{$blok.id}" {if $blok.visible == true}style="display:block;"{else}style="display:none;"{/if}>
		<div class="blokTop">
			<div class="fleft" style="width:49%;">
				<h3>{$blok.contenu.nameflux1}</h3>
				<ul style="margin-left:-25px;">
					{foreach $flux->find({$blok.contenu.nb_links}) as $item}
					<li style="list-style: none;"><a href="{if isset($item->link)}{$item->link}{else}{$item->url}{/if}" title="" target="_blank"><small>{$item->title}</small></a></li>
					{/foreach}
				</ul>
			</div>
			<div class="fright" style="width:49%;">
				{if !empty($flux2)}
					<h3>{$blok.contenu.nameflux2}</h3>
					<ul style="margin-left:-25px;">
						{foreach $flux2->find({$blok.contenu.nb_links}) as $item}
						<li style="list-style: none;"><a href="{if isset($item->link)}{$item->link}{else}{$item->url}{/if}" title="" target="_blank"><small>{$item->title}</small></a></li>
						{/foreach}
					</ul>
				{/if}
			</div>
			<div class="clear"></div>	
		</div>
	</div>
</div>
{/if}
{/strip}