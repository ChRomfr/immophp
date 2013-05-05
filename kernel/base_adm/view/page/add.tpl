{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('page/index')}" title="{$lang.Page}">{$lang.Page}</a><span class="divider">/</span></li>
	<li>{$lang.Nouvelle}</li>
</ul>


<form method="post" id="addpage" class="form-horizontal well">
	<fieldset>

		<legend>{$lang.Nouvelle}</legend>

		<div class="control-group">
			<label class="control-label">{$lang.Titre} :</label>
			<div class="controls"><input type="text" name="page[titre]" id="titre" class="input-xxlarge" /></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="contenu">{$lang.Contenu} :</label>
			<div class="controls"><textarea class="input-xxlarge" name="page[contenu]" id="contenupage" rows="10"></textarea></div>
		</div>

		<div class="control-group">
			<label class="control-label">{$lang.Visible} :</label>
			<div class="controls">
				<select name="page[visible]">
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="form-actions">
			<input type="hidden" name="page[creat_on]" value="{$smarty.now}" />
			<input type="hidden" name="page[edit_on]" value="{$smarty.now}" />
			<input type="hidden" name="page[auteur_id]" value="{$smarty.session.utilisateur.id}" />
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