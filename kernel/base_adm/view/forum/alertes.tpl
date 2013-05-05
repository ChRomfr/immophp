<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("forum")}" title="">{$lang.Forum}</a><span class="divider">/</span></li>
	<li>Alertes</li>
</ul>

<table class="table table-striped">
	<caption><h4>Alertes</h4></caption>
	<thead>
		<tr>
			<th>Date</th>
			<th>Message</th>
			<th>Auteur</th>
			<th>Rapporteur</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
	{foreach $Alertes as $Alerte}
		<tr>
			<td>{$Alerte.date_alerte}</td>
			<td><a href="{$Helper->getLink("forum/viewtopic/{$Alerte.thread_id}#message-{$Alerte.message_id}")}" target="_blank" title="Voir">#{$Alerte.message_id}</a></td>
			<td>{$Alerte.identifiant}</td>
			<td>{$Alerte.rapporteur}</td>
			<td style="text-align:center;">{if $Alerte.traite == 0}<a href="{$Helper->getLinkAdm("forum/traitealerte/{$Alerte.id}")}" title="" class="btn btn-warning">Traiter</a>{/if}</td>
	{/foreach}
	</tbody>
</table>

<div class="pagination">{$Pagination->render()}</div>