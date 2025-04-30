<?php

class Utilisateur{
    private $db;
    private $insert;
    private $connect;
    private $select;
    private $selectById;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("CALL inscription (:email, :mdp, :nom, :prenom, :role)");
        $this->connect = $this->db->prepare("CALL connexion (:email)");
        $this->select = $db->prepare("CALL lister_utilisateurs()");
        $this->selectById = $db->prepare("SELECT idUtilisateur, email, nom, prenom, idRole FROM utilisateur WHERE idUtilisateur=:idUtilisateur ORDER BY idUtilisateur");
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

    public function selectById($id){
        $this->selectById->execute(array(':idUtilisateur'=>$id));
        if ($this->selectById->errorCode()!=0){
            print_r($this->selectById->errorInfo());
        }
        return $this->selectById->fetch();
    }
}

// interblocage
// algo de marge stable
?>
