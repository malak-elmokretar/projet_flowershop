<?php

class Produit {
    private $db;
    private $insert;
    private $select;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("CALL ajouter_produit (:nom, :description, :prix, :idType, :idSaison)");
        $this->select = $db->prepare("CALL lister_produits()");
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


    public function select(){
        $this->select->execute();
        if ($this->select->errorCode()!=0){
            print_r($this->select->errorInfo());
        }
        return $this->select->fetchAll();
    }
}
?>