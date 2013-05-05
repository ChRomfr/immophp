{if count($Visites) > 0}
{strip}
<div class="well">
    <legend>{$lang.Visites}</legend>
    <table class="table table-condensed table-bordered table-striped">
        <thead>
            <tr>
                <th>#</th>
                <th>{$lang.Prospect}</th>
                <th>{$lang.Date}</th>
                <th>{$lang.Collaborateur}</th>
            </tr>
        </thead>
        <tbody>
        {foreach $Visites as $Row}
        <tr>
            <td><a href="{getLinkAdm("visite/detail/{$Row.id}")}" title="">{$Row.id}</a></td>
            <td>{$Row.p_nom} {$Row.p_prenom}</td>
            <td>{$Row.date_visite} {$Row.heure_visite}</td>
            <td>{$Row.identifiant}</td>
        </tr>
        {/foreach}
        </tbody>
    </table>
</div>
{/strip}
{/if}