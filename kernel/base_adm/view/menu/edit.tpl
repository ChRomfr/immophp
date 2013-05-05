{strip}

<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('menu/index')}" title="{$lang.Menu}">{$lang.Menu}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<form id="formMenu" action="#" method="post" class="well">
	<fielset>
    <legend>{$lang.Edition_menu}</legend>
	<dl>
		<dt><label for="name">{$lang.Nom} :</label></dt>
		<dd><input type="text" name="menu[name]" id="name" class="validate[required]" required value="{$Menu->name}"/></dd>
	</dl>
	
	<div class="fright">
		<a href="javascript:add_link();" title=""><i class="icon-plus"></i></a>
	</div>
	<div class="clear"></div>
	{* TABLEAU DES LIENS *}
	<table class="table table-bordered table-striped table-condensed" id="links_list">
		<thead>
			<tr>
				<th>{$lang.Nom}</th>
				<th>{$lang.Lien}</th>
				<th>{$lang.Visible_par}</th>
				<th>{$lang.Nouvelle_page}</th>				
				<th>{$lang.Actif}</th>
				<th>{$lang.Position}</th>
			</tr>
		</thead>
		<tbody>
			{foreach $Menu->links as $link name=liens}
			<tr class="MoveableRow">
				<td><input type="text" name="link[{$smarty.foreach.liens.iteration}][name]" id="link_name_{$smarty.foreach.liens.iteration}" value="{$link.name}" required  onkeypress="getlinks({$smarty.foreach.liens.iteration})" class="input-small"/></td>
				<td><input type="text" name="link[{$smarty.foreach.liens.iteration}][link]" id="link_link_{$smarty.foreach.liens.iteration}" value="{$link.link}" class="input-small" required /></td>
				<td>
					<select name="link[{$smarty.foreach.liens.iteration}][visible_by]" id="">
						<option value="all" {if $link.visible_by == 'all'}selected="selected"{/if}>{$lang.Tout_le_monde}</option>
						<option value="member" {if $link.visible_by == 'member'}selected="selected"{/if}>{$lang.Membres}</option>
						<option value="administrateurs" {if $link.visible_by == 'administrateurs'}selected="selected"{/if}>{$lang.Administrateur}</option>
					</select>
				</td>
				<td><input type="checkbox" name="link[{$smarty.foreach.liens.iteration}][new_page]" id="" {if $link.new_page == 1}checked="checked"{/if} /></td>
				<td><input type="checkbox" name="link[{$smarty.foreach.liens.iteration}][enabled]" id="" {if $link.enabled == 1}checked="checked"{/if}/></td>
				<td>
					<span class="down_button"><i class="icon-arrow-down"></i></span>&nbsp;
					<span class="up_button"><i class="icon-arrow-down"></i></span>&nbsp;
					<i class="icon-trash delete"></i>
				</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
	
	<div class="center form_submit">
		<input type="hidden" name="menu[id]" value="{$Menu->id}" />
		<input type="submit" value="{$lang.Enregistrer}" class="btn" />
	</div>
	</fielset>
</form>
{/strip}

<script>
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#formMenu").validationEngine();
	
	
	$('.down_button').live('click', function () {
    var rowToMove = $(this).parents('tr.MoveableRow:first');
    var next = rowToMove.next('tr.MoveableRow')
    if (next.length == 1) { next.after(rowToMove); }
	});

	$('.up_button').live('click', function () {
    var rowToMove = $(this).parents('tr.MoveableRow:first');
    var prev = rowToMove.prev('tr.MoveableRow')
    if (prev.length == 1) { prev.before(rowToMove); }
	});
	
	$('#links_list td i.delete').live('click', function(){
		$(this).parent().parent().remove();
	});
});

var nb_links = {$nb_links}

function add_link(){
	nb_links = nb_links + 1
	
	$.get(
            '{$Helper->getLinkAdm("menu/getNewLink")}',{literal}
            {id_for_link:nb_links, nohtml:'nohtml'},
            function(data){ $("#links_list tbody").append(data); }
        )
		{/literal}
}


function getlinks(ligne_number){
	
	$('#link_name_' + ligne_number).autocomplete({
		source:'{$Helper->getLinkAdm("menu/getLinkList?nohtml=nohtml")}',
		minLength:0,
		dataType:"json",
		delay:0,
		select: function(e, ui){
			$('#link_name_' + ligne_number).val(ui.item.name);
			$('#link_link_' + ligne_number).val(ui.item.link);
			return false;
		}
		
	})
	.data( "ui-autocomplete" )._renderItem = function( ul, item ) {
    return $( "<li>" )
        /*.data( "item.autocomplete", item )*/
        .append( "<a>" + item.name + "</a>" )
        .appendTo( ul );
	};
}


</script>