<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('menu/index')}" title="{$lang.Menu}">{$lang.Menu}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>


<form id="formMenu" action="#" method="post" class="form-horizontal well">
	<fieldset>
    	<legend>{$lang.Nouveau_menu}</legend>
		<div class="control-group">
			<label class="control-label" for="name">{$lang.Nom} :</label>
			<div class="controls"><input type="text" name="menu[name]" id="name" required /></div>
		</div>
		<div class="form-actions">
			<input type="submit" value="{$lang.Enregistrer}" class="btn btn-primary" />
		</div>
	</fieldset>
</form>

<script>
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#formMenu").validationEngine();
});
</script>