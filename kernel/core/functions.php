<?php if( !defined('IN_VA') ) exit;

function getConfig($app){

	if( !$config = $app->cache->get('config') ){
		$tmp = $app->db->get(PREFIX . 'config');
		$cfg = array();
		foreach($tmp as $data){
			$cfg[$data['cle']] = $data['valeur'];
		}
		
		$app->cache->save(serialize($cfg));
		return $cfg;
	}
	
	return unserialize($config);
	
}

/**
 * [getLinkAdm description]
 * @param  [type] $link [description]
 * @return [type]       [description]
 */
function getLinkAdm($link){ global $registry; return $registry->Helper->getLinkAdm($link); }

/**
 * [getLink description]
 * @param  [type] $str [description]
 * @return [type]      [description]
 */
function getLink($link){ global $registry; return $registry->Helper->getLink($link); }

/**
*	getUniqueID
*	Genere un ID unique
*	@return string Id unique
* */
function getUniqueID(){
	return md5(uniqid(rand(), true));
}

function redirect($url, $tps = 0, $message = ''){

    $temps = $tps * 1000;

    if($message != ''){
		
		global $smarty;
		
        $r = explode('|',$message);
        $text = $r[0];

        if( isset($r[1]) ){
            $affichage = $r[1];
        }else{
            $affichage = 'success';
        }
		
        $smarty->assign('error_class', 'error_' . $affichage);
        $smarty->assign('error_image', 'comment_' . $affichage);
        $smarty->assign('message', $text);
        $smarty->assign('url', $url);
        $smarty->assign('temp', $temps);
        return $smarty->fetch('redirect.tpl');
    }else{

		echo "<script type=\"text/javascript\">\n"
		. "<!--\n"
		. "\n"
		. "function redirect() {\n"
		. "window.location='" . $url . "'\n"
		. "}\n"
		. "setTimeout('redirect()','" . $temps ."');\n"
		. "\n"
		. "// -->\n"
		. "</script>\n";
		exit;
    }
}

function hash_password($password){
	return sha1($password);
}

/**
 * Verifie la synthase d'une adresse email
 * @param string $adresse email a verifie
 * @return bool 
 * */
function VerifieAdresseMail($adresse)
{
   $Syntaxe='#^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,6}$#';
   if(preg_match($Syntaxe,$adresse))
      return true;
   else
     return false;
}

/**
*	Foction facilitant l'envoie d'un mail a l aide de phpmailer
*   @param mixed $destinataire
*   @param string $expediteur
*   @param string $sujet
*   @param string $message
*   @param string $messageHTML
*   @param string $file
*   @return bool
*/
function sendEmail($destinataire, $expediteur, $sujet, $message, $messageHTML = '', $file = ''){
	global $registry;
	
	if( !ini_get('safe_mode') ){ set_time_limit(600); }	// Si possible on augmente le tps d excution
	
	# Creation instance
	$mail = new PHPMailer();
	
	$mail->CharSet = 'UTF-8';		

	// Traitement method d envoie
	if( $registry->config['mail_method'] == 'smtp' && $registry->config['smtp_server'] != '' ){
		// Parametrage pour utilisation SMTP
		$mail->IsSMTP();
		$mail->Host = $registry->config['smtp_server'];
		$mail->Port = $registry->config['smtp_port'];

		// Si champ identifiant et mdp smtp utilisation authentification
		if( $registry->config['smtp_login'] != '' && $registry->config['smtp_password'] != '' ){
			$mail->SMTPAuth = true;
			$mail->Username = $registry->config['smtp_login'];
			$mail->Password = $registry->config['smtp_password'];
		}
	}
	
	// Adresse reponse
	$mail->AddReplyTo($expediteur);
	$mail->SetFrom($expediteur);

	// destinataire
	if( is_array($destinataire) ){
		foreach($destinataire as $k => $email){
			$mail->AddAddress($expediteur);
			$mail->AddBCC($email);
		}
	}else{
		$mail->AddAddress($destinataire);
	}

	//Message
	$mail->Subject    = $sujet;
	$mail->AltBody    = $message;
	
	// Fichier joint
	if($file != ''){
		$mail->AddAttachment($file);
	}
	
	if($messageHTML != '')
		$mail->MsgHTML($messageHTML);
	else
		$mail->MsgHTML(nl2br($message));

	// Envoie
	if(!$mail->Send())
		return false;
	else
		return true;  
}

