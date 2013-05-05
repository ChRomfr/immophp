<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Contact}</li>
</ul>

{if isset($smarty.get.type)}
    <!-- BIENS -->
        {if $smarty.get.type == 'biens'}
        <div class="well">
            <legend>{$lang.Contact_par_annonce}</legend>
            <table class="table table-bordered table-striped table-condensed">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>{$lang.Visiteur}</th>
                        <th>{$lang.Email}</th>
                        <th>{$lang.Telephone}</th>
                        <th>{$lang.Bien}</th>
                        <th>{$lang.Reference}</th>
                        <th>{$lang.Lu}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $Contacts as $Row}
                    <tr>
                        <td><a href="{getLinkAdm("contact/view/{$Row.id}?type=biens")}" title="">{$Row.id}</a></td>
                        <td>{$Row.nom}</td>
                        <td>{$Row.email}</td>
                        <td>{$Row.telephone}</td>
                        <td>{$Row.b_nom}</td>
                        <td>{$Row.b_reference}</td>
                        <td>{if $Row.read == 0}<span style="color:red">{$lang.Non}</span>{else}<span style="color:green">{$lang.Oui}</span>{/if}</td>
                    </tr>    
                    {/foreach}
                </tbody>
            </table>
        </div>
        {/if}
    <!-- AGENCES -->
    {if $smarty.get.type == 'agences'}
        <div class="well">
            <legend>{$lang.Contact_par_agence}</legend>
            <table class="table table-bordered table-striped table-condensed">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>{$lang.Visiteur}</th>
                        <th>{$lang.Email}</th>
                        <th>{$lang.Telephone}</th>
                        <th>{$lang.Agence}</th>
                        <th>{$lang.Lu}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $Contacts as $Row}
                    <tr>
                        <td><a href="{getLinkAdm("contact/view/{$Row.id}?type=agences")}" title="">{$Row.id}</a></td>
                        <td>{$Row.nom}</td>
                        <td>{$Row.email}</td>
                        <td>{$Row.telephone}</td>
                        <td>{$Row.a_nom}</td>
                        <td>{if $Row.read == 0}<span style="color:red">{$lang.Non}</span>{else}<span style="color:green">{$lang.Oui}</span>{/if}</td>
                    </tr>    
                    {/foreach}
                </tbody>
            </table>
        </div>
    {/if}
{else}
<div class="well">
    <legend>{$lang.Contact}</legend>
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
            <td><a href="{getLinkAdm("contact/view/{$contact.id}")}">{$contact.id}</a></td>
            <td>{$contact.name}</td>
            <td>{$contact.email}</td>
            <td>{$contact.post_on|date_format:$config.format_date}</td>
            <td>{if $contact.lu == 0}<span style="color:red">{$lang.Non}</span>{else}<span style="color:green">{$lang.Oui}</span>{/if}</td>
        </tr>
        {/foreach}
    </table>
</div>
{/if}