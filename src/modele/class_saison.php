<?php

class Saison {
    private $db;
    private $selectSaison;

    public function __construct($db){
        $this->db = $db;
        $this->selectSaison = $db->prepare("SELECT * FROM saison");
    }

    public function selectSaison(){
        $this->selectSaison->execute();
        if ($this->selectSaison->errorCode()!=0){
            print_r($this->selectSaison->errorInfo());
        }
        return $this->selectSaison->fetchAll();
    }
}

?>