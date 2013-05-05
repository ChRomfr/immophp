<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>Gestionnaire de fichier<li>
</ul>
<br/>
<script type="text/javascript" charset="utf-8">
	$().ready(function() {
		var elf = $('#elfinder').elfinder({
			// lang: 'ru',             // language (OPTIONAL)
			url : '{$Helper->getLinkAdm("filemanager/connector")}'  // connector URL (REQUIRED)
		}).elfinder('instance');			
	});
</script>

<!-- Element where elFinder will be created (REQUIRED) -->
<div id="elfinder"></div>