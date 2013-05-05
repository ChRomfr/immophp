<!--
	base_app/view/forum/index.tpl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li>Forums</li>
</ul>

<div class="well">
	{foreach $ForumsData as $Data}
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th colspan="2"><a href="#" data-toggle="tooltip" title="{$Data.description}">{$Data.name}</a></th>
					<th>Sujets</th>
					<th>Messages</th>
					<th>Dernier message</th>
				</tr>
			</thead>
			<tbody>
			{foreach $Data.forums as $Forum}
			<tr>
				{if empty($Forum.image)}
				<td colspan="2">
					<a href="{$Helper->getLink("forum/viewforum/{$Forum.id}")}" title="{$Forum.name}">{$Forum.name}</a><br/>
					<span class="muted"><small>{$Forum.description}</small></span>
				</td>
				{else}
				<td style="width:35px;"><img src="{$config.url}{$config.url_dir}web/upload/categorie/{$Forum.image}" alt="" style="width:35px;"/></td>
				<td><a href="{$Helper->getLink("forum/viewforum/{$Forum.id}")}" title="{$Forum.name}">{$Forum.name}</a><br/><span class="muted"><small>{$Forum.description}</small></span></td>
				{/if}
				<td style="text-align:center;">{$Forum.nb_thread}</td>
				<td style="text-align:center;">{$Forum.nb_message}</td>
				<td>
					<p class="muted">Dernier message :</p>
					<p><a href="{$Helper->getLink("forum/viewtopic/{$Forum.last_message.thread_id}")}" title="{$Forum.last_message.thread}">{$Forum.last_message.thread}</p></a>
				</td>
			</tr>
			{/foreach}
			<tbody>
		</table>
		<br/>
	{/foreach}
</div>
{/strip}