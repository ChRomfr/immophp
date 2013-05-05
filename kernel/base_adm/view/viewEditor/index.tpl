<!-- adm/app/view/viewEditor/index.tpl

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
	<li>Edition vue</li>
</ul>

<div class="well">

	<h4>Vue personnalisee</h4>

	<table class="table table-bordered table-striped table-condensed">
		<thead>
			<tr>
				<th>Vue</th>
				<th>Active</th>
				<th>Creer le</th>
				<th>Modifier le </th>
				<th>Voir</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $Views as $Row}
			<tr>
				<td>{$Row.name}</td>
				<td style="text-align:center">
                        <img src="{$config.url}{$config.url_dir}web/images/{if $Row.active == 1}okSmall.png{elseif $Row.active == 0}noSmall.png{/if}" alt="" />
                    </td>
				<td>{$Row.creat_on|date_format:$config.format_date}</td>
				<td>{$Row.edit_on|date_format:$config.format_date}</td>
				<td><a href="{$Helper->getLink("{$Row.call_url}?preview_template&token={$Row.token}&template={$Row.real_dir}")}" title="" target="_blank" class="btn">Previsualisation</a></td>
				<td>
					<a href="{$Helper->getLinkAdm("viewEditor/edit/{$Row.id}")}" title=""><i class="icon-pencil"></i></a>
					<a href="javascript:deleteVue({$Row.id})" title=""><i class="icon-trash"></i></a>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>

	<!-- Formulaire pour ajouter -->
	<form method="get" action="{$Helper->getLinkAdm("viewEditor/add")}" class="form-inline">		
		<label>Vue : </label>
		<select name="vue_id">
			<option></option>
			{foreach $Dispo as $Row}
			<option value="{$Row.id}">{$Row.nom}</option>
			{/foreach}
		</select>
		<button type="submit" class="btn">Personnaliser</button>	
	</form>
</div>
{/strip}
<script>
function deleteVue(vue_id){
	if( confirm('Etes vous sur de vouloir supprimer cette vue ?') ){
		window.location.href = '{$Helper->getLinkAdm("viewEditor/delete/'+ vue_id +'")}';
	}
}
</script>