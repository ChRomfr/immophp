<?php
/*
*	Genere une requete INSERT
*/
function CreateQueryInsert($array, $table){
    global $db;
    
	$ChampDB = '';
	$ValeurChamp = '';

	foreach($array as $key => $value){
		/*if($ChampDB == '') $ChampDB .= $key;
		else $ChampDB .= ','.$key;*/
		if($ChampDB == '') $ChampDB .= '`'.$key.'`';
		else $ChampDB .= ',`'.$key.'`';

		if($ValeurChamp == '') $ValeurChamp .= ' '. $db->quote($value) .' ';
		else $ValeurChamp .= ','. $db->quote($value) .'';
	}

	return 'INSERT INTO '. $table .' ('. $ChampDB .') VALUES ('. $ValeurChamp .')';
}

/*
*	Genere une requete UPDATE
*/
function CreateQueryUpdate($array, $table, $conditions = ''){
	global $db;
	
	$ChampDB = '';
	$ValeurChamp = '';

	foreach($array as $key => $value){
		//if($ChampDB == '') $ChampDB .=  $key .' =  '. $db->quote($value)  .' ';
        //else $ChampDB .= ',' . $key .' =  '. $db->quote($value)  .' ';
		if($ChampDB == '') $ChampDB .=  '`'.$key .'` =  '. $db->quote($value)  .' ';
        else $ChampDB .= ',' . $key .' =  '. $db->quote($value)  .' ';
	}

	return "UPDATE ". $table ." SET ". $ChampDB ." WHERE ". $conditions ;
}
?>