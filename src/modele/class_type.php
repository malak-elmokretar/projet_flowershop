<?php

class Type {
    private $db, $selectType;

    public function __construct($db){
        $this->db = $db;
        $this->selectType = $db->prepare("SELECT * FROM listerType");
    }

    public function selectType(){
        $this->selectType->execute();
        if ($this->selectType->errorCode()!=0){
            print_r($this->selectType->errorInfo());
        }
        return $this->selectType->fetchAll();
    }
}

?>