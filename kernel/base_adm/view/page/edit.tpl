{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('page/index')}" title="{$lang.Page}">{$lang.Page}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<form method="post" id="editpage" class="form-horizontal well">
	<fieldset>

		<legend>{$lang.Edition}</legend>

		<div class="control-group">
			<label class="control-label">{$lang.Titre} :</label>
			<div class="controls"><input type="text" name="page[titre]" id="titre" class="validate[required]" value="{$page.titre}" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="contenu">{$lang.Contenu} :</label>
			<div class="controls"><textarea {if $config.use_ckeditor}class="ckeditor"{else}class="input-xxlarge"{/if} rows="10" name="page[contenu]" id="contenupage">{$page.contenu}</textarea></div>
		</div>
		<div class="control-group">
			<label class="control-label">{$lang.Visible} :</label>
			<div class="controls">
				<select name="page[visible]">
					<option value="1" {if $page.visible == 1}selected="selected"{/if}>{$lang.Oui}</option>
					<option value="0" {if $page.visible == 0}selected="selected"{/if}>{$lang.Non}</option>
				</select>
			</div>
		</div>
		<div class="form-actions">
			<input type="hidden" name="page[creat_on]" value="{$page.creat_on}" />
			<input type="hidden" name="page[edit_on]" value="{$smarty.now}" />
			<input type="hidden" name="page[auteur_id]" value="{$page.auteur_id}" />
			<input type="hidden" name="page[id]" value="{$page.id}" />
			<input type="hidden" name="token" value="{$smarty.session.token}" />
			<input type="submit" name="send" value="{$lang.Enregistrer}" class="btn btn-primary" />
		</div>
	</fieldset>
</form>

{/strip}
<script>
jQuery(document).ready(function(){
	$('#addpage').validate({
		rules:{
			'page[titre]':'required',
			'page[contenu]':'required',
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
	})
});
$(document).ready(function()	{
   $('#contenupage').markItUp(mySettings);
});
</script>

