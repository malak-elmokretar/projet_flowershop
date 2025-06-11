<?php

class Contact{
    private $db;
    private $insert;
    private $select;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("CALL contacterAdmin(:objet, :nom, :prenom, :email, :telephone, :message)");
        $this->select = $this->db->prepare("CALL listerMessages()");
    }

    public function insert($objet, $nom, $prenom, $email, $telephone, $message){
        $r = true;
        $this->insert->execute(array(":objet" => $objet, ":email" => $email, ":nom" => $nom, ":prenom" => $prenom, ":email" => $email, ":telephone" => $telephone, ":message" => $message));
        if ($this -> insert -> errorCode() != 0){
            print_r($this->insert->errorInfo());
            $r=false;
        }
        return $r;
    }

    public function select(){
        $this->select->execute();
        if ($this -> select -> errorCode() != 0){
            print_r($this->select->errorInfo());
        }
        return $this->select->fetchAll();
    }
}

?>