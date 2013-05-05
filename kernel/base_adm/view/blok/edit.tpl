{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('blok/index')}" title="{$lang.Blok}">{$lang.Blok}</a><span class="divider">/</span></li>
	<li>{$lang.Edition}</li>
</ul>

<form method="post" onsubmit="return checkSubmit();" class="form-horizontal well">
	<fieldset>
	<legend>{$lang.Edition}</legend>
	<div class="control-group">
		<label class="control-label" for="position">{$lang.Position} :</label>
		<div class="controls">
			<select name="blok[position]">
				<option value=""></option>
				<option value="left" {if $blok.position == 'left'}selected="selected"{/if}>{$lang.Gauche}</option>
				<option value="right" {if $blok.position == 'right'}selected="selected"{/if}>{$lang.Droite}</option>
				<option value="top" {if $blok.position == 'top'}selected="selected"{/if}>{$lang.Haut}</option>
				<option value="foot" {if $blok.position == 'foot'}selected="selected"{/if}>{$lang.Bas}</option>
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="ordre">{$lang.Ordre} :</label>
		<div class="controls"><input type="text" name="blok[ordre]" id="ordre" size="2" value="{$blok.ordre}" placeholder="99"/></div>
	</div>
	<div class="control-group">
		<label class="control-label" for="only_index"><strong>{$lang.Visible_seulement_accueil} :</strong></label>
		<div class="controls">
			<input type="checkbox" name="blok[only_index]" id="only_index" {if $blok.only_index == 1}checked="checked"{/if} />
		</div>
	</div>
{if $blok.type == 'HTML'}
<div id="formhtml">
	<div class="control-group">
		<label class="control-label" for="name">{$lang.Nom} :</label>
		<div class="controls"><input type="text" name="blok[name]" id="name" size="50" value="{$blok.name}" /></div>
	</div>
	<div class="control-group">
		<label class="control-label" for="bcontenu">{$lang.Contenu} :</label>
		<div class="controls"><textarea name="blok[contenu]" id="bcontenu" rows="5" class="input-xxlarge">{$blok.contenu}</textarea></div>
	</div>
</div>
{/if}

{if $blok.type == 'MENU'}
<div id="formmenu" style="display:block;">
	<div class="control-group">
		<label class="control-label">{$lang.Menu}</label>
		<div class="controls">
			<select name="blok[contenu]" id="menu_id" required>
				<option></option>
				{foreach $Menus as $Menu}
				<option value="{$Menu.id}" {if $blok.contenu == $Menu.id}selected="selected"{/if}>{$Menu.name}</option>
				{/foreach}
			</select>
		</div>
	</div>
</div>
{/if}

{* BLOK TYPE RSS *}
{if $blok.type == 'RSS'}
<div id="formrss" style="display:block;">
	<div class="control-group">
		<label class="control-label" for="name">{$lang.Nom} :</label>
		<div class="controls"><input type="text" name="blok[name_flux]" id="name_flux" size="50" value="{$blok.name}"/></div>
	</div>
	<div class="control-group">
		<label class="control-label">{$lang.Nom} Flux :</label>
		<div class="controls"><input type="text" name="blok[nameflux1]" id="nameflux1" size="50" value="{$blok.contenu.nameflux1}" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">Flux :</label>
		<div class="controls"><input type="text" name="blok[flux1]" id="flux1" size="50" value="{$blok.contenu.flux1}" /></div>
	</div>
	{if $blok.position == 'top' OR $blok.position == 'foot'}
	<div class="control-group">
		<label class="control-label">{$lang.Nom} Flux 2 :</label>
		<div class="controls"><input type="text" name="blok[nameflux2]" id="nameflux2" size="50" value="{$blok.contenu.nameflux2}" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">Flux 2 :</label>
		<div class="controls"><input type="url" name="blok[flux2]" id="flux2" size="50" value="{$blok.contenu.flux2}" /></div>
	</div>
	{/if}
	<div class="control-group">
		<label class="control-label">{$lang.Nombre_lien_affiche} :</label>
		<div class="controls"><input type="text" size="1" name="blok[nb_links]" placeholder="5" {if !empty($blok.contenu.nb_links)}value="{$blok.contenu.nb_links}"{else}value="5"{/if} /></div>
	</div>
</div>
{/if}

<div class="control-group">
	<label class="control-label">{$lang.Visible} :</label>
	<div class="controls">
		<select name="blok[visible]" id="visible">
			<option value="1" {if $blok.visible == 1}selected="selected"{/if}>{$lang.Oui}</option>
			<option value="0" {if $blok.visible == 0}selected="selected"{/if}>{$lang.Non}</option>
		</select>
	</div>
</div>
<div class="form-actions">
	{if $blok.type != 'HTML' OR $blok.type != 'MENU' OR $blok.type != 'RSS'}
	<input type="hidden" name="blok[fichier]" value="{$blok.fichier}" />
	<input type="hidden" name="blok[call_fonction]" value="{$blok.call_fonction}" />
	<input type="hidden" name="blok[name]" value="{$blok.name}" />
	{/if}
	<input type="hidden" name="token" value="{$smarty.session.token}" />
	<input type="hidden" name="blok[id]" value="{$blok.id}" />
	<input type="hidden" name="blok[type]" value="{$blok.type}" />	
	<input type="submit" name="send" value="{$lang.Enregistrer}" class="btn btn-primary" />
	</fieldset>
</form>
{/strip}

<script>
function checkSubmit(){
	
	if( $('#position').val() == ''){
		return false;
	}
	
	if( $('#ordre').val() == ''){
		return false;
	}
	
	if( $('#type').val() == 'HTML' ){
		if( $('#name').val() == ''){
			return false;
		}
		
		if( $('#bcontenu').val() == ''){
			return false;
		}
	}
	
	return true;
}
</script>