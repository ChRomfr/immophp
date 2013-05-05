{strip}

<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('article/index')}" title="{$lang.Article}">{$lang.Article}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<form method="post" action="#" id="formArticle" class="form-horizontal well" enctype="multipart/form-data">
	<fieldset>
		<legend>{$lang.Nouvel_article}</legend>

		<div class="control-group">
			<label class="control-label" for="title">{$lang.Titre} :</label>
			<div class="controls"><input type="text" name="article[title]" id="title" required class="input-xlarge" value="{$Article->title}" /></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="categorie">{$lang.Categorie} :</label>
			<div class="controls">
				<select name="article[categorie_id]" id="categorie">
					<option></option>
					{foreach $Categories as $Categorie}
					<option value="{$Categorie.id}" {if $Article->categorie_id == $Categorie.id}selected="selected"{/if}>{str_repeat(">",{$Categorie.level})}{$Categorie.name}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="article">{$lang.Article} :</label>
			<div class="controls"><textarea name="article[article]" id="article" class="input-xxlarge" rows="10">{$Article->article}</textarea></div>
		</div>

		<!-- Image representant l article -->
		<div class="control-group">
			<label class="control-label" for="image">{$lang.Image} :</label>
			<div class="controls">
				<input type="file" name="image" />
				{if !empty($Article->image)}
					<br/><img src="{$config.url}{$config.url_dir}web/upload/article/{$Article->id}/{$Article->image}" alt="" style="width:100px;"/>
				{/if}
			</div>			
		</div>
	
		<!-- Fichier -->
		<div class="control-group">
			<label class="control-label" for="fichier">{$lang.Fichier} :</label>
			<div class="controls">
				<input type="file" name="fichier" />
				{if $Article->fichier != ''}
					<br/><a href="{$config.url}{$config.url_dir}web/upload/article/{$Article->id}/{$Article->fichier}" target="_blank">{$lang.Voir}</a>
				{/if}
			</div>
		</div>

		<!-- Disponibilité des fichiers -->
		<div class="control-group">
			<label class="control-label" for="fichier_for">Fichier disponible pour :</label>
			<div class="controls">
				<select name="article[fichier_for]" id="fichier_for">
					<option value="all" {if $Article->fichier_for == 'all'}selected="seleted"{/if}>Tout le monde</option>
					<option value="member" {if $Article->fichier_for == 'member'}selected="seleted"{/if}>Utilisateurs enregistres</option>
				</select>
			</div>
		</div>

		<!-- Video -->
		<div class="control-group">
			<label class="control-label" for="video">Video :</label>
			<div class="controls">
				<select name="article[video]" id="video">
					<option value="1" {if $Article->video == 1}selected="selected"{/if}>{$lang.Oui}</option>
					<option value="0" {if $Article->video == 0}selected="selected"{/if}>{$lang.Non}</option>
				</select>
			</div>
		</div>

		<!-- actif -->
		<div class="control-group">
			<label class="control-label" for="visible">{$lang.Visible} :</label>
			<div class="controls">
				<select name="article[visible]" id="visible">
					<option value="1" {if $Article->visible == 1}selected="selected"{/if}>{$lang.Oui}</option>
					<option value="0" {if $Article->visible == 0}selected="selected"{/if}>{$lang.Non}</option>
				</select>
			</div>
		</div>

		<!-- commentaire -->
		<div class="control-group">
			<label class="control-label" for="commentaire">{$lang.Commentaire} :</label>
			<div class="controls">
				<select name="article[commentaire]" id="commentaire">
					<option value="1" {if $Article->commentaire == 1}selected="selected"{/if}>{$lang.Oui}</option>
					<option value="0" {if $Article->commentaire == 0}selected="selected"{/if}>{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="form-actions">
			<input type="hidden" name="article[id]" value="{$Article->id}" />
			<input type="hidden" name="article[creat_on]" value="{$Article->creat_on}" />
			<input type="hidden" name="article[author]" value="{$Article->author}" />
			<input type="hidden" name="article[image]" value="{$Article->image}" />
			<input type="hidden" name="article[fichier]" value="{$Article->fichier}" />
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
	})
});
$(document).ready(function()	{
   $('#article').markItUp(mySettings);
});
</script>