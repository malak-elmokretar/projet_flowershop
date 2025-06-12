<?php

class Occasion {
    private $db, $selectOccasion;

    public function __construct($db){
        $this->db = $db;
        $this->selectOccasion = $db->prepare("SELECT * FROM listerOccasion");
    }

    public function selectOccasion(){
        $this->selectOccasion->execute();
        if ($this->selectOccasion->errorCode()!=0){
            print_r($this->selectOccasion->errorInfo());
        }
        return $this->selectOccasion->fetchAll();
    }
}

?>