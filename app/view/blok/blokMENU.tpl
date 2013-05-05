{strip}
<div class="blok">

	<div class="bloc_gauche_titre">{$Menu.name}</div>
	<div class="bloc_gauche_corp">
		<ul class="menu">
			{foreach $Menu.links as $link}
				{if $link.enabled == 1}
					{if $link.visible_by == 'all'}<li><a href="{if $link.internal == 1}{getLink("{$link.link}")}{else}{$link.link}{/if}" {if $link.new_page == 1}target="_blank"{/if}>{$link.name}</a></li>
					{elseif $link.visible_by == 'member' && $smarty.session.utilisateur.id != 'Visiteur'}<li><a href="{if $link.internal == 1}{getLink("{$link.link}")}{else}{$link.link}{/if}" {if $link.new_page == 1}target="_blank"{/if}>{$link.name}</a></li>
					{elseif $link.visible_by == 'pilot' && isset($smarty.session.utilisateur.pilot) && $smarty.session.utilisateur.pilot == 1}<li><a href="{if $link.internal == 1}{getLink("{$link.link}")}{else}{$link.link}{/if}" {if $link.new_page == 1}target="_blank"{/if}>{$link.name}</a></li>
					{elseif $link.visible_by == 'administrateurs' && $smarty.session.utilisateur.isAdmin > 0}<li><a href="{if $link.internal == 1}{getLink("{$link.link}")}{else}{$link.link}{/if}" {if $link.new_page == 1}target="_blank"{/if}>{$link.name}</a></li>
					{/if}
				{/if}
			{/foreach}
		</ul>
	</div>
</div>
<br/>
{/strip}