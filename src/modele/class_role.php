<?php

class Role {
    private $db, $selectRole;

    public function __construct($db){
        $this->db = $db;
        $this->selectRole = $db->prepare("SELECT * FROM listerRoles");
    }

    public function selectRole(){
        $this->selectRole->execute();
        if ($this->selectRole->errorCode()!=0){
            print_r($this->selectRole->errorInfo());
        }
        return $this->selectRole->fetchAll();
    }
}

?>