<div id="bread">
	<a href="{getLinkAdm("index/index")}" title="">Administration</a>&nbsp;>>&nbsp;
	Mailing
</div>
	
<div class="showData">
	<h1>Mailing</h1>
	<table class="tadmin">
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