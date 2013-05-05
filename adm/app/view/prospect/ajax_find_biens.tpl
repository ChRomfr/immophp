{strip}
{if count($Biens) > 0}
<table class="table table-bordered table-striped table-condensed">
    <thead>
        <tr>
            <th>{$lang.Reference}</th>
            <th>{$lang.Bien}</th>
            <th>{$lang.Categorie}</th>
            <th>{$lang.Transaction}</th>
            <th>{$lang.En_ligne}</th>
        </tr>
    </thead>
    <tbody>
        {foreach $Biens as $Row}
            <tr>
                <td><a href="{getLink("annonce/detail/{$Row.id}")}" title="">{$Row.reference}</a></td>
                <td>{$Row.nom}</td>
                <td>{$Row.categorie}</td>
                <td>{$Row.transaction_type}</td>
                <td class="center">
                    <img src="{$config.url}{$config.url_dir}web/images/{if $Row.visible == 1}okSmall.png{elseif $Row.visible == 0}noSmall.png{/if}" alt="" />
                </td>
            </tr>
        {/foreach}
    </tbody>
</table>
{else}
    <div class="alert alert-block">
        <p>{$lang.Explication_prospect_find_biens}</p>
    </div>
{/if}
{/strip}