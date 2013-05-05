{strip}
<div class="well">
    <legend>{$lang.Statistique}</legend>
    
        <table class="table table-condensed">
            <tr>
                <td>{$lang.Biens} :</td>
                <td>{$NbBien}</td>
            </tr>

            <tr>
                <td>{$lang.Visites} :</td>
                <td>{$NbVisite}</td>
            </tr>

            <tr>
                <td>{$lang.Prospects} :</td>
                <td>{$NbProspect}</td>
            </tr>

            <tr>
                <td>Bien saisie mois en cour :</td>
                <td>{$NbBienSaisieMois}</td>
            </tr>
            <tr>
                <td>Bien vendu mois en cour :</td>
                <td>{$NbBienVenduMois}</td>
            </tr>
            
            <tr>
                <td>Total des ventes mois en cour :</td>
                <td>{if !empty($TotalVente)}{number_format({$TotalVente},0,',',' ')}{/if}</td>
            </tr>

            <tr>
                <td>Frais agence mois en cour :</td>
                <td>{if !empty($TotalFraisAgence)}{number_format({$TotalFraisAgence},0,',',' ')}{/if}</td>
            </tr>

            <tr>
                <td>Commission vendeur mois en cour :</td>
                <td>{if !empty($TotalComVendeur)}{number_format({$TotalComVendeur},0,',',' ')}{/if}</td>
            </tr>
        </table>

    <hr/>
    <div class="container">
        <div class="row-fluid">
            <div class="span4">
                <h4>Repartition des biens dans les Categories</h4>
                <div id="BienCatGraph" style="height:300px;"><i class="icon-spinner icon-spin"></i></div>   
            </div><!-- /span4 -->
            <div class="span4">
                <h4>Bien visible sur le site</h4>
                <div id="BienVisible" style="height:300px;"><i class="icon-spinner icon-spin"></i></div> 
            </div><!-- /span4 -->
        </div><!-- /row-fluid -->
    </div><!-- /container -->
</div>
{/strip}