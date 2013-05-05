<ul class="breadcrumb">
	<li><a href="{$Helper->getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLink("article")}" title="{$lang.Article}">{$lang.Article}</a><span class="divider">/</span></li>
	{if isset($Parents)}
		{foreach $Parents as $Parent}
		<li><a href="{$Helper->getLink("article/index?cid={$Parent.id}")}">{$Parent.name}</a><span class="divider">/</span></li>
		{/foreach}
	{/if}
	
	{if !empty($Article.categorie_id)}
		<li><a href="{$Helper->getLink("article/index?cid={$Article.categorie_id}")}" title="{$Article.categorie}">{$Article.categorie}</a><span class="divider">/</span></li>
	{/if}
	<li>{$Article.title}</li>
</ul>

<div id="article_{$Article.id}" class="well">
	<h4>{$Article.title}</h4>
	<hr/>
	<div id="contenu_article">{$Article.article}</div>
	<hr/>
	{if !empty($Article.fichier)}
	<div class="fleft">
		<a href="{$config.url}{$config.url_dir}web/upload/article/{$Article.id}/{$Article.fichier}" title="Telecharger les fichiers"><i class="icon-download"></i></a>
	</div>
	{/if}
	<div class="fright">
		<div><i class="icon-user"></i>&nbsp;{$Article.utilisateur}&nbsp;&nbsp;<i class="icon-calendar"></i>{$Article.creat_on|date_format:$config.format_date_day}</div>
	</div>
	<div class="clear"></div>
</div>

<!-- COMMENTAIRES -->
{if $config.article_commentaire == 1}

	<table class="table table-striped" id="tableauCommentaires">
		<thead>
			<th>Membre</th>
			<th>Discution</th>
		</thead>
		<tbody>			
			<tr>
				<td></td>
				{if $Article.commentaire == 1 && $smarty.const.ADM_ARTICLE_LEVEL < $smarty.session.utilisateur.isAdmin}
				<td class="right"><a href="javascript:lockCommentaire({$Article.id})" class="btn">Lock</a></td>
				{elseif $Article.commentaire == 0 && $smarty.const.ADM_ARTICLE_LEVEL < $smarty.session.utilisateur.isAdmin}
				<td class="right"><a href="javascript:unlockCommentaire({$Article.id})" class="btn">Unlock</a></td>
				{/if}
			</tr>
		</tbody>
	</table>

	<!-- Formulaire nouveau commentaire -->
	{if $smarty.session.utilisateur.id != 'Visiteur' && $Article.commentaire == 1}
	<form method="post" action="{$Helper->getLink("commentaire/post")}" class="form-horizontal well">
			<div class="control-group">
				<label class="control-label" for="commentaire">{$lang.Commentaire} :</label>
				<div class="controls"><textarea name="com[commentaire]" id="commentaire" cols="50" rows="5" class="input-xxlarge"></textarea></div>
			</div>
			<div>
				<input type="hidden" name="com[auteur_id]" value="{$smarty.session.utilisateur.id}" />
				<input type="hidden" name="com[model_id]" value="{$Article.id}" />
				<input type="hidden" name="token" value="{$smarty.session.token}" />
				<input type="hidden" name="com_model" value="article" />
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

<script>
<!--
(function($){
$.get(
    '{$Helper->getLink("article/getCommentaires/{$Article.id}")}', {literal}
    {nohtml:'nohtml'},
    function(data){ 
        var tplCommentaire = '<tr><td>{{identifiant}}<br/><small>{{date_commentaire}}</small></td><td><p>{{commentaire}}</p>{{#administrateur}}<div class="fright"><a href="javascript:deleteCommentaire({{id}});" title=""><i class="icon-trash"></i></a></div><div class="clear"></div>{{/administrateur}}</td></tr>';

        for( var i in data ){      	
        	$('#tableauCommentaires').prepend( Mustache.render(tplCommentaire, data[i]) );
        }
	;
    },'json'); {/literal}
})(jQuery);

{if isset($smarty.session.utilisateur.isAdmin) && $smarty.const.ADM_ARTICLE_LEVEL < $smarty.session.utilisateur.isAdmin}
function deleteCommentaire(id){
	if( confirm('{$lang.Confirm_suppression_commentaire} ?') ){
		window.location.href='{$Helper->getLink("commentaire/delete/'+ id +'?com_model=article")}';
	}
}

function lockCommentaire(id){
	if( confirm('Etes vous sur de vouloir fermer les commentaires ?') ){
		window.location.href='{$Helper->getLink("article/lockCommentaire/")}' + id;
	}
}

function unlockCommentaire(id){
	if( confirm('Etes vous sur de vouloir ouvrir les commentaires ?') ){
		window.location.href='{$Helper->getLink("article/unlockCommentaire/")}' + id;
	}
}
{/if}
//-->
</script>
{if $config.use_sh == 1}
<script type="text/javascript">
     SyntaxHighlighter.all()
</script>
{/if}