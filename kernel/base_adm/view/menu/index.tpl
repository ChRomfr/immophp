<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Menu}</li>
</ul>

<div class="well">
    <div class="fright">
        <a href="{$Helper->getLinkAdm("menu/add")}" title="{$lang.Ajouter}"><i class="icon-plus"></i></a>
    </div>
    <legend>{$lang.Menu}</legend>
    <div class="clear"></div>

    <table class="table table-striped table-bordered table-condensed">
        <thead>
            <tr>
                <td>#</td>
                <td>{$lang.Menu}</td>
                <td></td>
            </tr>
        </thead>
        <tbody>
            {foreach $Menus as $Menu}
            <tr>
                <td>{$Menu.id}</td>
                <td>{$Menu.name}</td>
                <td style="text-align:center;">
                    <a href="{$Helper->getLinkAdm("menu/edit/{$Menu.id}")}" title=""><i class="icon-pencil"></i></a>&nbsp;
                    <a href="javascript:deleteMenu({$Menu.id})" title=""><i class="icon-trash"></i></a>
                </td>
            </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<script type="text/javascript">
<!--
function deleteMenu(menu_id){
    if( confirm('{$lang.Confirm_suppression_menu} ?') ){
        window.location.href = '{$Helper->getLinkAdm("menu/delete/'+menu_id+'")}'
    }
}
//-->
</script>