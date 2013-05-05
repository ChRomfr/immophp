{strip}
<table>
    <tr>
        {foreach $Photos as $k => $v name=foo}
            <td class="center">
                <img src="{$config.url}{$config.url_dir}web/upload/bien/{$bien_id}/{$v}" style="width:200px;" alt="" /><br/>
                <a href="javascript:deletePhoto('{$v}','{$bien_id}')" title=""><i class="icon-trash"></i></a>
            </td>
            {if $smarty.foreach.foo.iteration%3 == 0}
            </tr><tr>
            {/if}
        {/foreach}
    </tr>
</table>
{/strip}