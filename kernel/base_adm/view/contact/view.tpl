<!-- 
    base_adm/view/contact/view.tpl
-->
{strip}
<ul class="breadcrumb">
    <li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
    <li><a href="{$Helper->getLinkAdm("contact")}">{$lang.Contact}</a><span class="divider">/</span></li>
    <li>#{$contact.id}</li>
</ul>

<div class="well">
    <h4>{$lang.Contact}</h4>
        <table class="table">
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

    <div class="center"><br/><br/>
        <a href="mailto:{$contact.email}" class="btn">{$lang.Repondre}</a>
    </div>

    <div class="fright">
        <br/>
        <a href="javascript:deleteContact({$contact.id})"><i class="icon-trash"></i></a>
    </div>
    <div class="clear"></div>
</div>
{/strip}
<script type="text/javascript">
<!--
function deleteContact(id){
    if( confirm('{$lang.Confirm_suppression_message} ?') ){
        window.location.href='{$Helper->getLinkAdm("contact/delete/")}'+id;
    }
}
//-->
</script>