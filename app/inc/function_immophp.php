<?php

// Surcharge de la lang
require_once ROOT_PATH . 'app' . DS . 'inc' . DS . 'french.php';
$registry->smarty->assign('lang',$lang);

/**
*
*   @param object $App 
*   @return array $Agences : tableau contenant les agences
*/
function getAgences($App){

    if( !$Agences = $App->cache->get('agences') ):
        $Agences = $App->db->get(PREFIX . 'agence', null, 'nom');
        $App->cache->save(serialize($Agences));
        return $Agences;
    endif;

    return unserialize($Agences);

}

function getCategories($App){

    if( !$Categories = $App->cache->get('categories_bien') ):
        $Categories = $App->db->get(PREFIX . 'bien_categorie', array('level =' => 0), 'name');
        $App->cache->save(serialize($Categories));
        return $Categories;
    endif;

    return unserialize($Categories);
}


function updateImmophp(){
    global $config;

    $Files = getFilesInDir( ROOT_PATH . 'app' . DS . 'update' . DS . 'sql' . DS );
    
    if( !empty($Files)):
        foreach( $Files as $k => $v ):
            $VersionTest = str_replace('.php', '', $k);
           
            if( $VersionTest > $config->config['version'] ):
                # On inclue le fichier qui fait la mise a jour
                require ROOT_PATH . 'app' . DS . 'update' . DS . 'sql' . DS . $VersionTest . '.php';
            endif;

        endforeach;
    endif;
}

function WriteInFileUpdate($txt){
    $file_name = date("Y-m-d") .'.log';
    // On verifie si le fichier du jour existe
    $file = ROOT_PATH . 'log' . DS . 'update' . DS . $file_name;

    // On verifie sur le fichier existe
    // Si celui ci n existe pas on le créer
    if( !is_file($file) ){
        $f = fopen($file, 'a+');
        fclose($f);
    }

    // On stock l ancien contenu du fichier
    $ancien_contenu = @file($file);

    // On ajoute la nouvelle ligne au debut du tableau
    @array_unshift($ancien_contenu,$txt);

    // ressort les lignes du tableau
    $nouveau_contenu = @join('',$ancien_contenu);
    $fp = @fopen($file,'w');
    // ecrit la chaine dans le fichier
    $write = @fwrite($fp, $nouveau_contenu);
    @fclose($fp);
}