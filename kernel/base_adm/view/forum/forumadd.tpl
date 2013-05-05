<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("forum")}" title="">{$lang.Forum}</a><span class="divider">/</span></li>
	<li>{$lang.Nouveau}</li>
</ul>

<form method="post" action="#" class="form-horizontal well" enctype="multipart/form-data">
	
	<fieldset>
		
		<legend>{$lang.Nouveau_forum}</legend>

		<div class="control-group">
			<label for="" class="control-label">Nom :</label>
			<div class="controls">
				<input type="text" name="forum[name]" id="name" required class="input-xxlarge" />
			</div>
		</div>

		<div class="control-group">
			<label for="description" class="control-label">Description :</label>
			<div class="controls">
				<textarea name="forum[description]" id="description" class="input-xxlarge"></textarea>
			</div>
		</div>

		<div class="control-group">
			<label for="ordre" class="control-label">Ordre :</label>
			<div class="controls">
				<input type="text" name="forum[ordre]" id="ordre" required class="input-mir" value="0" />
			</div>
		</div>

		<div class="control-group">
			<label for="visible" class="control-label">{$lang.Visible} :</label>
			<div class="controls">
				<select name="forum[visible]" required>
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="control-group">
			<label for="image" class="control-label">Image :</label>
			<div class="controls">
				<div class="uploader">
					<input type="file" name="image" id="image" />
					<span class="filename">No file selected</span>
					<span class="action">Choose file</span>
				</div>
			</div>
		</div>

	</fieldset>

	<div class="form-actions">
		<input type="hidden" name="forum[admin]" value="0" />
		<input type="hidden" name="forum[niveau]" value="0" />
		<input type="hidden" name="forum[niveau_poll]" value="0" />
		<input type="hidden" name="forum[niveau_vote]" value="0" />
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</div>
</form>