
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('download/index')}" title="{$lang.Telechargement}">{$lang.Telechargement}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<div class="alert alert-error" style="display:none;" id="alerte">Veuillez indiquer l'url du fichier ou l'envoyer par le formulaire</div>
<form method="post" class="form-horizontal well" action="" id="FormAdd" enctype="multipart/form-data">
	<fieldset>
		<legend>Edition telechargement</legend>
		<div class="control-group">
			<label class="control-label" for="name">{$lang.Nom} :</label>
			<div class="controls"><input type="text" name="download[name]" id="name" value="{$download->name}" /></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="categorie_id">{$lang.Categorie} :</label>
			<div class="controls">
				<select name="download[categorie_id]">
					<option value=""></option>
					{foreach $categories as $cat}
					<option value="{$cat.id}" {if $cat.id == $download->categorie_id}selected="selected"{/if} >{str_repeat(">",{$cat.level})}{$cat.name}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">{$lang.Fichier} :</label>
			<div class="controls">
				<span><input type="url" name="download[url]" id="downloadurl"/></span><span class="help-block">{$lang.Fichier_explication_dl}</span><br/><br/>
				<span><input type="file" name="fichier" id="fichier" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="name">{$lang.Description} :</label>
			<div class="controls"><textarea name="download[description]" id="description" class="input-xlarge" rows="4">{$download->description}</textarea></div>
		</div>

		<div class="control-group">
			<label class="control-label">{$lang.Apercu} :</label>
			<div class="controls"><span><input type="file" name="image" id="image" /><input type="hidden" name="MAX_FILE_SIZE" value="1000000"></div>
		</div>
		
		<!-- Disponibilité des fichiers -->
		<div class="control-group">
			<label class="control-label" for="fichier_for">Fichier disponible pour :</label>
			<div class="controls">
				<select name="download[download_for]" id="fichier_for">
					<option value="all" {if $download->download_for == 'all'}selected="selected"{/if}>Tout le monde</option>
					<option value="member" {if $download->download_for == 'member'}selected="selected"{/if}>Utilisateurs enregistres</option>
				</select>
			</div>
		</div>
		<!-- actif -->
		<div class="control-group">
			<label class="control-label" for="visible">{$lang.Visible} :</label>
			<div class="controls">
				<select name="download[visible]" id="visible">
					<option value="1" {if $download->visible == 1}selected="selected"{/if}>{$lang.Oui}</option>
					<option value="0" {if $download->visible == 0}selected="selected"{/if}>{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="form-actions">
			<input type="hidden" name="download[id]" value="{$download->id}" />
			<input type="hidden" name="download[add_by]" value="{$download->add_by}" />
			<input type="hidden" name="download[vue]" value="{$download->vue}" />
			<input type="hidden" name="download[downloaded]" value="{$download->downloaded}" />
			<input type="submit" name="send" class="btn btn-primary" value="{$lang.Enregistrer}" />
		</div>
	</fieldset>
</form>
{/strip}
<script>
jQuery(document).ready(function(){
	$('#FormAdd').validate({
		rules: {
			'download[name]':'required',
			'download[url]': {
				url: true,
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
	})
});
$(document).ready(function()	{
   $('#description').markItUp(mySettings);
});
</script>