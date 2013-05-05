<script type="text/javascript">
<!--
function deleteContact(id){
	if( confirm('{$lang.Confirm_suppression_message} ?') ){
		window.location.href='{getLinkAdm("contact/delete/")}'+id;
	}
}
//-->
</script>
{strip}
<div id="bread">
	<a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a>{$smarty.const.BREAD_SEP}
	<a href="{getLinkAdm("contact")}" title="{$lang.Contact}">{$lang.Contact}</a>{$smarty.const.BREAD_SEP}
	#{$contact.id}
</div>
<div class="showData">
    <h1>{$lang.Contact}</h1>
    <div class="tableau_simple">
        <table>
            <tr>
                <td>{$lang.Nom_prenom}</td>
                <td>{$contact.name}</td>
            </tr>
            <tr>
                <td>{$lang.Email}</td>
                <td>{$contact.email}</td>
            </tr>
            <tr>
                <td>{$lang.Message}</td>
                <td>{$contact.message|htmlentities|nl2br}</td>
            </tr>
            <tr>
                <td>{$lang.Date}</td>
                <td>{$contact.post_on|date_format:$config.format_date}</td>
            </tr>
            <tr>
                <td>IP</td>
                <td>{$contact.ip}</td>
            </tr>
        </table>
    </div>
    <div class="center"><br/><br/>
        <a href="mailto:{$contact.email}" class="submit">{$lang.Repondre}</a>
    </div>

    <div class="fright">
        <br/>
        <a href="javascript:deleteContact({$contact.id})"><img src="{$config.url}{$config.url_dir}web/images/delete.png" alt="{$lang.Supprimer}" /></a>
    </div>
    <div class="clear"></div>
</div>
{/strip}