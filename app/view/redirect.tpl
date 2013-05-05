<script type="text/javascript">
<!--
function redirect() {
    window.location='{$url}';
}
setTimeout('redirect()','{$temp}');
-->
</script>
{strip}
<br/>
<br/>
<span id="errorh"></span>
<div id="error_msg">
	<br/>
	<br/>
	<div class="{$error_class}" style="width:500px;margin:auto;padding:15px;">
		<br/>
		<img src="{$config.url}{$config.url_dir}web/images/{$error_image}.png" alt="" style="float:left;padding-right:6px;" />
		<span style="font-size:17px; font-weight:bold;">{$message}</span>		
		<br/>
		<br/>
	</div>	
	<br/>
	<br/>
</div>
<br/>
<div style="text-align:center;">Vous allez etre redirige dans <strong>{$temp/1000}</strong> secondes ...</div>
{/strip}