/**
*	Listes les dossisers dans un dossier
*
*/
function getDirsInDir($dirname, $path_return = ''){

	# On verifie que le dossier existe
    if( !is_dir($dirname) ):
        return false;
    endif;

    # On ouvre le dossier
    $dir = opendir($dirname);
    // Init du tableau
    $dirs = array();
    // On liste les fichier
    while($tmp = readdir($dir)){
        if($tmp != '.' && $tmp != '..' && !is_file($dirname.$tmp) && $tmp != ' '){
            $dirs[$tmp] = $path_return . $tmp;
        }
    }
    // On ferme le dossier
    closedir($dir);
    // On retourne les fichiers
    return $dirs;
}

function getFilesInDir($dirname, $path_return = ''){
    
    // On verifie que le dossier existe
    if( !is_dir($dirname) ){
        return false;
    }
    // On ouvre le dossier
    $dir = opendir($dirname);
    // Init du tableau
    $files = array();
    // On liste les fichier
    while($file = readdir($dir)){
        if($file != '.' && $file != '..' && !is_dir($dirname.$file) && $file != ' '){
            $files[$file] = $path_return . $file;
        }
    }
    // On ferme le dossier
    closedir($dir);
    // On retourne les fichiers
    return $files;
}

/**
 * Contruit la pagination
 * @param array $param : perPage => Nombre d element sur une page | fileName => Url pour la pagination (ex : index.php?c=controller&page=%d) | totalItems => Nombre d element total
 * @return mixed Code html contenant la pagination
 * */
function getPagination($param){
	global $registry;

	// FOR BC
	$config = $registry->config;

	if( strstr($_SERVER['REQUEST_URI'], 'adm/') == TRUE):
		$param['fileName'] = str_replace($config['url'] . $config['url_dir'] . 'adm/', '', $param['fileName']);
	else:
		$param['fileName'] = str_replace($config['url'] . $config['url_dir'], '', $param['fileName']);
    endif;
	
	if( $config['rewrite_url'] == 1 && strstr($_SERVER['REQUEST_URI'], 'adm/') == false):
		$param['fileName'] = str_replace('index.php/', '', $param['fileName']);
	endif;
    
	if( $config['url_dir'] == '' )
		$path = substr($config['url'],0,-1);
	else
		$path = $config['url'] . substr($config['url_dir'],0,-1);
    
    if( strstr($_SERVER['REQUEST_URI'], 'adm/') == TRUE):
        $path .= '/adm';
    endif;

    $pager_option = array(
    'mode'  =>  'Sliding',
    'perPage'   =>  $param['perPage'],
    'append' => false,
    'delta' =>  2,
    'urlVar' =>  'page',
	'path'	=>	$path,
    'fileName'  =>  $param['fileName'],
    'totalItems'    =>  $param['totalItems'] );

    $pager = & Pager::factory($pager_option);
    $links = $pager->getLinks();
	
    return $links['all'];
}

/**
 * Calcul l offset pour les requetes SQL
 * Pour la page courante cette fonction est lien a la fonction getPagination
 * @param int $limit	
 * @return int $offset
 * */
function getOffset($limit = 30){
    if(isset($_GET['page']))
        $current_page = $_GET['page'];
    else
        $current_page = 1;
    
    // Calcul du offset
    $offset = $current_page * $limit - $limit;
    
    return $offset;
}

/**
 * getChaine
 * Genere une chaine aleatoire
 *
 * @param int $long longueur de la chaine
 * @return string $str chaine aleatoire
 * */
function getChaine($long = 8){
    $chaine = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    $str = '';
    for($u = 1; $u <= $long; $u++) {
        $nb = strlen($chaine);
        $nb = mt_rand(0,($nb-1));
        $str .= $chaine[$nb];
    }
    return $str;
}

function clearHtmlCode($code){
    $code = trim($code);
    $code = str_replace("\r", '', $code);
    $code = str_replace("\n", '', $code);
    $code = str_replace("\t", '', $code);
    return $code;
}


