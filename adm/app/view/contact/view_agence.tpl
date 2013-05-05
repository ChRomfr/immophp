<script type="text/javascript">
<!--
function deleteContact(id){
	if( confirm('{$lang.Confirm_suppression_message} ?') ){
		window.location.href='{getLinkAdm("contact/delete/'+id+'?type=agences")}';
	}
}
//-->
</script>

<div id="bread">
	<a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a>{$smarty.const.BREAD_SEP}
	<a href="{getLinkAdm("contact?type=agences")}" title="{$lang.Contact}">{$lang.Contact}</a>{$smarty.const.BREAD_SEP}
	#{$Contact.id}
</div>
<div class="showData">

<h1>{$lang.Contact}</h1>
<div class="tableau_simple">
    <table>
        <tr>
            <td>{$lang.Nom_prenom}</td>
            <td>{$Contact.nom}</td>
        </tr>
        <tr>
            <td>{$lang.Email}</td>
            <td>{$Contact.email}</td>
        </tr>
        <tr>
            <td>{$lang.Message}</td>
            <td>{$Contact.message|htmlentities|nl2br}</td>
        </tr>
        <tr>
            <td>{$lang.Date}</td>
            <td>{$Contact.add_on|date_format:$config.format_date}</td>
        </tr>
        <tr>
            <td>IP</td>
            <td>{$Contact.ip_visiteur}</td>
        </tr>
    </table>
        <div class="center"><br/><br/>
            <a href="mailto:{$Contact.email}" class="submit">{$lang.Repondre}</a>
        </div>
</div>
<div class="fright">
	<br/>
	<a href="javascript:deleteContact({$Contact.id})"><img src="{$config.url}{$config.url_dir}web/images/delete.png" alt="{$lang.Supprimer}" /></a>
</div>
<div class="clear"></div>
</div>