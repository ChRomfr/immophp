{if $Thread->closed != 1}
<form method="post" action="{$Helper->getLink("forum/editReply/{$Message->id}")}" id="formReplyEdit" class="form-horizontal">
	<div class="control-group">
		<label class="control-label">Réponse :</label>
		<div class="controls">
			<textarea name="replyedit[message]" id="messageedit" class="input-xxlarge" rows="5">{$Message->message|html_entity_decode}</textarea>
		</div>
	</div>
	<div class="form-actions">
		<button class="btn btn-primary">Modifier</button>
	</div>
</form>
<script type="text/javascript">
<!--
$(document).ready(function()	{
    $('#messageedit').markItUp(mySettings);
});
//-->
</script>
{else}
	<div class="alert">Vous ne pouvez pas modifier un message sur un sujet vérouillé</div>		
	<p>{BBCode2Html($Message.message|html_entity_decode)}</p>
{/if}