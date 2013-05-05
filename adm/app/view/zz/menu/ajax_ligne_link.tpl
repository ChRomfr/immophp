<!--
	SHARKPHP FRAMEWORK
	http://www.sharkphp.com
	@author : Romain DROUCHE
-->

{strip}
<!-- Nouvelle ligne du table -->
<tr class="MoveableRow">
	<td><input type="text" name="link[{$link_id}][name]" id="link_name_{$link_id}" value="" required class="input-small" onkeypress="getlinks({$link_id})" onfocus="getlinks({$link_id})"/></td>
	<td><input type="text" name="link[{$link_id}][link]" id="link_link_{$link_id}" value="" required class="input-small" /></td>
	<td>
		<select name="link[{$link_id}][visible_by]" id="">
			<option value="all">{$lang.Tout_le_monde}</option>
			<option value="member">{$lang.Membres}</option>
			<option value="administrateurs">{$lang.Administrateur}</option>
		</select>
	</td>
	<td><input type="checkbox" name="link[{$link_id}][new_page]" id="" /></td>
	<td><input type="checkbox" name="link[{$link_id}][enabled]" id="" checked="checked"/></td>
	<td>
		<span class="down_button"><img src="{$smarty.const.URL_IMG_ACTION}arrow_down.png" /></span>&nbsp;
		<span class="up_button"><img src="{$smarty.const.URL_IMG_ACTION}arrow_up.png" /></span>&nbsp;
		<img src="{$smarty.const.URL_IMG_ACTION}delete.png" class="delete" />
	</td>
</tr>
{/strip}