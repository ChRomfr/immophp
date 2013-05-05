<script>
<!--
function showFormReply(){
$( "#dialog-form" ).dialog( "open" );
}

$(function() {
	// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	
	$( "#dialog-form" ).dialog({
		autoOpen: false,
		height: 400,
		width: 600,
		modal: true,
		buttons: {
			Cancel: function() {
				$( this ).dialog( "close" );
			},
			
			Submit:  function(){
					
					if( $("#message").val() == ""){
						$("#message").css("border-color","red");
						
					}else{
						$("#formReply").submit();
					}						
				}
		},
		close: function() {
			allFields.val( "" ).removeClass( "ui-state-error" );
		}
	});
});

function deleteDiscussion(){
	if( confirm('{$lang.Confirm_suppression_discussion} ?') ){
		window.location.href='{getLink("discussion/delete/{$messages.0.discussion_id}")}';
	}
}
//-->
</script>
{if $config.bread}
<div id="bread">
	<a href="{getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a>&nbsp;-&gt;&nbsp;
	<a href="{getLink("discussion")}" title="{$lang.Message}">{$lang.Message}</a>&nbsp;-&gt;&nbsp;
	{$messages.0.sujet}
</div>
{/if}
<h2>{$messages.0.sujet}</h2>

<table class="commentaires_liste">
	<tr class="commentaire_liste_header">
		<td >{$lang.Auteur}</td>
		<td>{$lang.Discussion}</td>
	</tr>
	{foreach $messages as $message}
	<tr class="commentaire_liste_info">
		<td>{$message.auteur}</td>
		<td>{$message.post_on|date_format:$config.format_date}</td>
	</tr>
	<tr>
		<td style="text-align:center; width:25%;">
			{if empty($message.avartar)}
			<img src="{$config.url}{$config.url_dir}web/images/avatar/avatar_default.png" style="width:75px;" />
			{/if}			
		</td>
		<td style="width:75%;">{$message.message|htmlentities|nl2br}</td>
	</tr>
	{/foreach}
</table>
{if $messages.0.reply == 1}
<div class="center">
	<a href="javascript:showFormReply();"><img src="{$config.url}{$config.url_dir}web/images/{$config.lang}/reply.gif" /></a>
</div>

<div id="dialog-form" title="Reply">
	<p class="validateTips">All form fields are required.</p>

	<form method="post" action="{getLink("discussion/reply")}" id="formReply">
	<fieldset>
		<label for="message">{$lang.Message} :</label>
		<textarea name="message[message]" id="message" class="text ui-widget-content ui-corner-all validate[required]" rows="6" cols="50"></textarea>
		<input type="hidden" name="message[discussion_id]" value="{$messages.0.discussion_id}" />
		<input type="hidden" name="message[destinataire_id]" value="{if $messages.0.destinataire_id != $smarty.session.utilisateur.id}{$messages.0.destinataire_id}{else}{$messages.0.auteur_id}{/if}" />
	</fieldset>
	</form>
</div>
{/if}
<div class="fright">
	<a href="javascript:deleteDiscussion();">
		<img src="{$config.url}{$config.url_dir}themes/{$config.theme}/images/buttom/icon_delete.gif" alt="X" />
	</a>
</div>