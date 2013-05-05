<!--
base_adm/link/add.tpl
-->
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('link')}" title="Liens">Liens</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>

<form method="post" class="form-horizontal well" action="" id="FormAdd"  enctype="multipart/form-data">
	<fieldset>
		<legend>Nouveau lien</legend>

		<div class="control-group">
			<label class="control-label" for="name">{$lang.Nom} :</label>
			<div class="controls"><input type="text" name="link[name]" id="name" /></div>
		</div>
		

		<div class="control-group">
			<label class="control-label" for="name">Url:</label>
			<div class="controls"><input type="url" name="link[url]" id="url" /></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="categorie_id">{$lang.Categorie} :</label>
			<div class="controls">
				<select name="link[categorie_id]">
					<option value=""></option>
					{foreach $categories as $cat}
					<option value="{$cat.id}">{str_repeat(">",{$cat.level})}{$cat.name}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="name">{$lang.Description} :</label>
			<div class="controls"><textarea name="link[description]" id="description" class="input-xlarge" rows="4"></textarea></div>
		</div>

		<div class="control-group">
			<label class="control-label">{$lang.Apercu} :</label>
			<div class="controls"><span><input type="file" name="image" id="image" /><input type="hidden" name="MAX_FILE_SIZE" value="1000000"></div>
		</div>
		
		<!-- actif -->
		<div class="control-group">
			<label class="control-label" for="actif">{$lang.Visible} :</label>
			<div class="controls">
				<select name="link[actif]" id="actif">
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<!-- apersite -->
		<div class="control-group">
			<label class="control-label" for="apersite">Miniature du site:</label>
			<div class="controls">
				<select name="link[apersite]" id="apersite">
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="form-actions">
			<input type="hidden" name="link[auteur_id]" value="{$smarty.session.utilisateur.id}" />
			<input type="hidden" name="link[valid]" value="1" />
			<input type="submit" name="send" class="btn btn-primary" value="{$lang.Enregistrer}" />
		</div>
	</fieldset>
</form>
{/strip}
<script>
jQuery(document).ready(function(){
	$('#FormAdd').validate({
		rules: {
			'link[name]':'required',
			'link[url]': {
				required:true,
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