{strip}
<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm('index/index')}" title="{$lang.Administration}">{$lang.Administration}</a><span class="divider">/</span></li>
	<li>{$lang.Article}</a></li>
</ul>

<div class="well">
	
	<div class="fright">
		<a href="{$Helper->getLinkAdm("article/add")}" title=""><i class="icon-plus"></i></a>
	</div>

	<h4>{$lang.Article}</h4>

	<div class="clear"></div>

	<table class="table table-bordered table-striped">
		<thead>
			<tr>
				<td>#</td>
				<td>{$lang.Article}</td>
				<td>{$lang.Categorie}</td>
				<td>{$lang.Auteur}</td>
				<td>{$lang.Date}</td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			{foreach $Articles as $Article}
			<tr>
				<td>{$Article.id}</td>
				<td>{$Article.title}</td>
				<td>{$Article.categorie}</td>
				<td>{$Article.utilisateur}</td>
				<td>{$Article.creat_on|date_format:$config.format_date}</td>
				<td style="text-align:center;">
					<a href="{$Helper->getLinkAdm("article/edit/{$Article.id}")}" title=""><i class="icon-pencil"></i></a>&nbsp;&nbsp;
					<a href="javascript:deleteArticle({$Article.id}, '{$Article.title}');" title=""><i class="icon-trash"></i></a>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>
</div>
{/strip}
<script type="text/javascript">
<!--
function deleteArticle(article_id, article_title){
	if( confirm("{$lang.Confirm_suppression_article} : "+ article_title +" ?") ){
		window.location.href = '{$Helper->getLinkAdm("article/delete/'+ article_id +'")}'
	}
}
//-->
</script>