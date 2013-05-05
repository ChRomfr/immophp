
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('download/index')}" title="{$lang.Telechargement}">{$lang.Telechargement}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>
<div class="alert alert-error" style="display:none;" id="alerte">Veuillez indiquer l'url du fichier ou l'envoyer par le formulaire</div>
<form method="post" class="form-horizontal well" action="" id="FormAdd" onsubmit="return checkDownload()" enctype="multipart/form-data">
	<fieldset>
		<legend>Nouveau telechargement</legend>
		<div class="control-group">
			<label class="control-label" for="name">{$lang.Nom} :</label>
			<div class="controls"><input type="text" name="download[name]" id="name" class="validate[required]" /></div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="categorie_id">{$lang.Categorie} :</label>
			<div class="controls">
				<select name="download[categorie_id]">
					<option value=""></option>
					{foreach $categories as $cat}
					<option value="{$cat.id}">{str_repeat(">",{$cat.level})}{$cat.name}</option>
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
			<div class="controls"><textarea name="download[description]" id="description" class="input-xlarge" rows="4"></textarea></div>
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
					<option value="all">Tout le monde</option>
					<option value="member">Utilisateurs enregistres</option>
				</select>
			</div>
		</div>
		<!-- actif -->
		<div class="control-group">
			<label class="control-label" for="visible">{$lang.Visible} :</label>
			<div class="controls">
				<select name="download[visible]" id="visible">
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="form-actions">
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

function checkDownload(){
	if( $("#fichier").val() == '' && $("#downloadurl").val() == ''){
		$('#alerte').css('display','block');
		return false;
	}else{
		return true;
	}
}

$(document).ready(function()	{
   $('#description').markItUp(mySettings);
});
</script>