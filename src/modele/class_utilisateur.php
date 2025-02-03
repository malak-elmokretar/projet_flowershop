<?php

class Utilisateur{
    private $db;
    private $insert;
    private $connect;
    private $select;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("INSERT INTO utilisateur(email, mdp, nom, prenom, idRole) VALUES (:email, :mdp, :nom, :prenom, :role)");
        $this->connect = $this->db->prepare("SELECT email, idRole, mdp FROM utilisateur WHERE email=:email");
        $this->select = $db->prepare("SELECT utilisateur.id, email, idRole, nom, prenom, libelle FROM utilisateur JOIN role ON utilisateur.idRole = role.id WHERE idRole = role.id ORDER BY nom");
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
}
?>