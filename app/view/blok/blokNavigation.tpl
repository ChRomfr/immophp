{strip}<div class="blok">

	<h3>{$lang.Navigation}</h3>
	<ul class="menu">
		<li><a href="{getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a></li>
		<li><a href="{getLink("compagnie")}" title="{$lang.Compagnie}">{$lang.Compagnie}</a></li>
		<li><a href="{getLink("fleet")}" title="{$lang.Flotte}">{$lang.Flotte}</a></li>
		<li><a href="{getLink("flight")}" title="{$lang.Vol}">Pirep</a></li>
		<li><a href="{getLink("roster")}" title="{$lang.Pilotes}">{$lang.Pilotes}</a></li>
		<li><a href="{getLink("schedules")}" title="{$lang.Pilotes}">{$lang.Destination}</a></li>
		<li><a href="{getLink("event/index")}" title="{$lang.Evenement}">{$lang.Evenement}</a></li>
		<li><a href="{getLink("acars")}" title="Acars">Acars</a></li>
		{if $NbImages > 0}<li><a href="{getLink("gallery")}" title="{$lang.Galerie}">{$lang.Galerie}</a></li>{/if}
		{if $config.download_view_by == 'member' && $smarty.session.utilisateur.id != 'Visiteur'}
		<li><a href="{getLink("download")}" title="{$lang.Telechargement}">{$lang.Telechargement}</a></li>
		{elseif $config.download_view_by == 'pilot' && isset($smarty.session.utilisateur.pilot) && $smarty.session.utilisateur.pilot == 1}
		<li><a href="{getLink("download")}" title="{$lang.Telechargement}">{$lang.Telechargement}</a></li>
		{elseif $config.download_view_by == 'all'}
		<li><a href="{getLink("download")}" title="{$lang.Telechargement}">{$lang.Telechargement}</a></li>
		{/if}
		
		{* GESTION DES LIENS SUPPLEMENTAIRES *}
		{if isset($links) && !empty($links)}
			{foreach $links as $k => $v}
			<li><a href="{$v}" title="{$k}">{$k}</a></li>
			{/foreach}
		{/if}
	</ul>

</div>{/strip}