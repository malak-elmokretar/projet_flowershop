<?php

class Produit{
    private $db;
    private $insert;
    private $connect;
    private $select;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("INSERT INTO produit (nom, description, prix, idType, idSaison) VALUES (:nom, :description, :prix, :idType, :idSaison)");
        // $this->connect = $this->db->prepare("SELECT email, idRole, mdp FROM produit WHERE email=:email");
        $this->select = $db->prepare("SELECT produit.id, produit.nom, description, prix, idType, idSaison FROM produit JOIN saison ON produit.idSaison = saison.id JOIN type ON produit.idType = type.id WHERE produit.idSaison = saison.id AND produit.idType = type.id ORDER BY saison.nom");
    }

    public function insert($email, $mdp, $role, $nom, $prenom){
        $r = true;
        $this->insert->execute(array(':nom'=>$nom, ':description'=>$description, ':prix'=>$prix, ':nom'=>$nom, ':prenom'=>$prenom));

        if ($this->insert->errorCode()!=0){
            print_r($this->insert->errorInfo());
            $r=false;
        }
        return $r;
    }

    // public function connect($email){
    //     $unProduit = $this->connect->execute(array(':email'=>$email));
    //     if ($this->connect->errorCode()!=0){
    //         print_r($this->connect->errorInfo());
    //     }
    //     return $this->connect->fetch();
    // }

    public function select(){
        $this->select->execute();
        if ($this->select->errorCode()!=0){
            print_r($this->select->errorInfo());
        }
        return $this->select->fetchAll();
    }
}
?>