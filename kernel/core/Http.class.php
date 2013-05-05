<?php

class Http {

    private $app;

    protected $protocol;

    protected $host;

    protected $directory;

    public $url;

    public function __construct($app){
        // Recuperation du contrainer
        $this->app = $app;

        // Generation de l url
        $this->get_base_url();
    }
    
	public function get($key){
		return isset($_GET[$key]) ? $_GET[$key] : null;
	}

	public function post($key){
		return isset($_POST[$key]) ? $_POST[$key] : null;
	}

    public function cookieData($key)
    {
        return isset($_COOKIE[$key]) ? $_COOKIE[$key] : null;
    }
    
    public function cookieExists($key)
    {
        return isset($_COOKIE[$key]);
    }
    
    public function getData($key){ return $this->get(); }
    
    public function getExists($key)
    {
        return isset($_GET[$key]);
    }
    
    public function postData($key){ return $this->post(); }
    
    public function postExists($key)
    {
        return isset($_POST[$key]);
    }
    
    public function requestURI()
    {
        return $_SERVER['REQUEST_URI'];
    }

    public function error404(){
        //http_response_code(404);;
        header("HTTP/1.0 404 Not Found");
        //$this->app->smarty->assign('content', $this->app->smarty->fetch(VIEW_PATH . 'error' . DS . '404.tpl'));
        //$this->app->smarty->display( ROOT_PATH . 'themes' . DS . $this->app->config['theme'] . DS . 'layout.tpl' );
        return $this->app->smarty->fetch(VIEW_PATH . 'error' . DS . '404.tpl');
        exit;
    }

    private function get_base_url(){
        /* First we need to get the protocol the website is using */
        $protocol = strtolower(substr($_SERVER["SERVER_PROTOCOL"], 0, 5)) == 'https://' ? 'https://' : 'http://';

        /* returns /myproject/index.php */
        $path = $_SERVER['PHP_SELF'];

        /*
         * returns an array with:
         * Array (
         *  [dirname] => /myproject/
         *  [basename] => index.php
         *  [extension] => php
         *  [filename] => index
         * )
         */
        $path_parts = pathinfo($path);
        $directory = $path_parts['dirname'];

        /*
         * If we are visiting a page off the base URL, the dirname would just be a "/",
         * If it is, we would want to remove this
         */
        $directory = ($directory == "/") ? "" : $directory;

        /* Returns localhost OR mysite.com */
        $host = $_SERVER['HTTP_HOST'];

        /*
         * Returns:
         * http://localhost/mysite
         * OR
         * https://mysite.com
         */
        $this->protocol  = $protocol;
        $this->host      = $host;
        $this->directory = $directory;
        $this->directory = preg_replace("#/index.php[a-z0-9._/-]+#i",'',$this->directory);
        $this->directory = preg_replace("#/index.php#",'',$this->directory);
        $this->directory = preg_replace("#/admin.php[a-z0-9._/-]+#i",'',$this->directory);
        $this->directory = preg_replace("#/admin.php#",'',$this->directory); 
    }

    public function getUrl(){
        return $this->protocol . $this->host . $this->directory .'/';
    }

}