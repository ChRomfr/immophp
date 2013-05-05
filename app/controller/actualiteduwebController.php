<?php

class actualiteduwebController extends Controller {

	public function indexAction(){

	}

	public function getFluxAction(){
		require_once ROOT_PATH . 'kernel' . DS . 'lib' . DS . 'FeedReader.php';

		$FLux = array(
			'http://feeds.feedburner.com/Grafikart?format=xml',
			'http://feeds.lafermeduweb.net/LaFermeDuWeb'
		);

	}

}