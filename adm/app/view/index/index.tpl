
<div id="ListeVisite"><i class="icon-spinner icon-spin"></i></div>
<div id="ListeContactBien"><i class="icon-spinner icon-spin"></i></div>
<div id="ListeContactAgence"><i class="icon-spinner icon-spin"></i></div>
<div id="ListeStats"></div>
<div class="well">
	<div id="Calendrier" style="width:80%;"></div>
</div>

<script type="text/javascript">
<!--
$.get(
	'{getLinkAdm("index/ajaxGetNotReadContactAnnonce")}', {literal}
	{nohtml:'nohtml'},{/literal}   
	function(data){ $("#ListeContactBien").html(data) }
);

$.get(
	'{getLinkAdm("index/ajaxGetNotReadContactAgence")}', {literal}
	{nohtml:'nohtml'},{/literal}   
	function(data){ $("#ListeContactAgence").html(data) }
);

$.get(
	'{getLinkAdm("index/ajaxGetVisite")}', {literal}
	{nohtml:'nohtml'},{/literal}   
	function(data){ $("#ListeVisite").html(data) }
);

$.get(
	'{getLinkAdm("index/ajaxStats")}', {literal}
	{nohtml:'nohtml'},{/literal}   
	function(data){ $("#ListeStats").html(data) }
);

$.getJSON(
	'{$Helper->getLinkAdm("visite/getForFullCalendar")}', {literal}
	{nohtml:'nohtml'},{/literal}   
	function(data){ 
		
		$(document).ready(function() {
	
			$('#Calendrier').fullCalendar({
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,basicWeek,basicDay'
				},
				firstDay:1,
				editable: false,
				events:data,		
			});	
		}); 		
	}
);

$.getJSON(
    '{$Helper->getLinkAdm("graph/repartBienCat")}', {literal}
    {nohtml:'nohtml'},{/literal}   
    function(data){     
        $.plot($("#BienCatGraph"), data,{
            series: {
                pie: {
                        show: true
                }
            },
            grid: {
                hoverable: true,
                clickable: true
            },      
            legend: {
                show: false
            }
        }); 
        
    }
);

$.getJSON(
    '{$Helper->getLinkAdm("graph/bienVisible")}', {literal}
    {nohtml:'nohtml'},{/literal}   
    function(data){     
        $.plot($("#BienVisible"), data,{
            series: {
                pie: {
                        show: true
                }
            },
            grid: {
                hoverable: true,
                clickable: true
            },      
            legend: {
                show: false
            }
        }); 
        
    }
);
//-->
</script>