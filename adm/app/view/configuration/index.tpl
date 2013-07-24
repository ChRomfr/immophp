<!--

                                     _,,                                   ,dW 
                                   ,iSMP                                  JIl; 
                                  sPT1Y'                                 JWS:' 
                                 sIl:l1                                 fWIl?  
                                dIi:Il;                                fW1"    
                               dIi:l:I'                               fWI:     
                              dIli:l:I;                              fWI:      
                            .dIli:I:S:S                     .       fWIl`      
                          ,sWSSIIIiISIIS w,_             .sMW     ,MWIl;       
                     _.,sWWW*"'*" , SWW' MWWMm mu,,._  .iSYISb, ,MM*SI!:       
                 _,s YMMWW'',sd,'MM WMMi "*MW* WWWMWMb MMS WWP`,MW' S1!`       
            _,os,'MMi YW' m,'WW; WWb`SWM Im,,  SIS ISW SISIP*  WSi  II!.       
         .osSMWMW,'WSi ',MMP SSb WSW ISII`SYYi III !Il lIi,ui:,*1:li:l1!       
      ,sSMMWWWSSSS,'SWbdWW*  *YSbiSS:'IlI 7llI il1: l! 'l:+'+l; `''+1i:1i      
   ,sYSMWMWY**"""'` 'WWSSIIiu,'**Y11';IIIb ?!li ?l:i,         `      `'l!:     
  sPITMWMW'`.M.wdWWb,'YIi `YT" ,u!1",ISIWWm,'+?+ `'+Ili                `'l:,   
  YIi1lTYfPSkyLinedI!i`I!" .,:!1"',iSWWMMMMMmm,                                
    "T1l1lI**"'`.2006? ',o?*'``  ```""**YSWMMMWMm,                             
         "*:iil1I!I!"` '                 ``"*YMMWWM,                           
               ii!                             '*YMWM,                         
               I'                                  "YM                         
                                                                               
-->
{strip}

<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Preferences}</li>
</ul>

<form method="post" id="formConfig" class="form-horizontal well" enctype="multipart/form-data">
	<fieldset>
		<legend>{$lang.Generale}</legend>		
		<div class="control-group">
			<label class="control-label" for="titre_site">{$lang.Titre_du_site} :</label>
			<div class="controls"><input type="text" name="config[titre_site]" class="validate[required]" id="titre_site" size="60" value="{$config.titre_site}"/></div>
		</div>
        <div class="control-group">
			<label class="control-label" for="titre_site">{$lang.Slogan_du_site} :</label>
			<div class="controls"><input type="text" name="config[slogan_site]" class="validate[required]" id="titre_site" size="60" value="{$config.slogan_site}"/></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="keywords">{$lang.Mot_cle} :</label>
			<div class="controls"><input type="text" name="config[keywords]" class="validate[required]" id="keywords" size="60" value="{$config.keywords}"/></div>
		</div>
		<div class="control-group">
			<label class="control-label" for="description_site">{$lang.Description_du_site} :</label>
			<div class="controls"><textarea name="config[description_site]" id="description_site" rows="3" cols="50">{$config.description_site}</textarea></div>
		</div>
        <!--
		<div class="control-group">
			<label class="control-label" for="footer_site">{$lang.Texte_pied_du_site} :</label>
			<div class="controls"><textarea name="config[footer_site]" id="footer_site" rows="3" cols="50">{$config.footer_site}</textarea></div>
		</div>
        -->
		<div class="control-group">
			<label class="control-label" for="titre_site">{$lang.Email} :</label>
			<div class="controls"><input type="email" name="config[email]" class="validate[required]" id="email" size="60" value="{$config.email}"/></div>
		</div>

		<!-- Logo -->
		<div class="control-group">
			<label class="control-label">Logo :</label>
			<div class="controls">
				<select name="config[logo]" onchange="showLogo();" id="logo_selected">
					<option></option>
					{foreach $Logos as $k => $v}
					<option value="{$v}">{$v}</option>
					{/foreach}
				</select>
				<span id="preview_logo"></span>
				<br/>
				<input type="file" name="logo" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="theme">{$lang.Themes} :</label>
			<div class="controls">
				<select name="config[theme]" class="validate[required]" id="theme" onchange="showDesign();">
					{foreach $themes as $k => $v}
					<option value="{$v}" {if $v == $config.theme}selected="selected"{/if}>{$v}</option>
					{/foreach}
				</select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">{$lang.Methode_envoie_email} :</label>
			<div class="controls">
				<select name="config[mail_method]">
					<option value="mail" {if $config.mail_method == 'mail'}selected="selected"{/if}>Mail()</option>
					<option value="smtp" {if $config.mail_method == 'smtp'}selected="selected"{/if}>SMTP</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">SMTP Server :
			<div class="controls"><input type="text" name="config[smtp_server]" value="{$config.smtp_server}" /></div>
		</div>
		<div class="control-group">
			<label class="control-label">SMTP Port :
			<div class="controls"><input type="text" name="config[smtp_port]" value="{$config.smtp_port}" /></div>
		</div>
		<div class="control-group">
			<label class="control-label">SMTP User :
			<div class="controls"><input type="text" name="config[smtp_login]" value="{$config.smtp_login}" /></div>
		</div>
		<div class="control-group">
			<label class="control-label">SMTP Password :
			<div class="controls"><input type="text" name="config[smtp_password]" value="{$config.smtp_password}" /></div>
		</div>
	</fieldset>
	
	<!-- Accueil -->
	<fieldset>
		<legend>{$lang.Accueil_du_site}</legend>
        <!--
		<div class="control-group">
			<label class="control-label" for="last_news_in_index">{$lang.Afficher_les_dernieres_news} :</label>
			<div class="controls">
				<select name="config[last_news_in_index]" id="last_news_in_index" onchange="showContenuAccueil();">
					<option value="0" {if $config.last_news_in_index == 0}selected="selected"{/if}>{$lang.Non}</option>
					<option value="1" {if $config.last_news_in_index == 1}selected="selected"{/if}>{$lang.Oui}</option>
				</select>
			</div>
		</div>
	<div id="champ_news_in_index">
		<div class="control-group">
			<label class="control-label" for="news_in_index">{$lang.News_sur_index} :</label>
			<div class="controls"><input type="text" name="config[news_in_index]" id="news_in_index" value="{$config.news_in_index}" size="2"/></div>
		</div>
	</div>
    //-->

    	<div class="control-group">
        	<label class="control-label">Afficher la carte des agences :</label>
        	<div class="controls">
        		<select name="config[index_carte_agence]">
        			<option value="1" {if $config.index_carte_agence == 1}selected="selected"{/if}>{$lang.Oui}</option>
        			<option value="0" {if $config.index_carte_agence == 0}selected="selected"{/if}>{$lang.Non}</option>
        		</select>
        	</div>
        </div>

        <div class="control-group">
            <label class="control-label" for="index_contenu">{$lang.Contenu_page_accueil} :</label>
            <div class="controls">
            	<textarea name="config[index_contenu]" id="index_contenu" class="input-xxlarge" rows="6">{$config.index_contenu}</textarea>
            	<span class="help-block">Contenu a droite de la carte.</span>
           	</div>
        </div>

        <div class="control-group">
        	<label class="control-label">Dernieres annonces :</label>
        	<div class="controls">
        		<select name="config[index_last_annonce]">
        			<option value="1" {if $config.index_last_annonce == 1}selected="selected"{/if}>{$lang.Oui}</option>
        			<option value="0" {if $config.index_last_annonce == 0}selected="selected"{/if}>{$lang.Non}</option>
        		</select>
        	</div>
        </div>

        <!-- Page personnalisé -->
       	<div class="control-group">
       		<label class="control-label">Page :</label>
       		<div class="controls">
       			<select name="config[index_page]">
       				<option></option>
       				{foreach $Pages as $Row}
       				<option value="{$Row.id}" {if $config.index_page == $Row.id}selected="selected"{/if}>{$Row.titre}</option>
       				{/foreach}
       			</select>
       		</div>
       	</div>

	</fieldset>

	<!-- PARAMETRE ANNONCE -->
	<fieldset>
		<legend>Bien</legend>

		<div class="control-group">
			<label class="control-label" for="bien_seuil_visite_hebdomadaire">Seuil mini visite hebdomadaire :</label>
			<div class="controls"><input type="text" name="config[bien_seuil_visite_hebdomadaire]" value="{$config.bien_seuil_visite_hebdomadaire}" /></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="bien_seuil_visite_mensuel">Seuil mini visite mensuel :</label>
			<div class="controls"><input type="text" name="config[bien_seuil_visite_mensuel]" value="{$config.bien_seuil_visite_mensuel}" /></div>
		</div>

	</fieldset>
	
	{* NEWS *}
    <!--
	<div class="showData">
		<h1><a name="news">{$lang.News}</a></h1>
		<div class="control-group">
			<label class="control-label" for="news_per_page">{$lang.News_par_page} :</label>
			<div class="controls"><input type="text" name="config[news_per_page]" id="news_per_page" value="{$config.news_per_page}" size="2" /></div>
		</div>
	</div>
	-->
	{* UTILISATEUR *}
	<fielset>
		<legend>{$lang.Utilisateurs}</legend>	
		<div class="control-group">
			<label class="control-label" for="registrer">{$lang.Activation_des_comptes} :</label>
			<div class="controls">
				<select name="config[user_activation]">
					<option value="auto" {if $config.user_activation == 'auto'}selected="selected"{/if}>Auto</option>
					<option value="mail" {if $config.user_activation == 'mail'}selected="selected"{/if}>E-mail</option>
				</select>
			</div>
		</div>
	</fieldset>
	
	{* TELECHARGEMENT *}
    <!--
	<div class="showData">
		<h1>{$lang.Telechargement}</h1>
		<div class="control-group">
			<label class="control-label">{$lang.Visible_par} :</label>
			<div class="controls">
				<select name="config[download_view_by]">
					<option value="member" {if $config.download_view_by == 'member'}selected="selected"{/if}>{$lang.Utilisateur_enregistre}</option>
					<option value="all" {if $config.download_view_by == 'all'}selected="selected"{/if}>{$lang.Tout_le_monde}</option>
				</select>
			</div>
		</div>
	</div>
	-->
    <!-- FOOTER LINK -->
    <fieldset>
        <legend>{$lang.Texte_pied_du_site}</legend>
        <div class="control-group">
            <label class="control-label" for="">{$lang.Texte}</label>
            <div class="controls"><textarea name="config[footer_link]" class="input-xxlarge" rows="6">{$config.footer_link}</textarea></div>
        </div>
    </fieldset>
                
	<!-- CODE STATS -->
	<fieldset>
		<legend>{$lang.Statistique_du_site}</legend>
		<div class="control-group">
			<label class="control-label" for="code_stat">{$lang.Code} :</label>
			<div class="controls"><textarea name="config[code_stat]" class="input-xxlarge" rows="6" id="code_stat">{$config.code_stat}</textarea></div>
		</div>
	</fieldset>

	<!-- CODE SOCIAL PLUGIN -->
	<fieldset>
		<legend>Social</legend>
		<div class="control-group">
			<label class="control-label" for="social_plugin_code">{$lang.Code} :</label>
			<div class="controls"><textarea name="config[social_plugin_code]" id="social_plugin_code" class="input-xxlarge" rows="6">{$config.social_plugin_code}</textarea></div>
		</div>
	</fieldset>

	<div class="form-actions">
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</div>
</form>


<div class="modal hide" id="modal_preview_design">
  <div class="modal-header"> <a class="close" data-dismiss="modal">×</a>
    <h4>Aperçu</h4>
  </div>
  <div class="modal-body" id="preview_design">
  </div>
</div>
{/strip}

<script type="text/javascript">
<!--
$('#champ_index_contenu').css('display','block');

jQuery(document).ready(function(){
	$('#formConfig').validate({
		rules:{
			'config[titre_site]':{
				required:true,
			},
			'config[email]':{
				required:true,
				email:true,
			},
			'config[bien_seuil_visite_hebdomadaire]':{
				number:true,
			},
			'config[bien_seuil_visite_mensuel]':{
				number:true,
			},
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

function showLogo(){
	var logo = $('#logo_selected').val();

	if( logo != '' ){
		$('#preview_logo').html('&nbsp;&nbsp:&nbsp;&nbsp;&nbsp;<img src="{$config.url}{$config.url_dir}web/upload/logo/'+ logo +'" alt="" style="width:150px"/>')
	}else{
		$('#preview_logo').html('');
	}
}

function showContenuAccueil(){
	if( $('#last_news_in_index').val() == 0 ){
		$('#champ_index_contenu').css('display','block');
		$('#champ_news_in_index').css('display','none');
	}else{
		$('#champ_index_contenu').css('display','none');
		$('#champ_news_in_index').css('display','block');
	}
}

function showDesign(){
	var theme = $('#theme').val();

	// Requete pour recupere le preview
	$.get(
        '{getLinkAdm("configuration/ajaxGetPreview/'+theme+'")}', {literal}
        {nohtml:'nohtml'},
        function(data){
        	if( data != ''){
         		$('#preview_design').html(data); 
         		$('#modal_preview_design').modal('show')
         	}else{
         		$('#preview_design').html('');
         	}
     	}
    );{/literal}
}
-->
</script>