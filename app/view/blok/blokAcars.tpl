{* ********** blokAcars.tpl **********
	Code HTML du blokAcars
	- var : $Acars : Contient les donnees vols en cours
	- var : $Blok : Contient les informations propre au blok
************************************** *}	
{strip}
{if $Blok.position == 'left' OR $Blok.position == 'right'}
	<div class="blok">
		<h3>Acars</h3>
		<div>
			{foreach $Acars as $Row}
			&nbsp;<span><img src="{$config.url}{$config.url_dir}web/images/ACARS_90.png" alt="" style="width:20px;"/><a href="{getLink("acars/detail/{$Row.id}")}" title="">{$Row.icao_dep} to {$Row.icao_arr} - {$config.prefix_indicatif} - {$Row.indicatif}</a></span><br/>
			{/foreach}
		</div>
	</div>
{else}
{/strip}
<script>
	$(document).ready(function() {
	  $("#time_table td").lettering();
	});
</script>{strip}
	<div class="blokTopTitre">Acars</div>
		<div class="blokTop">
			<table id="time_table" class="timetable">
				<thead>
					<tr>
						<td>Dep.</td>
						<td>&nbsp;</td>
						<td>Arr.</td>
						<td>&nbsp;</td>
						<td>Status&nbsp;</td>
						<td>&nbsp;</td>
						<td>Pilot&nbsp;&nbsp;</td>
				</thead>
				<tbody>
					{foreach $Acars as $Row}
					<tr>
						<td>{$Row.icao_dep}</td>
						<td>&nbsp;</td>
						<td>{$Row.icao_arr}</td>
						<td>&nbsp;</td>
						<td>{$Row.status}</td>
						<td>&nbsp;</td>
						<td>{$config.prefix_indicatif}-{$Row.indicatif}</td>
					</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
{/if}	
{/strip}