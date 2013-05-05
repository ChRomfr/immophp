{*
*	SHARKPHP VA
*	CMS FOR VIRTUAL AIRLINE
*	@author ChRom
*	@web http://va.sharkphp.com
*}
<script type="text/javascript">
<!--
function deleteMenu(menu_id){
	if( confirm('{$lang.Confirm_suppression_menu} ?') ){
		window.location.href = '{getLinkAdm("menu/delete/'+menu_id+'")}'
	}
}
//-->
</script>

<ul class="breadcrumb">
	<li><a href="{getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Menu}</li>
</ul>

<div class="well">
    <div class="fright">
        <a href="{getLinkAdm("menu/add")}" title="{$lang.Ajouter}"><img src="{$smarty.const.URL_IMG_ACTION}add.png" alt="" /></a>
    </div>
    <legend>{$lang.Menu}</legend>
    <div class="clear"></div>

    <table class="table table-striped table-bordered">
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
                <td class="center">
                    <a href="{getLinkAdm("menu/edit/{$Menu.id}")}" title=""><img src="{$smarty.const.URL_IMG_ACTION}edit.png" /></a>&nbsp;
                    <a href="javascript:deleteMenu({$Menu.id})" title=""><img src="{$smarty.const.URL_IMG_ACTION}delete.png" /></a>
                </td>
            </tr>
            {/foreach}
        </tbody>
    </table>
</div>