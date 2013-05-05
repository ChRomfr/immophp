<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index/index")}" title="">Administration</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("mailing/index")}" title="">Mailing</a><span class="divider">/</span></li>
	<li>Nouveau</li>
</ul>
	
<form id="mailingadd" method="post" class="form-horizontal well">
	<fieldset>
		<legend>Nouveau mailing</legend>
		<div class="control-group">
			<label class="control-label">{$lang.Sujet} :</label>
			<div class="controls"><input type="text" name="mailing[sujet]" /></div>
		</div>
		<div class="control-group">
			<label class="control-label">{$lang.Message} :</label>
			<div class="controls"><textarea name="mailing[message]" id="message" cols="60" rows="6" class="ckeditor"></textarea></div>
		</div>
		<div class="form-actions">
			<input type="submit" value="{$lang.Envoyer}" class="btn btn-primary" />
		</div>
	</fieldset>
</form>