<?php

class Utilisateur{
    private $db;
    private $insert;
    private $connect;
    private $select;
    private $selectByID;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("CALL inscription (:email, :mdp, :nom, :prenom, :role)");
        $this->connect = $this->db->prepare("CALL connexion (:email)");
        $this->select = $db->prepare("CALL lister_utilisateurs()");
        $this->selectByID = $db->prepare("CALL lister_utilisateurs_par_id(:idUtilisateur)");
    }

    public function insert($email, $mdp, $role, $nom, $prenom){
        $r = true;
        $this->insert->execute(array(':email'=>$email, ':mdp'=>$mdp, ':role'=>$role, ':nom'=>$nom, ':prenom'=>$prenom));

        if ($this->insert->errorCode()!=0){
            print_r($this->insert->errorInfo());
            $r=false;
        }
        return $r;
    }

    public function connect($email){
        $unUtilisateur = $this->connect->execute(array(':email'=>$email));
        if ($this->connect->errorCode()!=0){
            print_r($this->connect->errorInfo());
        }
        return $this->connect->fetch();
    }

    public function select(){
        $this->select->execute();
        if ($this->select->errorCode()!=0){
            print_r($this->select->errorInfo());
        }
        return $this->select->fetchAll();
    }

    public function selectByID($idUtilisateur){
        $this->selectByID->execute(array(":idUtilisateur" => $idUtilisateur));
        if ($this->selectByID->errorCode()!=0){
            print_r($this->selectByID->errorInfo());
        }
        return $this->selectByID->fetch();
    }
}
?>