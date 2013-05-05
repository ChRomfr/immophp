<!-- 
START ADM/AGENCE/DETAIL
-->
{strip}
<ul class="breadcrumb">
	<li><a href="{getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{getLinkAdm("agence")}" title="{$lang.Agence}">{$lang.Agence}</a><span class="divider">/</span></li>
	<li>{$Agence->nom}</li>
</ul>

<div class="well">
	<table class="table">
		<tbody>
			<tr>
				<td>{$lang.Agence} :</td>
				<td>{$Agence->nom}</td>
			</tr>
			<tr>
				<td>Nombre de bien :</td>
				<td>{$NbBiens}</td>
			</tr>
			<tr>
				<td>Nombre de bien saisie ce mois :</td>
				<td>{$NbBienSaisieMois}</td>
			</tr>
			<tr>
				<td>Nombre de bien vendu ce mois :</td>
				<td>{$NbBienVenduMois}</td>
			</tr>
			<tr>
				<td>Total des ventes ce mois :</td>
				<td>{$TotalVente}</td>
			</tr>
			<tr>
				<td>Total des frais agence ce mois :</td>
				<td>{$TotalFraisAgence}</td>
			</tr>
			<tr>
				<td>Total des commissions vendeur ce mois :</td>
				<td>{$TotalComVendeur}</td>
			</tr>
		</tbody>
	</table>

	<!-- TABS -->
	<ul id="tabFicheAgence" class="nav nav-tabs">
		<li class="active"><a href="#tabBiens" data-toggle="tab">{$lang.Biens}</a></li>
		<li><a href="#tabProspects" data-toggle="tab">{$lang.Prospects}</a></li>
		<li><a href="#tabUtilisateurs" data-toggle="tab">{$lang.Utilisateurs}</a></li>
	</ul><!-- /tabFicheAgence -->

	<div class="tab-content">
		<div id="tabBiens" class="tab-pane active">
			<!-- Tableau des biens dans l agence -->
			<h4>{$lang.Biens}</h4>
			<table class="table table-bordered table-striped  table-condensed" id="tableauBiens">
				<thead>
			        <tr>
			            <th>{$lang.Reference}</th>
			            <th>{$lang.Bien}</th>
			            <th>{$lang.Categorie}</th>
			            <th>{$lang.Transaction}</th>
			            <th>{$lang.En_ligne}</th>
			            <th>{$lang.Vendu}</th>
			        </tr>
			    </thead>
			    <tbody>

			    </tbody>
			</table>
		</div><!-- /tabBiens -->

		<div id="tabProspects" class="tab-pane">
			<!-- Tableau des prospects dans l agence -->
			<h4>{$lang.Prospects}</h4>
			<table class="table table-bordered table-striped  table-condensed" id="tableauProspects">
				<thead>
			        <tr>
			            <th>{$lang.Prospect}</th>
			            <th>{$lang.Acheteur}</th>
			            <th>{$lang.Vendeur}</th>
			            <th>{$lang.Telephone}</th>
			        </tr>
			    </thead>
			    <tbody>

			    </tbody>
			</table>
		</div><!-- /tabProspects -->

		<div id="tabUtilisateurs" class="tab-pane">
			<h4>{$lang.Utilisateurs}</h4>
			<table class="table table-bordered table-striped  table-condensed" id="tableauUtilisateurs">
				<thead>
			        <tr>
			            <th>{$lang.Utilisateur}</th>
			            <th>{$lang.Identifiant}</th>
			            <th>{$lang.Email}</th>
			        </tr>
			    </thead>
			    <tbody>

			    </tbody>
			</table>
		</div><!-- /tabUtilisateurs -->


	</div><!-- /tab-contant -->	

</div><!-- /well -->
{/strip}
<script>
(function($){
$.get(
    '{$Helper->getLinkAdm("agence/getBiens/{$Agence->id}")}', {literal}
    {nohtml:'nohtml'},
    function(data){ 
        var tplHistorique = '<tr><td><a href="javascript:goToAnnonce({{id}});">{{reference}}</a></td><td>{{nom}}</td><td>{{categorie}}</td><td>{{transaction_type}}</td><td style="text-align:center">{{#visible}}<span class="label label-success">Oui</span>{{/visible}}{{^visible}}<span class="label label-error">Non</span>{{/visible}}</td><td style="text-align:center">{{#vendu}}<span class="label label-success">Oui</span>{{/vendu}}{{^vendu}}<span class="label label-error">Non{{/vendu}}</span></td></tr>';

        for( var i in data ){
        	
        	if( data[i].visible != '1' ){
        		data[i].visible = null;
        	}

        	if( data[i].vendu != '1' ){
        		data[i].vendu = null;
        	}

        	$('#tableauBiens').append( Mustache.render(tplHistorique, data[i]) );
        }
;
    },'json'); {/literal}
})(jQuery);

(function($){
$.get(
    '{$Helper->getLinkAdm("agence/getProspects/{$Agence->id}")}', {literal}
    {nohtml:'nohtml'},
    function(data){ 
        var tplHistorique = '<tr><td><a href="javascript:goToProspect({{id}});">{{nom}} {{prenom}}</a></td><td style="text-align:center">{{#acheteur}}<span class="label label-success">Oui</span>{{/acheteur}}{{^acheteur}}<span class="label label-error">Non</span>{{/acheteur}}</td><td style="text-align:center">{{#vendeur}}<span class="label label-success">Oui</span>{{/vendeur}}{{^vendeur}}<span class="label label-error">Non{{/vendeur}}</span></td><td>{{telephone}}</td></tr>';

        for( var i in data ){
        	
        	if( data[i].acheteur != '1' ){
        		data[i].acheteur = null;
        	}

        	if( data[i].vendeur != '1' ){
        		data[i].vendeur = null;
        	}

        	$('#tableauProspects').append( Mustache.render(tplHistorique, data[i]) );
        }
;
    },'json'); {/literal}
})(jQuery);

(function($){
$.get(
    '{$Helper->getLinkAdm("agence/getUtilisateurs/{$Agence->id}")}', {literal}
    {nohtml:'nohtml'},
    function(data){ 
        var tplHistorique = '<tr><td>{{prenom}} {{nom}}</td><td>{{identifiant}}</td><td>{{email}}</td></tr>';

        for( var i in data ){
        	
        	if( data[i].acheteur != '1' ){
        		data[i].acheteur = null;
        	}

        	if( data[i].vendeur != '1' ){
        		data[i].vendeur = null;
        	}

        	$('#tableauUtilisateurs').append( Mustache.render(tplHistorique, data[i]) );
        }
;
    },'json'); {/literal}
})(jQuery);

function goToAnnonce(bien_id){
	window.location.href = '{$Helper->getLinkAdm("bien/fiche/'+ bien_id +'")}';
}

function goToProspect(prospect_id){
	window.location.href = '{$Helper->getLinkAdm("prospect/fiche/'+ prospect_id +'")}';
}
</script>

<!-- 
END ADM/AGENCE/DETAIL
-->