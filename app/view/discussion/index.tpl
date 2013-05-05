{if $config.bread}
<div id="bread">
	<a href="{getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a>&nbsp;-&gt;&nbsp;
	{$lang.Message}
</div>
{/if}
<div class="fright">
	<a href="{getLink("discussion/nouvelle")}" title=""><img src="{$config.url}{$config.url_dir}web/images/addSmall.png" /></a>
</div>
<h2>{$lang.Discussions}</h2>
<div class="clear"></div>
<table class="tadmin">
	<thead>
		<tr>
			<td>#</td>
			<td>{$lang.Sujet}</td>
			<td>{$lang.Dernier_message_le}</td>
			<td>{$lang.Participant}</td>
		</tr>
	</thead>
	<tbody>
		{foreach $discussions as $discussion}
		<tr>
			<td>{if $discussion.not_read > 0}<strong>{/if}{$discussion.id}{if $discussion.not_read > 0}</strong>{/if}</td>
			<td><a href="{getLink("discussion/discussion/{$discussion.id}")}" title="">{if $discussion.not_read > 0}<strong>{/if}{$discussion.sujet}{if $discussion.not_read > 0}</strong>{/if}</a></td>
			<td>{if $discussion.not_read > 0}<strong>{/if}{$discussion.last_update|date_format:$config.format_date}{if $discussion.not_read > 0}</strong>{/if}</td>
			<td>{if $discussion.not_read > 0}<strong>{/if}{if $discussion.destinataire_id != $smarty.session.utilisateur.id}{$discussion.destinataire}{else}{$discussion.auteur}{/if}{if $discussion.not_read > 0}</strong>{/if}</td>
		</tr>
		{/foreach}
	</tbody>
</table>