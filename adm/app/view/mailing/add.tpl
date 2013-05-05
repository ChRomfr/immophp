<div id="bread">
	<a href="{getLinkAdm("index/index")}" title="">Administration</a>&nbsp;>>&nbsp;
	<a href="{getLinkAdm("mailing/index")}" title="">Mailing</a>&nbsp;>>&nbsp;
	Nouveau
</div>
	
<form id="mailingadd" method="post" class="form">
	<h1>Nouveau mailing</h1>
	<dl>
		<dt><label>{$lang.Sujet} :</label></dt>
		<dd><input type="text" name="mailing[sujet]" /></dd>
	</dl>
	<dl>
		<dt><label>{$lang.Message} :</label></dt>
		<dd><textarea name="mailing[message]" id="message" cols="60" rows="6" class="ckeditor validate[required]"></textarea></dd>
	</dl>
	<div class="center form_center">
		<input type="submit" value="{$lang.Envoyer}" />
	</div>
</form>