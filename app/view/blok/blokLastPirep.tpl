{* BLOK LAST PIREP FOR SHARKPHPVA *}
{strip}
{if $blok.position == 'left' OR $blok.position == 'right'}
<div class="blok">
	<h3>{$lang.Dernier_pirep}</h3>
	<div>
		{foreach $Pireps as $Row}
		&nbsp;<span><img src="{$config.url}{$config.url_dir}web/images/ACARS_90.png" alt="" style="width:20px;"/><a href="{getLink("flight/detail/{$Row.id}")}" title="">{$Row.dep_icao} to {$Row.arr_icao} - {$config.prefix_indicatif} - {$Row.indicatif}</a></span><br/>
		{/foreach}
	</div>
</div>
{elseif $blok.position == 'top' OR $blok.position == 'foot'}
<div class="blokTopTitre">{$lang.Dernier_pirep}</div>
<div class="blokTop">
	<div class="fleft">
		{foreach $Pireps as $Row name=foo}
		&nbsp;<span><img src="{$config.url}{$config.url_dir}web/images/ACARS_90.png" alt="" style="width:20px;"/><a href="{getLink("flight/detail/{$Row.id}")}" title="">{$Row.dep_icao} to {$Row.arr_icao} - {$config.prefix_indicatif} - {$Row.indicatif}</a></span><br/>
		{if $smarty.foreach.foo.index == 4}{break}{/if}
		{/foreach}
	</div>
	<div class="fright">
		{foreach $Pireps as $Row name=foo}
			{if $smarty.foreach.foo.index > 4}
				&nbsp;<span><img src="{$config.url}{$config.url_dir}web/images/ACARS_90.png" alt="" style="width:20px;"/><a href="{getLink("flight/detail/{$Row.id}")}" title="">{$Row.dep_icao} to {$Row.arr_icao} - {$config.prefix_indicatif} - {$Row.indicatif}</a></span><br/>
			{/if}
		{/foreach}
	</div>
	<div class="clear"></div>
</div>
{/if}
{/strip}