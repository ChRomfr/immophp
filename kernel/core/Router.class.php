<?php
/*
                                     _,,                                   ,dW 
                                   ,iSMP                                  JIl; 
                                  sPT1Y'                                 JWS:' 
                                 sIl:l1                                 fWIl?  
                                dIi:Il;                                fW1"    
                               dIi:l:I'                               fWI:     
                              dIli:l:I;                              fWI:      
                            .dIli:I:S:S                     .       fWIl`      
                          ,sWSSIIIiISIIS w,_             .sMW     ,MWIl;       
                     _.,sWWW*"'*" , SWW' MWWMm mu,,._  .iSYISb, ,MM*SI!:       
                 _,s YMMWW'',sd,'MM WMMi "*MW* WWWMWMb MMS WWP`,MW' S1!`       
            _,os,'MMi YW' m,'WW; WWb`SWM Im,,  SIS ISW SISIP*  WSi  II!.       
         .osSMWMW,'WSi ',MMP SSb WSW ISII`SYYi III !Il lIi,ui:,*1:li:l1!       
      ,sSMMWWWSSSS,'SWbdWW*  *YSbiSS:'IlI 7llI il1: l! 'l:+'+l; `''+1i:1i      
   ,sYSMWMWY**"""'` 'WWSSIIiu,'**Y11';IIIb ?!li ?l:i,         `      `'l!:     
  sPITMWMW'`.M.wdWWb,'YIi `YT" ,u!1",ISIWWm,'+?+ `'+Ili                `'l:,   
  YIi1lTYfPSkyLinedI!i`I!" .,:!1"',iSWWMMMMMmm,                                
    "T1l1lI**"'`.2006? ',o?*'``  ```""**YSWMMMWMm,                             
         "*:iil1I!I!"` '                 ``"*YMMWWM,                           
               ii!                             '*YMWM,                         
               I'                                  "YM                        
*/

/**
*	Gere le routage du FRAMEKORK
*	La route peut contenir 3 parametre controller/action/parametre
*	S il y des infos derriere la chaine elle ne seront pas prise en compte, ce qui permet
*	pour avoir des url propre de pouvoir ajouter derriere un nom/titre ...
*/
class Router{

/**
*	@param class $registry
*/
 private $registry;

 /*
 * @the controller path
 */
 private $path;

 public $args = array();

 public $file;

 public $controller;

 public $action; 

 public $adm = 0;
 
 public $route;

 function __construct($registry) {

    $this->registry = $registry;
	$this->getRoute();

	# On dertime si on est dans l administration ou non 
	$Result = strpos( $_SERVER['REQUEST_URI'], '/adm/');

	if( $Result !== false ):
		$this->adm = 1;
	endif;
 }
 
 function getRoute(){
	
	if( !isset($_SERVER['REDIRECT_QUERY_STRING']) )
		$route = str_replace($_SERVER['SCRIPT_NAME'] .'/','', $_SERVER['REQUEST_URI']);
	else
		$route = $_SERVER['REDIRECT_QUERY_STRING'];
		
	$this->route = $route;
		
	$route = explode('?', $route);
	$route = explode('&', $route[0]);
	$route = explode('/',$route[0]);
	//var_dump($route);
	if( !empty($route[0]) )
		$this->controller = $route[0];
	else
		$this->controller = 'index';
		
	if( !empty($route[1]) )
		$this->action = $route[1];
	else
		$this->action = 'index';
	
	if( !empty($route[2]) )
		$this->args = $route[2];
		
	
 }
 
function setPath($path) {

	# On verifie si le controller est u bundle
	if( is_dir(ROOT_PATH . 'bundle' . DS . $this->controller . DS) ):
		# On est dans un bundle
		if( $this->adm == 1 ):
			$this->path = ROOT_PATH . 'bundle' . DS . $this->controller . DS . 'adm' . DS . 'controller' . DS;
		else:
			$this->path = ROOT_PATH . 'bundle' . DS . $this->controller . DS . 'app' . DS . 'controller' . DS;
		endif;
	
	else:

	
		if( !is_array($path) ):
			/*** check if path i sa directory ***/
			if (is_dir($path) == false)
			{
				throw new Exception ('Invalid controller path: `' . $path . '`');
			}
			/*** set the path ***/
			$this->path = $path;
		else:
			foreach($path as $row):
				if( is_dir($row) && is_file($row . $this->controller . 'Controller.php') ):
					$this->path = $row;
				endif;
			endforeach;
			
			if( empty($this->path) ):
				$NbPath = count($path)-1;
				$this->path = $path[$NbPath];
			endif;
			
		endif;
	endif;
}
 
 public function loader(){
	
	$this->action = $this->action.'Action';
	$this->controller = $this->controller . 'Controller';
	
	$this->getController();
	
	if( !method_exists($this->controller, $this->action) || !is_callable(array($this->controller, $this->action)) ){
		$this->action = 'indexAction'; 
	}
	$action = $this->action;

	$class = new $this->controller($this->registry);

	return $class->$action($this->args);
}
 
 public function getController(){
	
	if( is_file($this->path . $this->controller . '.php') ){
		require_once $this->path . $this->controller . '.php';
		
	}else{
		require_once $this->path . DS . 'indexController.php';
		$this->controller = 'indexController';
	}
 }
 
}