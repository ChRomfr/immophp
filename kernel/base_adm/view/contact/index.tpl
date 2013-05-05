<!-- 
    base_adm/view/contact/index.tpl
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Contact}</li>
</ul>

<div class="well">
    <h4>{$lang.Contact}</h4>
    <table class="table table-bordered table-striped table-condensed">
        <thead>
            <tr>
                <td>#</td>
                <td>{$lang.Personne}</td>
                <td>{$lang.Email}</td>
                <td>{$lang.Date}</td>
                <td>{$lang.Lu}</td>
            </tr>
        </thead>
        {foreach $Contacts as $contact}
        <tr>
            <td><a href="{$Helper->getLinkAdm("contact/view/{$contact.id}")}">{$contact.id}</a></td>
            <td>{$contact.name}</td>
            <td>{$contact.email}</td>
            <td>{$contact.post_on|date_format:$config.format_date}</td>
            <td>{if $contact.lu == 0}<span style="color:red">{$lang.Non}</span>{else}<span style="color:green">{$lang.Oui}</span>{/if}</td>
        </tr>
        {/foreach}
    </table>
    <div class="pagination">{$Pagination->render()}</div>
</div>
{/strip}