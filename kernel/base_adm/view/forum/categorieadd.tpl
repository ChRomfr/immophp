<ul class="breadcrumb">
	<li><a href="{$Helper->getLinkAdm("index")}" title="">{$lang.Administration}</a><span class="divider">/</span></li>
	<li><a href="{$Helper->getLinkAdm("forum")}" title="">{$lang.Forum}</a><span class="divider">/</span></li>
	<li>{$lang.Nouvelle_categorie}</li>
</ul>

<form method="post" action="#" class="form-horizontal well" enctype="multipart/form-data">
	
	<fieldset>
		
		<legend>{$lang.Nouvelle_categorie}</legend>

		<div class="control-group">
			<label for="" class="control-label">Nom :</label>
			<div class="controls">
				<input type="text" name="categorie[name]" id="name" required class="input-xxlarge" />
			</div>
		</div>

		<div class="control-group">
			<label for="description" class="control-label">Description :</label>
			<div class="controls">
				<textarea name="categorie[description]" id="description" required class="input-xxlarge"></textarea>
			</div>
		</div>

		<div class="control-group">
			<label for="ordre" class="control-label">Ordre :</label>
			<div class="controls">
				<input type="text" name="categorie[ordre]" id="ordre" required class="input-mir" value="0" />
			</div>
		</div>

		<div class="control-group">
			<label for="visible" class="control-label">{$lang.Visible} :</label>
			<div class="controls">
				<select name="categorie[visible]" required>
					<option value="1">{$lang.Oui}</option>
					<option value="0">{$lang.Non}</option>
				</select>
			</div>
		</div>

		<div class="control-group">
			<label for="admin" class="control-label">{$lang.Administrateurs} :</label>
			<div class="controls">
				<select name="categorie[admin]" required>
					<option value="0">{$lang.Non}</option>
					<option value="1">{$lang.Oui}</option>					
				</select>
				<span class="help-block">Categorie visible que pour les administrateurs.</span>
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
		<input type="hidden" name="categorie[niveau]" value="0" />
		<button type="submit" class="btn btn-primary">{$lang.Enregistrer}</button>
	</div>
</form>