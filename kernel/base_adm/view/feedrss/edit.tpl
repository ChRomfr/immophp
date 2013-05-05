{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('feedRss')}" title="Gestionnaire de flux Rss">Gestionnaire de flux Rss</a><span class="divider">/</span></li>
	Edition
</ul>

<form method="post" action="#" id="formEditFlux" class="well form-horizontal">
	<fieldset>
		<legend>Edition</legend>

		<div class="control-group">
			<label class="control-label">Nom du flux</label>
			<div class="controls">
				<input type="text" name="link[name]" id="name" class="input-xlarge" required value="{$Flux->name}" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">Url du flux</label>
			<div class="controls">
				<input type="url" name="link[link]" id="link" class="input-xlarge" required value="{$Flux->link}"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">Description</label>
			<div class="controls">
				<textarea name="link[description]" id="description" class="input-xlarge" value="{$Flux->description}"></textarea>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="categorie_id">{$lang.Categorie} :</label>
			<div class="controls">
				<select name="link[categorie_id]">
					<option value=""></option>
					{foreach $categories as $cat}
					<option value="{$cat.id}" {if $cat.id == $Flux->categorie_id}selected="selected"{/if} >{str_repeat(">",{$cat.level})}{$cat.name}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">Actif</label>
			<div class="controls">
				<select name="link[actif]" id="actif">
					<option value="1" {if $Flux->actif == 1}selected="selected"{/if}>Oui</option>
					<option value="0" {if $Flux->actif == 0}selected="selected"{/if}>Non</option>
				</select>
			</div>
		</div>

		<div class="form-actions">
			<input type="hidden" name="link[image]" value="{$Flux->image}" />
			<input type="hidden" name="link[id]" value="{$Flux->id}" />
			<input type="hidden" name="link[add_on]" value="{$Flux->add_on}" />
			<button class="btn btn-primary" type="submit">Enregistrer</button>
		</div>

	</fieldset>
</form>
{/strip}
<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	$("#formEditFlux").validate({
		rules:{
			"link[name]":{
				required:true,
			},
			"link[url]":{
				required:true,
				url:true,
			},
		},
		messages:{
			"link[name]":{
				required:"Veuillez indiquer le nom du flux",
			},
			"link[url]":{
				required:"Veuillez indiquer l'adresse du flux",
				url:"Adresse invalide",
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
//-->
</script>