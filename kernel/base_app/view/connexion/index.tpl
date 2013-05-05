{strip}
<!-- base_app/view/connexion/index.tpl -->
<div style="padding-top:15px;"></div>
<div class="well">
	{if isset($Error_login) && !empty($Error_login)}
		<div class="alert">
  			<button type="button" class="close" data-dismiss="alert">&times;</button>
  			<strong>{$Error_login}</strong>
		</div>
	{/if}
	<form method="post" action="" id="formLogin">
		<fieldset>
			<legend>{$lang.Connexion}</legend>
			<div class="container-fluid">
			<div class="row-fluid">
				<div class="span4">
					<label for="identifiant">{$lang.Identifiant} :</label>
					<div class="input-prepend">
						<span class="add-on"><i class="icon-user"></i></span>
						<input autofocus type="text" name="login[identifiant]" id="identifiant" required />
					</div>
				</div><!-- /span4 -->
				<div class="span4">
					<label class="control-label" for="password">{$lang.Mot_de_passe} :</label>
					<div class="input-prepend">
						<span class="add-on"><i class="icon-lock"></i></span>
						<input type="password" name="login[password]" id="password" required />						
					</div>
					<span class="help-block"><a href="{$Helper->getLink("connexion/lostPassword")}" title="{$lang.Mot_de_passe_perdu}" class="muted"><small>{$lang.Mot_de_passe_perdu}</small></a></span>
				</div><!-- /span4 -->
			</div><!-- /row -->
			<div class="row-fluid">
				<div class="span8">
					<div class="form-actions text-center">
						{if isset($smarty.server.HTTP_REFERER)}<input type="hidden" name="referer" value="{$smarty.server.HTTP_REFERER}" />{/if}
						<button type="submit" name="send" class="btn btn-primary">{$lang.Connexion}</button>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span1">
					<i class="icon-flag icon-4x"></i>
				</div>
				<div class="span7">
					<div>Pas encore inscrit ?</div> 
					<div><a href="{$Helper->getLink("utilisateur/register")}" title="{$lang.S_enregistrer}">Creer un compte</a></div>
				</div>
			</div>			
			</div><!-- /container -->

			
			
			
				
				{if $config.register_open == 1}
				&nbsp;&nbsp;
				{/if}
			</div>

		</fieldset>
	</form>
</div><!-- /well -->
{/strip}
<script type="text/javascript">
<!--
jQuery(document).ready(function(){
	$("#formLogin").validate({
		rules:{
			"login[password]":{
				required:true,
			},
			"login[identifiant]":{
				required:true,
			},
		},
		highlight:function(element)
        {
            $(element).parents('.control-group').removeClass('success');
            $(element).parents('.control-group').addClass('error');
        },
        unhighlight: function(element)
        {
            $(element).parents('.control-group').removeClass('error');
            $(element).parents('.control-group').addClass('success');
        }
	});
});
//-->
</script>