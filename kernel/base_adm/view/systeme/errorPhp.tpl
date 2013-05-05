{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('systeme')}" title="Système">Système</a><span class="divider">/</span></li>
	<li>Error Php</li>
</ul>

<div class="well">
	<h4>Error PHP</h4>
	<dl class="dl-horizontal">
		<dt>Fichier :</dt>
		<dd>
			<select id="fichier" onchange="showFileError();">
                <option></option>
                {foreach $Files as $k => $v}
                <option value="{$v}">{$v}</option>
                {/foreach}
            </select>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button onclick="clearLog();" class="btn">Supprimer les logs</button>
		</dd>
	</dl>
	<div id="errors"></div>
</div>
{/strip}
<script>
function showFileError(){
    var fichier;
    
    fichier = $("#fichier").val();
    if( fichier == ''){
        $("#errors").html('');
    }else{
        $.get(
        '{$Helper->getLinkAdm("systeme/getErrorPhp/'+fichier+'")}',{literal}
        {nohtml:'nohtml'},
        function(data){ $('#errors').html(data); }
    )
    {/literal}
    }
}

function clearLog(){
	$.get(
        '{$Helper->getLinkAdm("systeme/clearLogPhp")}',{literal}
        {nohtml:'nohtml'},
        function(data){ 
        	console.log(data);
        	$('#errors').html('<div class="alert alert-info">Logs supprimés !</div>'); 
        }
    )
    {/literal}
}
</script>