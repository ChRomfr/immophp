<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#registerForm").validationEngine();
});
</script>

<form class="form" method="post" action="#" id="formlostpassword">
	<h1>{$lang.Mot_de_passe_perdu}</h1>
	<dl>
		<dt><label for="email">{$lang.Email} :</label></dt>
		<dd><input type="email" name="email" class="validate[required,custom[email]]" autocomplete="off" id="email" required/></dd>
	</dl>
	<div class="center">
		<input type="submit" value="{$lang.Changer_de_mot_de_passe}" />
	</div>
</form>