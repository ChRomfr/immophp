{strip}

<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm('blok/index')}" title="{$lang.Blok}">{$lang.Blok}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>

<form method="post" onsubmit="return checkSubmit();" id="formAddBlok" class="form-horizontal well">
	<fielset>
	<legend>{$lang.Nouveau}</legend>
	<div class="control-group">
		<label class="control-label" for="position">{$lang.Position} :</label>
		<div class="controls">
			<select name="blok[position]" id="position" required>
				<option value=""></option>
				<option value="left">{$lang.Gauche}</option>
				<option value="right">{$lang.Droite}</option>
				<option value="top">{$lang.Haut}</option>
				<option value="foot">{$lang.Bas}</option>
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="ordre">{$lang.Ordre} :</label>
		<div class="controls"><input type="text" name="blok[ordre]" id="ordre" size="2" placeholder="99" required class="input-small"/></div>
	</div>
	<div class="control-group">
		<label class="control-label" for="only_index"><strong>{$lang.Visible_seulement_accueil} :</strong></label>
		<div class="controls">
		<input type="checkbox" name="blok[only_index]" id="only_index" />
	</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="type">{$lang.Type} :</label>
		<div class="controls">
			<select name="blok[type]" required class="validate[required]" onchange="getFormType()" id="type">
				<option></option>
				<option value="HTML">HTML</option>
				<option value="MENU">{$lang.Menu}</option>
				<option value="RSS">Flux RSS</option>
				{if !empty($Bloks)}
				<option value="">----------</option>
				{foreach $Bloks as $Row}
				<option value="{$Row.id}">{$Row.name}</option>
				{/foreach}
				{/if}
			</select>
		</div>
	</div>
	
<div id="formhtml" style="display:none;">
	<div class="control-group">
		<label class="control-label" for="name">{$lang.Nom} :</label>
		<div class="controls"><input type="text" name="blok[name]" id="name" size="50" /></div>
	</div>
	<div class="control-group">
		<label class="control-label" for="bcontenu">{$lang.Contenu} :</label>
		<div class="controls"><textarea name="contenu_html" id="bcontenu" rows="5" class="input-xxlarge"></textarea></div>
	</div>
</div>

<div id="formmenu" style="display:none;">
	<div class="control-group">
		<label class="control-label">{$lang.Menu}</label>
		<div class="controls">
			<select name="blok[contenu]" id="menu_id">
				<option></option>
				{foreach $Menus as $Menu}
				<option value="{$Menu.id}">{$Menu.name}</option>
				{/foreach}
			</select>
		</div>
	</div>
</div>

<div id="formrss" style="display:none;">
	<div class="control-group">
		<label class="control-label" for="name">{$lang.Nom} Blok :</label>
		<div class="controls"><input type="text" name="blok[name_flux]" id="name_flux" size="50" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{$lang.Nom} Flux :</label>
		<div class="controls"><input type="text" name="blok[nameflux1]" id="nameflux1" size="50" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">Flux :</label>
		<div class="controls"><input type="url" name="blok[flux1]" id="flux1" size="50" /></div>
	</div>
	<div id="formflux2" style="display:none;">
	<div class="control-group">
		<label class="control-label">{$lang.Nom} Flux 2 :</label>
		<div class="controls"><input type="text" name="blok[nameflux2]" id="nameflux2" size="50" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">Flux 2 :</label>
		<div class="controls"><input type="url" name="blok[flux2]" id="flux2" size="50" /></div>
	</div>
	</div>
	<div class="control-group">
		<label class="control-label">{$lang.Nombre_lien_affiche} :</label>
		<div class="controls"><input type="text" size="1" name="blok[nb_links]" placeholder="5" /></div>
	</div>
</div>

<div class="form-actions">
	<input type="hidden" name="token" value="{$smarty.session.token}" />
	<input type="hidden" name="blok[visible]" value="1" />
	<input type="submit" name="send" value="{$lang.Enregistrer}" class="btn btn-primary"/>
</div>
</fielset>
</form>
{/strip}
<script type="text/javascript">
<!--
$(document).ready(function(){
    $("#formAddBlok").validate({
        rules:{
            'blok[position]':"required",
            'blok[ordre]':{
            	required:true,
            	number:true
            },
            'blok[type]':{
            	required:true,
            }
        },
        messages:{
            'blok[position]':"Veuillez selectionner une position",
            'blok[ordre]':'Veuillez selection l ordre d affichage du blok',
            'blok[type]':"Selectionner le type de blok a ajouté"
        },

        highlight:function(element)
        {
            $(element).parents('.control-group').removeClass('success');
            $(element).parents('.control-group').addClass('error');
        },
        unhighlight: function(element)
        {
            $(element).parents('.control-group').removeClass('error');
            $(element).parents('.control-group').addClass('success');
        }
    });
});


function getFormType(){
	
	if( $('#type').val() == 'HTML' ){
		$('#formhtml').css('display','block');
		$('#formmenu').css('display','none');
		$('#formrss').css('display','none');
	}else if( $('#type').val() == 'MENU'){
		$('#formmenu').css('display','block');
		$('#formhtml').css('display','none');
		$('#formrss').css('display','none');
	}else if( $('#type').val() == 'RSS'){
		$('#formmenu').css('display','none');
		$('#formhtml').css('display','none');
		$('#formrss').css('display','block');
		
		if( $('#position').val() == "" ){
			alert("{$lang.Selectionner_position_du_blok}");
			$('#formrss').css('display','none');
			$('#type').val('');
		}
		
		if( $('#position').val() == 'top' || $('#position').val() == 'foot'){
			$('#formflux2').css('display','block');
		}else{
			$('#formflux2').css('display','none');
		}
		
	}else{
		$('#formmenu').css('display','none');
		$('#formhtml').css('display','none');
		$('#formrss').css('display','none');
	}
}

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
	}else if( $('#type').val() == 'MENU' ){
		if($('#menu_id').val()==""){
			return false;
		}
	}else if( $('#type').val() == 'RSS' ){
		if( $('#flux1').val() == ''){
			$('#flux1').css('border-color','red');
			return false;
		}
	}
	
	return true;
}
//-->
</script>