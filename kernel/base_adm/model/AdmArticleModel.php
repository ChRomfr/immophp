<?php

abstract class AdmArticleModel extends Record{

	const Table = 'article';

	public	$id;
	public	$title;
	public	$article;
	public	$creat_on;
	public	$author;
	public 	$edit_on;
	public	$edit_by;
	public	$categorie_id;
	public 	$image;
	public 	$commentaire;
	public 	$visible;
	public 	$fichier;
	public 	$fichier_for;
	public 	$video;
	
	public function setAuthor($str){
		$this->author = $str;
	}
	
	public function setCreatOn( $time ){
		$this->creat_on = $time;
	}
	
	public function setEditBy($str){
		$this->edit_by = $str;
	}
	
	public function setEditOn( $time ){
		$this->edit_on = time();
	}
	
	public function isValid(){
		$error = '';
		
		if( empty($this->title) ):
			$error .= '<li>No title</li>';
		endif;
		
		if( empty($this->article) ):
			$error .= '<li>Article is empty !</li>';
		endif;
		
		if( empty($error) ){
			return True;
		}else{
			return $error;
		}
		
	}	

	public function save(){
		//$this->article = htmlspecialchars($this->article);
		return parent::save();
	}
	
}