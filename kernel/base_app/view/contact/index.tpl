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
//-->
{strip}

{if !isset($config.bread) || $config.bread }
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink('index/index')}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li>{$lang.Contact}</li>
</ul>
{/if}

<div class="well">
	<form id="contactForm" method="post" class="form-horizontal">

		<h4>{$lang.Contact}</h4>

		<div class="control-group">
			<label class="control-label" fir="name">{$lang.Nom_prenom} :</label>
			<div class="controls"><input type="text" name="contact[name]" id="name" required/></div>
		</div>

		<div class="control-group">
			<label class="control-label" for="email">{$lang.Email} :</label>
			<div class="controls"><input type="email" name="contact[email]"  id="email" size="50" required/></div>
		</div>

		<div class="control-group">
			<label class="control-label">{$lang.Message} :</label>
			<div class="controls"><textarea name="contact[message]" id="message" cols="50" rows="4" required class="input-xxlarge"></textarea></div>
		</div>

		<div class="control-group">
			<label class="control-label"><img src="{$config.url}{$config.url_dir}web/images/captcha.php" /></label>
			<div class="controls"><input type="text" name="captcha_code" id="captcha_code" value="" required/></div>
		</div>

		<div class="form-actions">
			<button type="submit" class="btn btn-primary">{$lang.Envoyer}</button>
		</div>
	</form>
</div>
{/strip}
<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	$("#contactForm").validate({
		rules:{
			"contact[name]":{
				required:true,
			},
			"contact[email]":{
				required:true,
				email:true,
			},
			"contact[message]":{
				required:true,
				minlength:15,
			},
		},
		messages:{
			"contact[name]":{
				required:"Veuillez indiquer votre nom et prenom",
			},
			"contact[email]":{
				required:"Veuillez indiquer votre adresse email",
				email:"Adresse email invalide",
			},
			"contact[message]":{
				required:"Veuillez indiquer votre message",
				minlength:"Votre message est trop court !",
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
//-->
</script>