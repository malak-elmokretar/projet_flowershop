<?php

class Produit{
    private $db;
    private $insert;
    private $connect;
    private $select;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("CALL ajouter_produit(:p_nom, :p_description, :p_prix, :p_libelle, :p_idSaison)");
        $this->select = $db->prepare("CALL lister_produits()");
    }

    public function insert($nom, $description, $prix, $idType, $idSaison){
        $r = true;
        $this->insert->execute(array(':p_nom'=>$nom, ':p_description'=>$description, ':p_prix'=>$prix, ':p_libelle'=>$libelle, ':p_nom_saison'=>$nom_saison));

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

