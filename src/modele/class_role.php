<?php

class Role{
    private $db;
    private $select;

    public function __construct($db){
        $this->db = $db;
        $this->select = $db->prepare("SELECT id, libelle FROM ROLE;");
    }
}

?>