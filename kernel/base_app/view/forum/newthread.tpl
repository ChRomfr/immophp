<!--
	base_app/view/forum/newthread.tpl
-->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="Accueil">Accueil</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("forum")}" title="Forums">Forums</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("forurm/viewforum/{$Forum.id}")}" title="{$Forum.name}">{$Forum.name}</a><span class="divider">/</span></li>
	<li>Nouveau sujet</li>
</ul>

{if isset($Error)}
<div class="alert">{$Error}</div>
{/if}

<form method="post" action="" id="formNewThread" class="form-horizontal well">
	
	<fieldset>
		<legend>Nouveau sujet</legend>

		<div class="control-group">
			<label for="control-label">Titre :</label>
			<div class="controls">
				<input type="text" name="thread[titre]" id="titre" required class="input-xxlarge" />
			</div>
		</div>

		<div class="control-group">
			<label for="control-label">Message :</label>
			<div class="controls">
				<textarea name="message[message]" id="message" class="input-xxlarge" rows="8"></textarea>
			</div>
		</div>
	</fieldset>

	<div class="form-actions">
		<button class="btn btn-primary">Envoyer</button>
	</div>

</form>

<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	$("#formNewThread").validate({
		rules:{
		},
		messages:{
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
//-->
</script>