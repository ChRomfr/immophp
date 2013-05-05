<div class="showData">

    <h1>{$lang.Mon_compte}</h1>
    <div class="tableau_simple">
        <table>
            <tr>
                <td>{$lang.Identifiant} :</td>
                <td>{$smarty.session.utilisateur.identifiant}</td>
            </tr>
            <tr>
                <td>{$lang.Email} :</td>
                <td>{$smarty.session.utilisateur.email}</td>
            </tr>
        </table>
    </div>
    
    <!-- GCALENDAR -->
    {if $smarty.session.utilisateur.gmail_adr != '' && $smarty.session.utilisateur.gmail_password != ''}
    <br/>
    <h1>Google Calendar</h1>
    <div  style="width:700px;">
		<iframe src="https://www.google.com/calendar/embed?height=600&amp;wkst=1&amp;bgcolor=%23FFFFFF&amp;src={$smarty.session.utilisateur.gmail_adr}&amp;color=%232952A3&amp;ctz=Europe%2FParis" style=" border-width:0 " width="700" height="350" frameborder="0" scrolling="no"></iframe>
	</div>
    
    <!-- Affichage des visites futur avec lien pour envoie a google -->
    {if count($Visites) > 0}
        <br/>
        <h1>{$lang.Visites}</h1>
        <table class="tadmin">
            <thead>
                <tr>
                    <th>#</th>
                    <th>{$lang.Prospect}</th>
                    <th>{$lang.Date}</th>
                    <th>Calendrier google</th>
                </tr>
            </thead>
            <tbody>
            {foreach $Visites as $Row}
            <tr>
                <td><a href="{getLinkAdm("visite/detail/{$Row.id}")}" title="">{$Row.id}</a></td>
                <td>{$Row.p_nom} {$Row.p_prenom}</td>
                <td>{$Row.date_visite} {$Row.heure_visite}</td>
                <td>{if empty($Row.g_id)}<a href="{getLinkAdm("moncompte/addGCalandarVisite/{$Row.id}")}" title="">Ajouter au calendrier google{/if}</a></td>
            </tr>
            {/foreach}
            </tbody>
        </table>
        {/if}
    {/if}
</div>