function getUrlForPagination(){
	if( isset($_GET['page']) )
        // On supprime le page=page_courant et et recupere les parametre d appel
        $url = str_replace('&page=' . $_GET['page'],'',$_SERVER['QUERY_STRING']); 
    else 
        // On recupere les parametres d appele, ce qui permet d inclure les parametres de recherche et de tri
        $url = $_SERVER['QUERY_STRING'];
        
    return $url;
}

/**
*	Convertie un nombre de seconde au format HH:MM:SS
*	@param int $value nombre de seconde
*	@return string chaine formaté
*/
function secondesInDuree($value){

	//initialisation
	$secondes = 0;
	$minutes = 0;
	$heure = 0;
	
	//convertion
	$minutes = $value/60; 
	$secondes = bcmod($value,"60");
	$minutes = floor($minutes);
	
	while($secondes >= "60") //ajoute une minute toutes les 60 secondes
	{
	 	$secondes = $secondes-60;
	 	$minutes++;
	}
	
	while($minutes >= "60")//ajoute une heure toutes les 60 minutes
	{
	 	$minutes = $minutes-60;
	 	$heure++;
	}
	
	if($minutes < "10") // ajoute le deuxieme 0 pour la prÃ©sentation
	{
		$minutes = "0".$minutes;
	}
	
	if($secondes < "10") // ajoute le deuxieme 0 pour la prÃ©sentation
	{
		$secondes = "0".$secondes;
	}
	
	if($heure < "10") // ajoute le deuxieme 0 pour la prÃ©sentation
	{
		$heure = "0".$heure;
	}
	
	return $heure.":".$minutes.":".$secondes; //contient le rÃ©sultat final
}

/**
*	Verifie que la chaine passé est conforme a la structure des duree
*	@param str $str Heures:Minutes 01:30
*	@return bool
*/
function validHeure($str){
	$h = explode(':', $str);
	
	if( count($h) != 2)
		return false;
	
	if( $h[0] > 24)
		return false;
		
	if( $h[1] > 59)
		return false;
		
	return true;
}

/**
*	Verifie que la chaine passé est conforme a la structure des duree
*	@param str $str Heures:Minutes 01:30
*	@return bool
*/
function validDuration($str){
	$h = explode(':', $str);
	
	if( count($h) != 2)
		return false;
		
	if( $h[1] > 59)
		return false;
		
	return true;
}

/**
*	[0] = lat
*	[1] = lon
*/
function getDistance2pts($coord1, $coord2){
	$r = 6366;

	$coord1[0] = deg2rad($coord1[0]);
	$coord1[1] = deg2rad($coord1[1]);
	$coord2[0] = deg2rad($coord2[0]);
	$coord2[1] = deg2rad($coord2[1]);
	
	$ds= acos(sin($coord1[0])*sin($coord2[0])+cos($coord1[0])*cos($coord2[0])*cos($coord1[1]-$coord2[1]));
	
	$dpr = $ds * $r;
	
	return $dpr * 0.54;	// return une distance en nm	
}

/**
*	Recupere la liste des themes valides dans le dossier
*	@return mixed $result tableau le nom des themes disponibles
*/
function getThemes(){
	$result = array();
	
	$handle = @opendir(ROOT_PATH . 'themes');
	
	while (false !== ($f = readdir($handle))){
		if ($f != "." && $f != ".." && $f != "CVS" && $f != "index.html" && !preg_match("`[.]`", $f)){
			if( is_file(ROOT_PATH . 'themes' . DS . $f . DS . 'layout.tpl') ){
				$result[] = $f;
			}
        }
	}
    closedir($handle);

    return $result;
}

function FormatDateToTimestamp($date){
	$tmp = explode('/',$date);
	return mktime(0,0,0,$tmp[1],$tmp[0],$tmp[2]);	
}

/**
 * Formate une date fran�aise jj/mm/aaaa au format mysql yyyy-mm-dd
 * @param string $date
 * @return string
 */
function FormatDateToMySql($date){
	$tmp = explode('/',$date);
	return $tmp[2] . '-' . $tmp[1] . '-' . $tmp[0];	
}

