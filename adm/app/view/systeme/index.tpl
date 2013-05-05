{strip}
<ul class="breadcrumb">
	<li><a href="{getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Systeme}</li>
</ul>

<div class="well">
	<legend>{$lang.Cache}</legend>
	<table>
		<tr>
			<td><a href="javascript:clearCache();" class="btn btn-primary">{$lang.Supprimer}</a></td>
		</tr>
	</table>
	<div id="resultClearCache"></div>
</div>

<hr/>

<div class="well">
	<h4>{$lang.Visiteurs_en_ligne}</h4>
    <hr/>
	<table class="table table-condensed table-striped">
	{foreach $uonline as $u}
	<tr>
		<td>{$u.identifiant}</td>
        <td>{$u.user_id}</td>
        <td>{$u.ip}</td>
	</tr>
	{/foreach}
	</table>
</table>
{/strip}
<script type="text/javascript">
<!--
function clearCache(){
    $.get(
        '{getLinkAdm("systeme/deleteCache")}', {literal}
        {nohtml:'nohtml'},
        function(data){ $('#resultClearCache').html(data); }
    );
}{/literal}
//-->
</script>