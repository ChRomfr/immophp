{*
*	SHARKPHP VA
*	CMS FOR VIRTUAL AIRLINE
*	@author ChRom
*	@web http://va.sharkphp.com
*}

<script>
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#formMenu").validationEngine();
});
</script>

<div id="bread">
	<a href="{getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a>&nbsp;-&gt;&nbsp;
	<a href="{getLinkAdm('menu/index')}" title="{$lang.Menu}">{$lang.Menu}</a>&nbsp;-&gt;&nbsp;
	{$lang.Nouveau}
</div>


<form id="formMenu" action="#" method="post" class="form">
    <h1>{$lang.Nouveau_menu}</h1>
	<dl>
		<dt><label for="name">{$lang.Nom} :</label></dt>
		<dd><input type="text" name="menu[name]" id="name" class="validate[required]" required /></dd>
	</dl>
	<div class="center form_submit">
		<input type="submit" value="{$lang.Enregistrer}" />
	</div>
</form>