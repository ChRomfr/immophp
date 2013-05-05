<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("forum")}" title="">{$lang.Forum}</a><span class="divider">/</span></li>
	<li>Logs</li>
</ul>

<table class="table">
	<caption><h4>Logs modération</h4></caption>
	<thead>
		<tr>
			<th>Date</th>
			<th>Moderateur</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
	{foreach $Logs as $Log}
		<tr>
			<td>{$Log.date_action}</td>
			<td>{$Log.moderateur}</td>
			<td>{$Log.action}</td>
		</tr>
	{/foreach}
	</tbody>
</table>