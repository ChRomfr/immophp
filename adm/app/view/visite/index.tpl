<!--
START VISITE/INDEX.TPL
-->
<script type="text/javascript">
    $(document).ready(function() {
        $("a#fbcalendriervisite").fancybox();
    });
</script>

{strip}
<ul class="breadcrumb">
    <li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
    <li>{$lang.Visites}</li>
</ul>

<div class="well">

    <div class="fright">
        <a href="{getLinkAdm("visite/calendrier?nohtml")}" id="fbcalendriervisite"><i class="icon-calendar"></i></a>
    </div>

    <legend>{$lang.Visites}</legend>

    <div class="clear"></div>

    <table class="table table-condesed table-bordered table-striped">
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

    <hr/>

    <dl class="inline">
        <dt>Visite ce mois :</dt>
        <dd>{$NbVisiteMonth}</dt>
    </dl>

    <dl class="inline">
        <dt>Visite mois dernier :</dt>
        <dd>{$NbVisiteLastMonth}</dt>
    </dl>

</div><!-- /well ->
{/strip}
<!--
END VISITE/INDEX.TPL
-->