{strip}
<div class="blok">
	<div class="bloc_gauche_titre">Photo aléatoire</div>
    <div class="bloc_gauche_corp">
		<div style="text-align:center;">
			<div id="photodepartslider">
				<a href="{getLink("gallery/detail/{$photo.id}")}" title="{$photo.poisson} - {$photo.poid} Kg - {$photo.taille} Cm">
					<img src="{$config.url}{$config.url_dir}web/upload/carpbook/depart/{$photo.depart_id}/{$photo.photo}" alt="{$photo.poisson} - {$photo.poid} Kg - {$photo.taille} Cm" style="width:200px;" />
				</a>
			</div>
		</div>
    </div>
    <div class="bloc_gauche_footer"></div>
</div>
{/strip}

<script type="text/javascript">
<!--
	function reloaddepartphoto(){	
		$.get(
			'{getLink("carpbook/ajaxReloadBlokPhotoAleatoire")}', {literal}
			{nohtml:'nohtml'},
			function(data){ $('#photodepartslider').html(data); }
		);{/literal}        
	}
	
	setInterval("reloaddepartphoto()",8000);
//-->
</script>