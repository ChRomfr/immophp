{strip}

<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('news/index')}" title="{$lang.News}">{$lang.News}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<form method="post" id="newsEdit" class="form-horizontal well">
	<fieldset>
		<legend>{$lang.Edition}</legend>

		<div class="control-group">
			<label class="control-label" for="categorie">{$lang.Categorie}</label>
			<div class="controls">
				<select name="news[categorie_id]" id="categorie">
					<option></option>
					{foreach $categories as $categorie}
					<option value="{$categorie.id}" {if $news->categorie_id == $categorie.id}selected="selected"{/if}>{str_repeat(">",{$categorie.level})}{$categorie.name}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="titre">{$lang.Titre} :</label>
			<div class="controls"><input type="text" name="news[sujet]" id="titre" value="{$news->sujet}" size="50"/></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="contenu">{$lang.Contenu} :</label>
			<div class="controls"><textarea {if !isset($smarty.get.noeditor)}class="ckeditor"{else}class="input-xxlarge"{/if} name="news[contenu]" id="contenunews" rows="8">{$news->contenu}</textarea></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="commentaire">{$lang.Commentaire} :</label>
			<div class="controls">
				<select name="news[commentaire]" id="commentaire">
					<option value="1" {if $news->commentaire == 1}selected="selected"{/if}>{$lang.Oui}</option>
					<option value="0" {if $news->commentaire == 0}selected="selected"{/if}>{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="source">{$lang.Source} :</label>
			<div class="controls"><input type="text" name="news[source]" id="source" size="50" /></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="source_link">{$lang.Lien_source} :</label>
			<div class="controls"><input type="url" name="news[source_link]" id="source_link" size="50" placeholder="http://www.sources.com" /></div>
		</div>

		<div class="form-actions" style="text-align:center;">
			<input type="hidden" name="news[post_on]" value="{$news->post_on}" />
			<input type="hidden" name="news[auteur_id]" value="{$smarty.session.utilisateur.id}" />
			<input type="hidden" name="news[id]" value="{$news->id}" />
			<input type="submit" name="send" value="{$lang.Enregistrer}" class="btn btn-primary" />
		</div>
	</fieldset>
</form>
{/strip}
<script type="text/javascript">
<!--
$(document).ready(function(){
	$('#newsEdit').validate({
		rules: {
			'news[sujet]':'required',
			'news[contenu]':'required',
			'news[source_link]': {
				url:true
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

	});
});
$(document).ready(function()	{
   $('#contenunews').markItUp(mySettings);
});
//-->
</script>