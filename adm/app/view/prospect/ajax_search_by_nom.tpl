<table class="table table-condensed table-striped table-bordered">
    <thead>
        <tr>
            <th>{$lang.Prospect}</th>
            <th>{$lang.Acheteur}</th>
            <th>{$lang.Vendeur}</th>
            <th>{$lang.Ajouter_le}</th>
            <th>{$lang.Ajouter_par}</th>
        </tr>
    </thead>
    <tbody>
        {foreach $Prospects as $Row}
        <tr>
            <td><a href="{getLinkAdm("prospect/fiche/{$Row.id}")}" title="">{$Row.nom} {$Row.prenom}</a></td>
            <td class="center">{if $Row.acheteur == 1}<img src="{$config.url}{$config.url_dir}web/images/okSmall.png" alt="" />{else}<img src="{$config.url}{$config.url_dir}web/images/noSmall.png" alt="" />{/if}</td>
            <td class="center">{if $Row.vendeur == 1}<img src="{$config.url}{$config.url_dir}web/images/okSmall.png" alt="" />{else}<img src="{$config.url}{$config.url_dir}web/images/noSmall.png" alt="" />{/if}</td>
            <td>{$Row.add_on|date_format}</td>
            <td>{$Row.user_add}</td>
        </tr>
        {/foreach}
    </tbody>
</table>