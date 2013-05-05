<?php

class EPO extends PDO{

    public $num_queries = 0;	

    public function __construct($dsn, $username = null, $password = null, array $driver_options = array()){
		
        parent::__construct($dsn, $username, $password, $driver_options);
        parent::setAttribute(PDO::ATTR_STATEMENT_CLASS, array('EPOStatement', array($this)));
		
    }

    public function exec($statement){
        $this->num_queries++;
        return parent::exec($statement);
    }

    public function query($statement){
        $this->num_queries++;
        return parent::query($statement);
    }	
}

class EPOStatement extends PDOStatement{
    protected $epo;

    protected function __construct(EPO $epo){
        $this->epo = $epo;
    }

    public function execute($input_parameters = null){
        $this->epo->num_queries++;
        return parent::execute($input_parameters);
    }
}