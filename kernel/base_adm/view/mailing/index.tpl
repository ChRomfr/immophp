<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index/index")}" title="">Administration</a><span class="divider">/</span></li>
	<li>Mailing</li>
</ul>
	
<div class="well">
	<div class="fright">
		<a href="{$Helper->getLinkAdm("mailing/add")}" title=""><i class="icon-plus"></i></a>
	</div>
	<h4>Mailing</h4>
	<div class="clear"></div>
	<hr/>
	<table class="table">
		<thead>
			<tr>
				<td>Date</td>
				<td>Sujet</td>
			</tr>
		</thead>
		<tbody>
			{foreach $Mailings as $Row}
			<tr>
				<td>{$Row.date_mailing}</td>
				<td>{$Row.sujet}</td>
			</tr>	
			{/foreach}
		</tbody>
	</table>
</div>