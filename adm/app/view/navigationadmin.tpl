{strip}
{if $smarty.session.utilisateur.isAdmin > 4}
<br/>
<div id="menu_adm">
<div class="menu_admin_immo_titre bloc_gauche_titre">Navigation</div>
<div class="menu_admin_immo_navigation bloc_gauche_corp">
<ul class="rang1">
	<li><a href="{getLinkAdm("index")}" title="">{$lang.Administration}</a></li>
	   
	<!-- ARTICLES -->
	<li class="smenu">
		<a href="{getLinkAdm("article")}" title="">{$lang.Article}</a>			
			<ul class="rang2">
				<li><a href="{getLinkAdm("article/add")}" title="">{$lang.Ajouter}</a></li>
				<li>
					<a href="{getLinkAdm("categorie?c=article")}" title=""}>{$lang.Categorie}</a>					
					<ul class="rang3">
						<li><a href="javascript:getFormCategorie();" title="">{$lang.Ajouter}</a></li>
					</ul>					
				</li>
			</ul>			
	</li>
	   
    <!-- BLOK -->
	{if $smarty.const.ADM_BLOK_LEVEL < $smarty.session.utilisateur.isAdmin}		
	<li class="smenu">
		<a href="{getLinkAdm("blok")}" title="">{$lang.Blok}</a>		
		<ul class="rang2">
			<li><a href="{getLinkAdm("blok/add")}" title="">{$lang.Nouveau}</a></li>
		</ul>		
	</li>
	{/if}  
	
	<!-- MENU -->
	<li>
		<a href="{getLinkAdm("menu")}" title="{$lang.Menu}">{$lang.Menu}</a>
	</li>
	
	<!-- NEWS -->
	<li class="smenu">
		<a href="{getLinkAdm("news")}" title="">{$lang.News}</a>
			
			<ul class="rang2">
				<li><a href="{getLinkAdm("news/add")}" title="">{$lang.Ajouter}</a></li>
				<li>
					<a href="{getLinkAdm("categorie?c=news")}" title=""}>{$lang.Categorie}</a>					
					<ul class="rang3">
						<li><a href="javascript:getFormCategorie();" title="">{$lang.Ajouter}</a></li>
					</ul>					
				</li>
			</ul>			
	</li>
	
	<!-- PAGE -->
	{if $smarty.const.ADM_PAGE_LEVEL < $smarty.session.utilisateur.isAdmin}	
	<li class="smenu">
		<a href="{getLinkAdm("page")}" title="">{$lang.Page}</a>		
		<ul class="rang2">
			<li><a href="{getLinkAdm("page/add")}" title="">{$lang.Nouvelle}</a></li>
		</ul>
	</li>
	{/if}
	
	{* PREFERENCES *}
	{if $smarty.const.ADM_PREFERENCE_LEVEL < $smarty.session.utilisateur.isAdmin}	
	<li>
		<a href="{getLinkAdm("configuration")}" title="">{$lang.Preferences}</a>
	</li>	
	{/if}
	
	{* TELECHARGEMENT *}
	<li class="smenu">
		<a href="{getLinkAdm("download")}" title="">{$lang.Telechargement}</a>
			<ul class="rang2">
				<li><a href="{getLinkAdm("download/add")}" title="">{$lang.Ajouter}</a></li>
				<li>
					<a href="{getLinkAdm("categorie?c=download")}" title=""}>{$lang.Categorie}</a>
					<ul class="rang3">
						<li><a href="javascript:getFormCategorie();" title="">{$lang.Ajouter}</a></li>
					</ul>
				</li>
			</ul>
	</li>
	
	{* UTILISATEUR *}
	{if $smarty.const.ADM_USER_LEVEL < $smarty.session.utilisateur.isAdmin}
	<li class="smenu">
        <a href="{getLinkAdm("utilisateur")}" title="">{$lang.Utilisateurs}</a>
        <ul class="rang2">
            <li><a href="{getLinkAdm("utilisateur/add")}" title="">{$lang.Ajouter}</a></li>
        </ul>
    </li>
	{/if}	
	
	{* SYSTEME *}
	<li><a href="{getLinkAdm("systeme")}" title="{$lang.Systeme}">{$lang.Systeme}</a></li>

	{if $smarty.const.ADM_VIEWEDITOR_LEVEL < $smarty.session.utilisateur.isAdmin}
	<!-- Edition des vues -->
	<li><a href="{$Helper->getLinkAdm("viewEditor")}" title="Editeur de vue">Editeur de vue</a></li>
	{/if}
	
	<li><a href="{$config.url}{$config.url_dir}" title="Back">{$lang.Accueil_du_site}</a></li>
</ul>
</div></div>
{/if}
{/strip}