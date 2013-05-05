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

{if !isset($config.bread) || $config.bread }
<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("news")}" title="{$config.news_nom}">{$config.news_nom}</a><span class="divider">/</span></li>
	<li>{$new.sujet}</li>
</ul>
{/if}

<div class="well">

	<h3>{$new.sujet}</h3>

	<div>{$new.contenu}</div>

	<hr/>

	<div>

		<div class="fleft">
			<i class="icon-user"></i>&nbsp;:&nbsp;{$new.identifiant}&nbsp;&nbsp;<i class="icon-calendar"></i>&nbsp;{$new.post_on|date_format:$config.format_date}
		</div>

		<div class="fright">
			{if $new.source != '' && $new.source_link != ''}{$lang.Source} : <a href="{$new.source_link}" target="_blank">{$new.source}</a> - {/if}
			{if !empty($new.categorie)}<i class="icon-tag"></i>&nbsp;{$new.categorie}{/if}
		</div>

		<div class="clear"></div>
	</div>

</div><!-- /well -->

<div class="clear"></div>

<hr/>

{if $config.news_commentaire == 1}

	<table class="table table-striped table-condensed" id="tableauCommentaires">
		<thead>
			<th>Membre</th>
			<th>Discution</th>
		</thead>
		<tbody>
			<tr>
				<td></td>
				{if $new.commentaire == 1 && $smarty.const.ADM_NEWS_LEVEL < $smarty.session.utilisateur.isAdmin}
				<td class="right"><a href="javascript:lockCommentaire({$new.id})" class="btn">Lock</a></td>
				{elseif $new.commentaire == 0 && $smarty.const.ADM_NEWS_LEVEL < $smarty.session.utilisateur.isAdmin}
				<td class="right"><a href="javascript:unlockCommentaire({$new.id})" class="btn">Unlock</a></td>
				{/if}
			</tr>
		</tbody>
	</table>

	<!-- Formulaire nouveau commentaire -->
	{if $smarty.session.utilisateur.id != 'Visiteur' && $new.commentaire == 1}
	<form method="post" action="{$Helper->getLink("commentaire/post")}" class="form-horizontal well">
			<div class="control-group">
				<label class="control-label" for="commentaire">{$lang.Commentaire} :</label>
				<div class="controls"><textarea name="com[commentaire]" id="commentaire" cols="50" rows="5" class="input-xxlarge"></textarea></div>
			</div>
			<div>
				<input type="hidden" name="com[auteur_id]" value="{$smarty.session.utilisateur.id}" />
				<input type="hidden" name="com[model_id]" value="{$new.id}" />
				<input type="hidden" name="token" value="{$smarty.session.token}" />
				<input type="hidden" name="com_model" value="news" />
				<button type="submit" name="send" class="btn"><i class="icon-comment"></i>{$lang.Envoyer}</button>
			</div>
	</form>
	{/if}
{else}
	{if $smarty.const.ADM_NEWS_LEVEL < $smarty.session.utilisateur.isAdmin}
	<div class="alert alert-block">
  		<h4>Warning!</h4>
  		Les commentaires pour les news ont ete desactives
		</div>
	{/if}
{/if}
{/strip}
<script>
<!--
(function($){
$.get(
    '{$Helper->getLink("news/getCommentaires/{$new.id}")}', {literal}
    {nohtml:'nohtml'},
    function(data){ 
        var tplCommentaire = '<tr><td>{{identifiant}}<br/><small>{{date_commentaire}}</small></td><td><p>{{commentaire}}</p>{{#administrateur}}<div class="fright"><a href="javascript:deleteCommentaire({{id}});" title=""><i class="icon-trash"></i></a></div><div class="clear"></div>{{/administrateur}}</td></tr>';

        for( var i in data ){      	
        	$('#tableauCommentaires').prepend( Mustache.render(tplCommentaire, data[i]) );
        }
	;
    },'json'); {/literal}
})(jQuery);

function deleteCommentaire(id){
	if( confirm('{$lang.Confirm_suppression_commentaire} ?') ){
		window.location.href='{$Helper->getLink("commentaire/delete/'+ id +'?com_model=news")}';
	}
}
{if isset($smarty.session.utilisateur.isAdmin) && $smarty.const.ADM_NEWS_LEVEL < $smarty.session.utilisateur.isAdmin}
function lockCommentaire(id){
	if( confirm('{$lang.Confirm_lock_commentaire} ?') ){
		window.location.href='{$Helper->getLink("news/lockCommentaire/")}' + id;
	}
}

function unlockCommentaire(id){
	if( confirm('{$lang.Confirm_unlock_commentaire} ?') ){
		window.location.href='{$Helper->getLink("news/unlockCommentaire/")}' + id;
	}
}
{/if}
//-->
</script>