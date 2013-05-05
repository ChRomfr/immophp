<?php

class log {
	
	private $registry;
	
	public function __construct($registry) {
		$this->registry = $registry;
		define('LOG_PATH', ROOT_PATH . 'log' . DS);
	}
	
	public function write($data, $fichier){
		
		if( !is_file(LOG_PATH . $fichier) ){
			$f = fopen(LOG_PATH . $fichier, 'a+');
			fclose($f);
		}
		
		$ancien_contenu = @file(LOG_PATH . $fichier);
		
		$txt = date("Y-m-d h:i") . '|';
		
		if( is_array($data) )
			$data = serialize($data);
			
		$txt .= $data;		
		$txt .= "\n";
		
		@array_unshift($ancien_contenu,$txt);
		
		// ressort les lignes du tableau
		$nouveau_contenu = @join('',$ancien_contenu);
		$fp = @fopen(LOG_PATH . $fichier,'w');
		// ecrit la chaine dans le fichier
		$write = @fwrite($fp, $nouveau_contenu);
		@fclose($fp);		
	}
}	