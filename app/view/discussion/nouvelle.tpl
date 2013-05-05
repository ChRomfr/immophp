<script>
	jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#newDiscussion").validationEngine();
});
</script>
{if $config.bread}
<div id="bread">
	<a href="{getLink("index")}" title="{$lang.Accueil}">{$lang.Accueil}</a>&nbsp;-&gt;&nbsp;
	<a href="{getLink("discussion")}" title="{$lang.Message}">{$lang.Message}</a>&nbsp;-&gt;&nbsp;
	{$lang.Nouvelle}
</div>
{/if}
<h2>{$lang.Nouvelle_discussion}</h2>
<form method="post" id="newDiscussion">
	<dl>
		<dt><label for="destinataire">{$lang.Destinataire} :</label></dt>
		<dd>
			<select name="mess[destinataire_id]" id="destinataire" class="validate[required]">
				<option value=""></option>
				{foreach $utilisateurs as $user}
					{if $user.id != $smarty.session.utilisateur.id}
					<option value="{$user.id}">{$user.identifiant}</option>
					{/if}
				{/foreach}
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label for="sujet">{$lang.Sujet} :</label></dt>
		<dd><input type="text" name="disc[sujet]" value="" id="sujet" class="validate[required]" /></dd>
	</dl>
	<dl>
		<dt><label for="message">{$lang.Message} :</label></dt>
		<dd><textarea name="mess[message]" id="message" class="validate[required]" rows="5" cols="50"></textarea></dd>
	</dl>
	<div class="center from_submit">
		<input type="submit" name="send" value="{$lang.Envoyer}" />
	</div>
</form>