function TimeToDATETIME($time = null){
	if( is_null($time) ):
		$time=time();
	endif;
	return date('Y-m-d G:i:s', $time);
}


function cryptPassword($password, $identifiant){
	return sha1( sha1(strtolower($identifiant)) . $password );
}

function isInDbCpVille( $cp, $ville){
	global $registry;
	
	$ville = mb_strtoupper($ville, 'UTF-8');
	$ville = str_replace('ST ','SAINT ', $ville);
	
	// Verification si existe dans la base
	$Result = $registry->db->count(PREFIX . 'commun_cp_ville', array('cp =' => $cp, 'ville =' => $ville) );
	
	if( $Result == 0 ):
		// Enregistrement dans la base
		$registry->db->insert(PREFIX . 'commun_cp_ville', array('cp' => $cp, 'ville' => $ville) );
	endif;	
}

/**
*	Cette fonction ajoute dans la table des liens disponible un link pour l ajouter au menu
*
*/
function addLinkAvailable($name, $link){
	global $registry;
	
	$registry->db->insert(PREFIX . 'link_available', array('name' => $name, 'link' => $link));
}

function deleteLinkAvailable($link){
	global $registry;
	
	$registry->db->delete(PREFIX . 'link_available', null, array('link =' => $link));
}

/**
*	Retourne un tableau contenant 1 jour de la semaine en timestamp, dernier jour de la semaine en timesptamp, 1 et 7 au format US et FR
*	Sec dans 24h : 86400
*
*/
function getSemaineData($date){
	
	$data = array();
	# On determine le 1er jour de la semaine et le dernier
    $Tmp = explode('/',$date);
    #Creation du timestamp de la date
    $timestamp = mktime(0,0,0,$Tmp[1],$Tmp[0],$Tmp[2]);
    #Recuperation du jour de la semaine
    $j_semaine = date('N', $timestamp);

    switch ($j_semaine) {
    	case 1:
    		$data['first_day_timetamp'] = $timestamp;
    		$data['last_day_timestamp'] = $data['first_day_timetamp'] + (86400*6);
    		break;

    	case 2:
    		$data['first_day_timetamp'] = $timestamp - 86400;
    		$data['last_day_timestamp'] = $data['first_day_timetamp'] + (86400*6);
    		break;

    	case 3:
    		$data['first_day_timetamp'] = $timestamp - (86400*2);
    		$data['last_day_timestamp'] = $data['first_day_timetamp'] + (86400*6);
    		break;

    	case 4:
    		$data['first_day_timetamp'] = $timestamp - (86400*3);
    		$data['last_day_timestamp'] = $data['first_day_timetamp'] + (86400*6);
    		break;

    	case 5:
    		$data['first_day_timetamp'] = $timestamp - (86400*4);
    		$data['last_day_timestamp'] = $data['first_day_timetamp'] + (86400*6);
    		break;

    	case 6:
    		$data['first_day_timetamp'] = $timestamp - (86400*5);
    		$data['last_day_timestamp'] = $data['first_day_timetamp'] + (86400*6);
    		break;

    	case 7:
    		$data['first_day_timetamp'] = $timestamp - (86400*6);
    		$data['last_day_timestamp'] = $data['first_day_timetamp'] + (86400*6);
    		break; 
    }

    // On format les dates en US - FR
    $data['first_day_FR'] = date('d', $data['first_day_timetamp']) . '/' . date('m', $data['first_day_timetamp']) . '/' . date('Y', $data['first_day_timetamp']);
    $data['first_day_US'] = date('Y', $data['first_day_timetamp']) . '-' . date('m', $data['first_day_timetamp']) . '-' . date('d', $data['first_day_timetamp']);
    $data['last_day_FR'] = date('d', $data['last_day_timestamp']) . '/' . date('m', $data['last_day_timestamp']) . '/' . date('Y', $data['last_day_timestamp']);
    $data['last_day_US'] = date('Y', $data['last_day_timestamp']) . '-' . date('m', $data['last_day_timestamp']) . '-' . date('d', $data['last_day_timestamp']);
    $data['week_number'] = date('W',$data['first_day_timetamp']);

    return $data;
}