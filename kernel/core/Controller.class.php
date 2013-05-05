<?php if(!defined('IN_VA')) exit;

class Controller extends App{
	
	public	$registry,

			$session,
			$data,
			$input,
			$lang,
			$manager;
			
    
    public $app;

    public function  __construct($registry) {
    	parent::__construct($registry);
    	
		global $db, $lang, $smarty, $Session;
		
		$this->registry = $registry;
		$this->lang = $lang;        
        $this->app = $this->registry;
		$this->manager = new stdClass;
    }
	
    public function updateSessionData(){
    	$_SESSION = $this->_session;
    }
	
	public function getToken(){
		return md5(uniqid(rand(), true));
	}
	
	public function getTokenForm(){
		$token = $this->getToken();
		$_SESSION['token_form'] = $token;
		$this->smarty->assign('token_form', $token);
	}
	
	public function _post($str){
		if( isset($_POST[''. $str .'']) ) return $_POST[''. $str .''];
		
		return false;
	}
	
	public function _get($str){
		if( isset($_GET[''. $str .'']) ) return $_GET[''. $str .''];
		
		return false;
	}
	
	public function load_lang($module){
		global $lang;
		$this->lang = $lang;
		if( is_file(ROOT_PATH . 'modules' . DS . $module . DS . 'lang' . DS . 'fr.php') ){
			require ROOT_PATH . 'modules' . DS . $module . DS . 'lang' . DS . 'fr.php';
			$this->lang = array_merge($this->lang, $lang);
			$this->smarty->assign('lang', $this->lang);
		}
	}
	
	public function load_model($model, $type = null){
        
       switch ($type){
            case 'admin':
                require_once ADM_MODEL_PATH . $model .'.php';
                break;
            
            case 'base_app':
                require_once BASE_APP_PATH . 'model' . DS . 'Base' . $model .'.php';
                break;
                
            default:
                if( is_file(ROOT_PATH . 'app' . DS . 'model' . DS . $model .'Model.php') )
				    require_once ROOT_PATH . 'app' . DS . 'model' . DS . $model .'Model.php';
                if( is_file(ROOT_PATH . 'app' . DS . 'model' . DS . $model .'.php') )
				    require_once ROOT_PATH . 'app' . DS . 'model' . DS . $model .'.php';
                elseif( is_file(ROOT_PATH . 'model' . DS . $model .'.php') )
                    require_once ROOT_PATH . 'model' . DS . $model .'.php';
                elseif( is_file( MODEL_PATH . $model .'.php') )
				    require_once MODEL_PATH . $model .'.php';
				elseif( is_file(ADM_MODEL_PATH . $model .'.php') )
					require_once ADM_MODEL_PATH . $model .'.php';
       }    
	}
	
	public function load_controller($controller, $type = null){

		# Code pour comatibilite
		$controller = str_replace('Controller', '', $controller);
	   	
        switch ($type){
            
            case 'admin':
                require_once ROOT_PATH . 'adm' . DS . 'app' . DS . 'controller' . DS . $controller .'.php';
                break;
                
            case 'base_app':
                require_once BASE_APP_PATH . 'controller' . DS . 'Base' . $controller . 'Controller.php';
                
            default:
				if( is_file(APP_PATH . 'controller' . DS . $controller .'Controller.php') ):
					require_once APP_PATH . 'controller' . DS . $controller .'Controller.php';
				elseif( is_file(APP_PATH . 'controller' . DS . $controller .'.php') ):
					require_once APP_PATH . 'controller' . DS . $controller .'.php';
				elseif( is_file(ROOT_PATH . 'adm' . DS . 'app' . DS . 'controller' . DS . $controller .'Controller.php' ) ):
					require_once ROOT_PATH . 'adm' . DS . 'app' . DS . 'controller' . DS . $controller .'Controller.php';
				elseif( is_file(ROOT_PATH . 'adm' . DS . 'app' . DS . 'controller' . DS . $controller .'.php' ) ):
					require_once ROOT_PATH . 'adm' . DS . 'app' . DS . 'controller' . DS . $controller .'.php';
				endif;
        }

        # On renomme correctement le controller pour l appel
       	$controller  = $controller . 'Controller';

		$i = new $controller($this->registry);
		$this->$controller = $i;
		return $i;
	}
		
	
	public function load_manager($manager, $type = null){
	   
       switch($type){
            case 'admin':
                require_once ADM_MODEL_PATH . $manager .'Manager.php';
                $m = $manager.'Manager';
                break;
                
            case 'base_app':
                require_once BASE_APP_PATH . 'manager' . DS . 'Base' . $manager .'Manager.php';
                $m = 'Base' . $manager.'Manager';
                break;
                
            default:
				if( is_file(ROOT_PATH . 'app' . DS . 'model' . DS . $manager .'Manager.php') )
					require_once ROOT_PATH . 'app' . DS . 'model' . DS . $manager .'Manager.php';
				elseif( is_file(ADM_MODEL_PATH . $manager .'Manager.php') )
				
					require_once ADM_MODEL_PATH . $manager .'Manager.php';
                $m = $manager.'Manager';
                break;
       }

		$this->manager->$manager = new $m();
	}
	
	public function sendHttpRequest($controller, $action, array $param = null, $chemin = ''){
			$host =  HOST_HTTP_REQUEST;
			$v = '';
			
			if( !is_null($chemin))
				$v .= $chemin;
			
			$v.= 'index.php?c='. $controller . '&a='. $action;
			
			if( !is_null($param) && is_array($param) ){
				foreach($param as $k => $v){
					$v .= '&'.$k.'='.$v;
				}
			}	

            $fp = fsockopen($host, 80, $errno, $errstr, 10);
            stream_set_blocking ($fp, false);
            $header  = "GET $v HTTP /1.1\r\n";
			$header .= "Host: ". $host ."\r\n";
            $header .= "User-Agent: monScriptPHP\r\n";
            $header .= "Connection: Close\r\n\r\n";
            fputs($fp, $header);
            fclose($fp);
	}
	
	public function redirect($url, $tps = 0, $message = ''){

		$temps = $tps * 1000;

		if($message != ''){
			
			$r = explode('|',$message);
			$text = $r[0];

			if( isset($r[1]) ){
				$affichage = $r[1];
			}else{
				$affichage = 'success';
			}
			
			$this->registry->smarty->assign('error_class', 'error_' . $affichage);
			$this->registry->smarty->assign('error_image', 'comment_' . $affichage);
			$this->registry->smarty->assign('message', $text);
			$this->registry->smarty->assign('url', $url);
			$this->registry->smarty->assign('temp', $temps);
			return $this->registry->smarty->fetch(VIEW_PATH . 'redirect.tpl');
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
	
	protected function getFormValidatorJs(){
		$this->registry->addJS('jquery.validationEngine.js');
		$this->registry->addJS('jquery.validationEngine-fr.js');
		$this->registry->addCSS('formValidator/template.css');
		$this->registry->addCSS('formValidator/validationEngine.jquery.css');
		$this->registry->addJS('validation/jquery.validate.js');
	}
    
    protected function getCkEditorJs(){
        $this->registry->addJS('ckeditor/ckeditor.js');
    }
}