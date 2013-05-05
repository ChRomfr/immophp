<script type="text/javascript">
<!--
categories = new Array();

function getFormCategorie(){
$( "#dialog-form" ).dialog( "open" );
}

function getFormEdit(categorie_id){
	
	// Requete JSON pour recuperer les data.
	$.getJSON('{getLinkAdm("categorie/getData/'+categorie_id+'?nohtml&c={$smarty.get.c}")}', function(data) {
		$('#name_edit').val(data.name);
		$('#description_edit').val(data.description);
		$('#id_edit').val(data.id);
		$('#parent_id_edit').val(data.parent_id);
	});

	$( "#dialog-form2" ).dialog( "open" );
}

function delCat(id){
	if( confirm('{$lang.Confirm_suppression_categorie} ?') ){
		window.location.href='{getLinkAdm("categorie/delete/")}'+id+'?c={$smarty.get.c}';
	}
}
	
$(function() {
	// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	
		$( "#dialog-form" ).dialog({
			autoOpen: false,			
			width: 800,
			modal: true,
			buttons: {
				Cancel: function() {
					$( this ).dialog( "close" );
				},
				
				Submit:  function(){
						
						if( $("#name").val() == ""){
							$("#name").css("border-color","red");
							
						}else{
							$("#formAdd").submit();
						}						
					}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});
		
		$( "#dialog-form2" ).dialog({
			autoOpen: false,
			width: 800,
			modal: true,
			buttons: {
				Cancel: function() {
					$( this ).dialog( "close" );
				},
				
				Submit:  function(){
						
						if( $("#name_edit").val() == ""){
							$("#name_edit").css("border-color","red");
							
						}else{
							$("#formEdit").submit();
						}						
					}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});
	});
//-->
</script>
{strip}

<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{getLinkAdm("{$smarty.get.c}")}" title="">{$smarty.get.c}</a><span class="divider">/</span></li>
	<li>{$lang.Categorie}</li>
</ul>

<div class="well">
	
	<div class="fright">
		<a href="javascript:getFormCategorie();" title="{$lang.Ajouter}"><i class="icon-plus"></i></a>
	</div>

	<legend>{$lang.Categorie}</legend>

	<div class="clear"></div>	
	
	<table class="table table-bordered table-striped">
		<thead>
			<tr>
				<td>#</td>
				<td>{$lang.Categorie}</td>
				<td>{$lang.Action}</td>
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

<div id="dialog-form" title="Create new categorie">

	<form method="post" action="{getLinkAdm("categorie/add?c={$smarty.get.c}")}" id="formAdd" class="form">
	<dl>
		<dt><label for="name">{$lang.Categorie} :</label></dt>
		<dd><input type="text" name="categorie[name]" id="name" class="text ui-widget-content ui-corner-all validate[required]" /></dt>
	</dl>
	<dl>
        <dt><label>Parent :</label></dt>
        <dd>
            <select name="categorie[parent_id]">
                <option value="0"></option>
				{foreach $categories as $categorie}
				<option value="{$categorie.id}" {if isset($smarty.get.parent_id) && $smarty.get.parent_id == $categorie.id}selected="selected"{/if}>{str_repeat(">",{$categorie.level})}{$categorie.name}</option>
				{/foreach}
            </select>
        </dd>
    </dl>
    <dl>
    	<dt><label for="description">{$lang.Description}</label></dt>
    	<dd><textarea name="categorie[description]" rows="4" cols="50"></textarea></dd>
    </dl>
	</form>
</div>

<div id="dialog-form2" title="Edit categorie">
	<form method="post" action="{getLinkAdm("categorie/edit?c={$smarty.get.c}")}" id="formEdit">	
	<dl>
		<dt><label for="name">{$lang.Categorie} :</label></dt>
		<dd><input type="text" name="categorie[name]" id="name_edit" class="text ui-widget-content ui-corner-all validate[required]" /></dt>
	</dl>
	<dl>
        <dt><label>Parent :</label></dt>
        <dd>
            <select name="categorie[parent_id]" id="parent_id_edit" disabled="disabled">
                <option value="0"></option>
				{foreach $categories as $categorie}
				<option value="{$categorie.id}" {if isset($smarty.get.parent_id) && $smarty.get.parent_id == $categorie.id}selected="selected"{/if}>{str_repeat(">",{$categorie.level})}{$categorie.name}</option>
				{/foreach}
            </select>
        </dd>
    </dl>
    <dl>
    	<dt><label for="description">{$lang.Description}</label></dt>
    	<dd><textarea name="categorie[description]" rows="4" cols="50" id="description_edit"></textarea></dd>
    </dl>
	<input type="hidden" name="categorie[id]" id="id_edit" />
	</form>
</div>{/strip}