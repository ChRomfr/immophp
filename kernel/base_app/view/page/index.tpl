{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li>{$page->titre}</li>
</div>

<div class="well">
	<h4>{$page->titre}</h4>
	<hr/>
	<div class="page_contenu">{$page->contenu}</div>
</div>
{/strip}
{if $config.use_sh == 1}
<script type="text/javascript">
     SyntaxHighlighter.all()
</script>
{/if}