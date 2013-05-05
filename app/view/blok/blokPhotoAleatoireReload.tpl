{strip}
<a href="{getLink("gallery/detail/{$photo.id}")}" title="{$photo.poisson} - {$photo.poid} Kg - {$photo.taille} Cm">
	<img src="{$config.url}{$config.url_dir}web/upload/carpbook/depart/{$photo.depart_id}/{$photo.photo}" alt="{$photo.poisson} - {$photo.poid} Kg - {$photo.taille} Cm" style="width:200px;" />
</a>
{/strip}