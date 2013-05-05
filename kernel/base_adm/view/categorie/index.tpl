{strip}

<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("{$smarty.get.c}")}" title="">{$smarty.get.c}</a><span class="divider">/</span></li>
	<li>{$lang.Categorie}</li>
</ul>

<div class="well">
	
	<div class="fright">
		<a href="#modalFormAdd" data-toggle="modal" title="{$lang.Ajouter}"><i class="icon-plus"></i></a>
	</div>

	<h4>{$lang.Categorie}</h4>

	<div class="clear"></div>	
	
	<table class="table table-bordered table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>{$lang.Categorie}</th>
				<th>{$lang.Action}</th>
			</tr>
		</thead>
		<tbody>
		{foreach $categories as $cat}
			<tr>
				<td>{$cat.id}</td>
				<td>{str_repeat("&gt;&gt;",{$cat.level})}{$cat.name}</td>
				<td class="center">
					<a href="javascript:getFormEdit({$cat.id});" title="{$lang.Edition}"><i class="icon-pencil"></i></a>
					&nbsp;&nbsp;&nbsp;
					<a href="javascript:delCat({$cat.id});" title="{$lang.Supprimer}"><i class="icon-trash"></i></a>
				</td>
			</tr>
		{/foreach}
		</tbody>
	</table>
</div>

<!-- Fenetre modal pour ajout -->
<div id="modalFormAdd" class="modal hide fade">
	<div class="modal-header">
		<h4>Nouvelle categorie</h4>
	</div>
	<div class="modal-body">
		<form method="post" class="form-horizontal" action="{$Helper->getLinkAdm("categorie/add?c={$smarty.get.c}")}" enctype="multipart/form-data">
		
			<div class="control-group">
				<label class="control-label">{$lang.Categorie} :</label></label>
				<div class="controls">
					<input type="text" name="categorie[name]" id="name_add" />
				</div>
			</div>
			
			<div class="control-group">
		        <label class="control-label">Parent :</label>
		        <div class="controls">
		            <select name="categorie[parent_id]">
		                <option value="0"></option>
						{foreach $categories as $categorie}
						<option value="{$categorie.id}" {if isset($smarty.get.parent_id) && $smarty.get.parent_id == $categorie.id}selected="selected"{/if}>{str_repeat(">",{$categorie.level})}{$categorie.name}</option>
						{/foreach}
		            </select>
		        </div>
		    </div>

		    <div class="control-group">
		    	<label class="control-label" for="description">{$lang.Description}</label>
		    	<div class="controls"><textarea name="categorie[description]" rows="4" cols="50"></textarea></div>
		    </div>

		    <div class="control-group">
		    	<label class="control-label" for="image">{$lang.Image}</label>
		    	<div class="controls"><input type="file" name="image" id="image" /></div>
		    </div>

	</div><!-- /model-body -->
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">Fermer</button>
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</form>
	</div>
</div>

<div id="modalFormEdit" class="modal hide fade">
	<div class="modal-header">
		<h4>Edition categorie</h4>
	</div>
	<div class="modal-body">
		<form method="post" class="form-horizontal" action="{$Helper->getLinkAdm("categorie/edit?c={$smarty.get.c}")}" enctype="multipart/form-data">
		
			<div class="control-group">
				<label class="control-label">{$lang.Categorie} :</label></label>
				<div class="controls">
					<input type="text" name="categorie[name]" id="name_edit" />
				</div>
			</div>
			
			<div class="control-group">
		        <label class="control-label">Parent :</label>
		        <div class="controls">
		            <select name="categorie[parent_id]" id="parent_id_edit" disabled="disabled">
		                <option value="0"></option>
						{foreach $categories as $categorie}
						<option value="{$categorie.id}" {if isset($smarty.get.parent_id) && $smarty.get.parent_id == $categorie.id}selected="selected"{/if}>{str_repeat(">",{$categorie.level})}{$categorie.name}</option>
						{/foreach}
		            </select>
		        </div>
		    </div>

		    <div class="control-group">
		    	<label class="control-label" for="description">{$lang.Description}</label>
		    	<div class="controls"><textarea name="categorie[description]" id="description_edit" rows="4" cols="50"></textarea></div>
		    </div>

		    <div class="control-group">
		    	<label class="control-label" for="image">{$lang.Image}</label>
		    	<div class="controls">
		    		<input type="file" name="image" id="image" />
		    	</div>
		    </div>

	</div><!-- /model-body -->
	<div class="modal-footer">
		<input type="hidden" name="categorie[id]" id="id_edit" />
		<input type="hidden" name="categorie[image]" id="image_edit" />
		<button class="btn" data-dismiss="modal" aria-hidden="true">Fermer</button>
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</form>
	</div>
</div>
{/strip}

<script type="text/javascript">
<!--
categories = new Array();

function getFormEdit(categorie_id){
	
	// Requete JSON pour recuperer les data.
	$.getJSON('{$Helper->getLinkAdm("categorie/getData/'+categorie_id+'?nohtml&c={$smarty.get.c}")}', function(data) {
		$('#name_edit').val(data.name);
		$('#description_edit').val(data.description);
		$('#id_edit').val(data.id);
		$('#parent_id_edit').val(data.parent_id);
		$('#image_edit').val(data.image);
	});

	$("#modalFormEdit").modal('show');
}

function delCat(id){
	if( confirm('{$lang.Confirm_suppression_categorie} ?') ){
		window.location.href='{$Helper->getLinkAdm("categorie/delete/")}'+id+'?c={$smarty.get.c}';
	}
}
//-->
</script>