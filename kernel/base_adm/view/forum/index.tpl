<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>Forum</li>
</ul>

	<div class="row-fluid">
		<!-- Log moderation -->	
		<div class="span4 well">
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
		</div>
		
		{if count($Alertes) > 0}
		<div class="span4 well">
			<table class="table">
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
						<td style="text-align:center;"><a href="{$Helper->getLinkAdm("forum/traitealerte/{$Alerte.id}")}" title="" class="btn btn-warning">Traiter</a></td>
				{/foreach}
				</tbody>
			</table>
		</div>
		{/if}

		<!-- Categorie et forum -->
		<div class="span4">
			{foreach $ForumsData as $Data}
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th colspan="2">
							<div class="pull-left">{$Data.name}</div>
							<div class="pull-right">
								<a href="{$Helper->getLinkAdm("forum/forumadd/{$Data.id}")}" title="Ajouter un forum"><span class="icon icon-blue icon-plus"/></a>
								&nbsp;
								<a href="{$Helper->getLinkAdm("forum/categorieedit/{$Data.id}")}" title="Modifier la categorie"><span class="icon icon-green icon-edit"/></a>
								&nbsp;
								<a href="javascript:deletecategorie({$Data.id})" title="Supprimer la categorie"><span class="icon icon-red icon-trash"/></a>
							</div>
							<div class="clearfix"></div>
						</th>
					</tr>
				</thead>
				<tbody>
				{foreach $Data.forums as $Forum}
				<tr>
					<td>
						<div class="pull-left">
							<a href="#" title="{$Forum.name}">{$Forum.name}</a>
						</div>
						<div class="pull-right">
							<a href="{$Helper->getLinkAdm("forum/forumedit/{$Forum.id}")}" title="Modifier le forum"><span class="icon icon-green icon-edit"/></a>
							&nbsp;
							<a href="javascript:deleteforum({$Forum.id})" title="Supprimer le forum"><span class="icon icon-red icon-trash"/></a>
						</div>
						<div class="clearfix"></div>
					</td>
				</tr>
				{/foreach}
				<tbody>
			</table>
			<br/>
		{/foreach}
		<div style="text-align:center">
			<a href="{$Helper->getLinkAdm("forum/categorieadd")}" title="{$lang.Nouvelle_categorie}" class="btn">{$lang.Nouvelle_categorie}</a>
		</div><!-- /span4 -->
	</div><!-- /row-fluid -->

<script type="text/javascript">
<!--
function deletecategorie(categorie_id){
	if(confirm('{$lang.Confirm_suppression_categorie} ?' )){
		window.location.href = '{$Helper->getLinkAdm("forum/categoriedelete/'+categorie_id+'")}';
	}
}

function deleteforum(id){
	if(confirm('{$lang.Confirm_suppression_forum} ?' )){
		window.location.href = '{$Helper->getLinkAdm("forum/forumdelete/'+id+'")}';
	}
}
//-->
</script

