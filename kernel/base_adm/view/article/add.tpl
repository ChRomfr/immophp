<!-- 
	base_app/view/article/add.tpl
//-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li> 
	<li><a href="{$Helper->getLinkAdm('article/index')}" title="{$lang.Article}">{$lang.Article}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>

<form method="post" action="#" id="formArticle" class="form-horizontal well" enctype="multipart/form-data">
	<fieldset>
		<legend>{$lang.Nouvel_article}</legend>

		<div class="control-group">
			<label class="control-label" for="title">{$lang.Titre} :</label>
			<div class="controls"><input type="text" name="article[title]" id="title" required class="input-xlarge" /></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="categorie">{$lang.Categorie} :</label>
			<div class="controls">
				<select name="article[categorie_id]" id="categorie">
					<option></option>
					{foreach $Categories as $Categorie}
					<option value="{$Categorie.id}">{str_repeat(">",{$Categorie.level})}{$Categorie.name}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="article">{$lang.Article} :</label>
			<div class="controls"><textarea name="article[article]" id="article" class="input-xxlarge" rows="10"></textarea></div>
		</div>

		<!-- Image representant l article -->
		<div class="control-group">
			<label class="control-label" for="image">{$lang.Image} :</label>
			<div class="controls">
				<input type="file" name="image" />
			</div>
		</div>
	
		<!-- Fichier -->
		<div class="control-group">
			<label class="control-label" for="fichier">{$lang.Fichier} :</label>
			<div class="controls">
				<input type="file" name="fichier" />
			</div>
		</div>

		<!-- Disponibilité des fichiers -->
		<div class="control-group">
			<label class="control-label" for="fichier_for">Fichier disponible pour :</label>
			<div class="controls">
				<select name="article[fichier_for]" id="fichier_for">
					<option value="all">Tout le monde</option>
					<option value="member">Utilisateurs enregistres</option>
				</select>
			</div>
		</div>

		<!-- Video -->
		<div class="control-group">
			<label class="control-label" for="video">Video :</label>
			<div class="controls">
				<select name="article[video]" id="video">
					<option value="1">{$lang.Oui}</option>
					<option value="0" selected="selected">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<!-- actif -->
		<div class="control-group">
			<label class="control-label" for="visible">{$lang.Visible} :</label>
			<div class="controls">
				<select name="article[visible]" id="visible">
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<!-- commentaire -->
		<div class="control-group">
			<label class="control-label" for="commentaire">{$lang.Commentaire} :</label>
			<div class="controls">
				<select name="article[commentaire]" id="commentaire">
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="form-actions">
			<input type="submit" value="{$lang.Enregistrer}" class="btn btn-primary" />
		</div>

	</fieldset>
</form>
{/strip}
<script type="text/javascript">
jQuery(document).ready(function(){
	$('#formArticle').validate({
		rules: {
			'article[titre]': 'required',
			'article[article]': 'required',
		}
	});
});
$(document).ready(function()	{
   $('#article').markItUp(mySettings);
});
</script>