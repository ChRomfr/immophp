<!-- <h2>{$lang.News}</h2> -->

{foreach $news as $new}
<div class="well">
	<h3><a href="{$Helper->getLink("news/view/{$new.id}/{$new.sujet|urlencode}")}" title="{$new.sujet}">{$new.sujet}</a></h3>
	<hr/>
	<div>
		{if $config.news_truncate_in_index == 1 && strlen($new.contenu) > 1000}{$new.contenu|truncate:1000}
			<div class="fright"><a href="{$Helper->getLink("news/view/{$new.id}/{$new.sujet|urlencode}")}" title=""><small>{$lang.Suite}</smalL></a><br/><br/></div><div class="clear"></div>
		{else}
			{$new.contenu}
		{/if}
	</div>
	<hr/>
	<div>	
		<div class="fleft"><i class="icon-user"></i> : {$new.identifiant} <i class="icon-calendar"></i> {$new.post_on|date_format:$config.format_date}</div>
		<div class="fright">{if $new.source != '' && $new.source_link != ''}{$lang.Source} : <a href="{$new.source_link}" target="_blank">{$new.source}</a> - {/if}{if !empty($new.categorie)}&nbsp;<i class="icon-tag"></i>&nbsp;{$new.categorie}{/if}</div>
		<div class="clear"></div>
	</div>
</div>
{/foreach}

{if !empty($pagination)}
<div class="pagination">{$pagination}</div>
{/if}