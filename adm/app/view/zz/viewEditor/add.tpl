<!-- adm/app/view/viewEditor/add.tpl

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
	<li><a href="{$Helper->getLinkAdm("index")}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("viewEditor")}" title="Edition vue">Edition vue</a><span class="divider">/</span></li>
	<li>Ajout</li>
</ul>

<form class="well" method="post" action="{$Helper->getLinkAdm("viewEditor/add/{$Tpl->id}")}" id="formAddView">
	<fieldset>
		<legend>Nouvelle vue</legend>

		<dl>
			<dt>Vue :</dt>
			<dd>{$Tpl->nom}</dd>
		</dl>

		<dl>
			<dt>Description :</dt>
			<dd>{$Tpl->description}</dd>
		</dl>

		<div class="control-group">
			<label>Code :</label>
			<div class="controls">
				<textarea rows="30" class="input-xxlarge brush:html" id="tpl" name="tpl[tpl]">{$Tpl->code|htmlentities}</textarea>
			</div>
		</div>
		<div class="control-group">
			<label>Active :</label>
			<div class="controls">
				<select name="tpl[active]">
					<option value="0">{$lang.Non}</option>
					<option value="1">{$lang.Oui}</option>
				</select>
			</div>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-primart">{$lang.Enregistrer}</button>
		</div>
	</fieldset>
</form>
{/strip}
<script>
$('#formAddView').validate({
	rules:{
		
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
</script>