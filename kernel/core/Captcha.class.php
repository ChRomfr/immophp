<?php
class Captcha
{
    # Nombre de chiffre sur l image
    var $nb_chiffre = 6;
    # Chiffre Genere
    var  $chiffre_gen = array();
    # 
    var $nombre = '';
    
    public function create()
    {
        $this->generate_key();
        $this->verification_key();
        $this->stock_in_session(); 
    }
    
    private function generate_key()
    {
        $i = 0;
		$this->chiffre_gen[0] = '';
		$this->chiffre_gen[1] = '';
		$this->chiffre_gen[2] = '';
		$this->chiffre_gen[3] = '';
		$this->chiffre_gen[4] = '';
		$this->chiffre_gen[5] = '';
		$this->chiffre_gen[6] = '';
		$this->chiffre_gen[7] = '';
		$this->chiffre_gen[8] = '';
        while($i < $this->nb_chiffre)
        {
            $c = mt_rand(0, 9);
            $this->chiffre_gen[$i] .= $c;
            $i++;
        }    
    }
    
    private function verification_key ()
    {
        foreach ($this->chiffre_gen as $value)
        {
            $this->nombre .= $value;
        }   
    }
    
    private function stock_in_session(){
        $_SESSION['captcha_code'] = md5($this->nombre);
    }
    
	/**
	*	Verifie si le CAPTCHA soumis est bon
	*	@return bool
	*/
    static public function verif_captcha($captcha)
    {
        if(md5($captcha) == $_SESSION['captcha_code'])
        {
            unset ($_SESSION['captcha_code']);
            return true;
        }
        else
            return false;
    }    
}
?>