{strip}
{if count($Contacts) > 0}
<div class="showData">
    <legend>{$lang.Contact_par_agence}</legend>
    <table class="table table-bordered table-striped table-condensed">
        <thead>
            <tr>
                <th>#</th>
                <th>{$lang.Visiteur}</th>
                <th>{$lang.Email}</th>
                <th>{$lang.Telephone}</th>
                <th>{$lang.Agence}</th>
            </tr>
        </thead>
        <tbody>
            {foreach $Contacts as $Row}
            <tr>
                <td>{$Row.id}</td>
                <td>{$Row.nom}</td>
                <td>{$Row.email}</td>
                <td>{$Row.telephone}</td>
                <td>{$Row.a_nom}</td>
            </tr>    
            {/foreach}
        </tbody>
    </table>
</div>
{/if}
{/strip}