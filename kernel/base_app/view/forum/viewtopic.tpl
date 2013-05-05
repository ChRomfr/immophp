{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("forum")}" title="Forums">Forums</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("forum/viewforum/{$Thread.forum_id}")}" title="">{$Forum.name}</a><span class="divider">/</span></li>
	<li>{$Thread.titre}</li>
</ul>

<div class="well">
	{if $Thread->closed == 1}
	<div class="alert alert-info">
		Sujet fermé
	</div>
	{/if}
	<div class="pagination">{$Pagination->render()}</div>
	<table class="table table-hover table-striped table-condensed">
		{foreach $Messages as $Message name=loopmessage}
		<tr>
			<td style="width:20%;">
				<!-- Auteur -->
				<span><strong>{$Message.auteur}</strong></span><br/>
				{if empty($Message.avatar)}
				<span><img src="{$config.url}{$config.url_dir}web/upload/utilisateur/avatar/default.png" alt="" style="width:150px;"/></span>
				{/if}
			</td>
			<td>
				<!-- Message -->
				<div class="pull-left">
					<a name="message-{$Message.id}"><span class="muted"><small>Le {$Message.add_on}</small></span></a>
				</div>
				<div class="pull-right">
					{if $smarty.session.utilisateur.id != 'Visiteur'}
					<a href="javascript:alerteMessage({$Message.id});" title="Alerter"><span class="icon icon-alert"/></a>
					{/if}
					{if $Message.auteur_id == $smarty.session.utilisateur.id && $Thread->closed != 1}
					<a href="javascript:getFormEditReply({$Message.id});" title="Modifier"><span class="icon icon-edit"/></a>
					{/if}
					{if isset($smarty.session.utilisateur.groupes.moderateurs) || $smarty.session.utilisateur.isAdmin > 0}
					<a href="javascript:deleteReply({$Message.id});" title="Supprimer"><span class="icon icon-trash"/></a>
					{/if}
				</div>
				<div class="clearfix"></div>
				<div id="message{$Message.id}">
					{if ($smarty.session.utilisateur.isAdmin > 0 || isset($smarty.session.utilisateur.groupe.moderateurs)) && $Message.alerte > 0}
					<div class="alert">
					{/if}
					<p>{BBCode2Html($Message.message|html_entity_decode)}</p>
					{if ($smarty.session.utilisateur.isAdmin > 0 || isset($smarty.session.utilisateur.groupe.moderateurs)) && $Message.alerte > 0}
					</div>
					{/if}
				</div>
			</td>
			{if $config.forum_pub_after_1_message == 1 && !empty($config.forum_pub_code) && $smarty.foreach.loopmessage.iteration == 1}
			<tr>
				<td colspan="2" style="text-align: center">{$config.forum_pub_code}</td>
			</tr>
			{/if}
		{/foreach}
	</table>

	{if $smarty.session.utilisateur.id != 'Visiteur' && $Thread->closed != 1}
	<hr/>
	<form method="post" action="{$Helper->getLink("forum/addReply/{$Thread.id}")}" id="formReply" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">Réponse :</label>
			<div class="controls">
				<textarea name="reply[message]" id="message" class="input-xxlarge" rows="5"></textarea>
			</div>
		</div>
		<div class="form-actions">
			<button class="btn btn-primary">Répondre</button>
		</div>
	</form>
	{/if}
	<div class="pagination">{$Pagination->render()}</div>
	{if $smarty.session.utilisateur.isAdmin > 0 || isset($smarty.session.utilisateur.groupe.moderateurs)}
	<hr/>
	<div class="pull-right">
		<!-- Verouillage/Deverouillage -->
		{if $Thread.closed != 1}
		<a href="javascript:lockSujet({$Thread.id});" title="Fermer le sujet"><span class="icon32 icon-locked"/></a>
		{else}
		<a href="javascript:unlockSujet({$Thread.id});" title="Ouvrir le sujet"><span class="icon32 icon-unlocked"/></a>
		{/if}
		<!-- Deplacement -->
		<a href="#myModal" role="button" data-toggle="modal"><span class="icon32 icon-redo"/></a>
		<!-- Suppression -->
		<a href="javascript:deleteTopic({$Thread.id});" title="Supprimer le sujet"><span class="icon32 icon-trash"/></a>
	</div>
	<div class="clearfix"></div>
	{/if}
</div>

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
<h3 id="myModalLabel">Deplacement sujet</h3>
</div>
<div class="modal-body">
<form method="post" action="{$Helper->getLink("forum/movetopic/{$Thread.id}")}">
	<label>Forum :<label>
	<select name="thread[forum_id]">
		{foreach $Forums as $Forum}
			<option value="{$Forum.id}" {if $Forum.id == $Thread.forum_id}selected="selected"{/if}>{$Forum.categorie} > {$Forum.name}</option>
		{/foreach}
	</select>
</div>
<div class="modal-footer">
	<input type="hidden" name="thread[id]" value="{$Thread.id}" />
<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
<button class="btn btn-primary" type="submit">Save changes</button>
</form>
</div>
</div>

{/strip}

<script type="text/javascript">
<!--
{if $smarty.session.utilisateur.id != 'Visiteur'}
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	$("#formReply").validate({
		rules:{
			'reply[message]':{
				required:true,
				minlength:20,
			},
		},
		messages:{
			'reply[message]':{
				required:'Champ obligatoire',
				minlength:'Votre réponse est trop courte, 20 caractères mini',
			},
		},
		highlight:function(element)
        {
            $(element).parents('.control-group').removeClass('success');
            $(element).parents('.control-group').addClass('error');
        },
        unhighlight: function(element)
        {
            $(element).parents('.control-group').removeClass('error');
            $(element).parents('.control-group').addClass('success');
        }
	});
});

$(document).ready(function()	{
    $('#message').markItUp(mySettings);
});

function alerteMessage(message_id){
	if( confirm('Etes vous sur de vouloir signaler ce message ?') ){
		window.location.href = '{$Helper->getLink("forum/alertemessage/'+ message_id +'")}';
	}
}


{if $Thread->closed != 1}
function getFormEditReply(message_id){
	$.get(
		'{$Helper->getLink("forum/editreplyform/'+ message_id +'")}',{literal}
		{nohtml:'nohtml'},{/literal}
		function(data){ $('#message'+ message_id).html(data); }
	);
}
{/if}
	
{/if}

{if $smarty.session.utilisateur.isAdmin > 0 || isset($smarty.session.utilisateur.groupe.moderateurs)}
function lockSujet(thread_id){
	if( confirm('Etes vous sur de vouloir verouiller le sujet') ){
		window.location.href = '{$Helper->getLink("forum/locksujet/'+ thread_id +'")}';
	}
}

function unlockSujet(thread_id){
	if( confirm('Etes vous sur de vouloir déverouiller le sujet') ){
		window.location.href = '{$Helper->getLink("forum/unlocksujet/'+ thread_id +'")}';
	}
}

function deleteReply(message_id){
	if( confirm('Etes vous sur de vouloir supprimer cette reponse ?') ){
		window.location.href = '{$Helper->getLink("forum/deletereply/'+ message_id +'")}';
	}
}

function deleteTopic(topic_id){
	if( confirm('Etes vous sur de vouloir supprimer ce sujet ?') ){
		window.location.href = '{$Helper->getLink("forum/deletetopic/'+ topic_id +'")}';
	}
}
{/if}
//-->
</script>
