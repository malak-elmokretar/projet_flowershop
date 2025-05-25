<?php

class Produit{
    private $db;
    private $insert;
    private $connect;
    private $select;
    private $selectById;
    private $update;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("CALL ajouterProduit(:p_nom, :p_description, :p_prix, :p_idType, :p_idSaison, :p_quantite, :p_descriptionPhotoAlt)");
        $this->select = $db->prepare("SELECT * FROM listerProduits");
        $this->selectById = $db->prepare("SELECT produit.id, nom, description, prix, type.libelle, taille, nomSaison, quantite, photo, descriptionPhotoAlt FROM produit LEFT JOIN type ON produit.idType = type.id LEFT JOIN saison ON produit.idSaison = saison.id WHERE produit.id = :idProduit");
        $this->update = $this->db->prepare("CALL modifierProduit(:p_nom, :p_description, :p_prix, :p_idType, :p_idSaison, :p_quantite, :p_descriptionPhotoAlt)");
        }

    public function insert($nom, $description, $prix, $idType, $idSaison, $quantite, $p_descriptionPhotoAlt){
        $r = true;
        $this->insert->execute(array(":p_nom"=>$nom, ":p_description"=>$description, ":p_prix"=>$prix, ":p_idType"=>$idType, ":p_idSaison"=>$idSaison, ":p_quantite" => $quantite, ":p_descriptionPhotoAlt" => $p_descriptionPhotoAlt));

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

    public function selectById($id){
        $this->selectById->execute(array(":idProduit"=>$id));
        if ($this->selectById->errorCode()!=0){
            print_r($this->selectById->errorInfo());
        }
        return $this->selectById->fetch();
    }

    public function update($nom, $description, $prix, $idType, $idSaison, $quantite, $p_descriptionPhotoAlt){
        $r = true;
        $this->update->execute(array(":p_nom"=>$nom, ":p_description"=>$description, ":p_prix"=>$prix, ":p_idType"=>$idType, ":p_idSaison" => $idSaison, ":p_quantite" => $quantite, ":p_descriptionPhotoAlt" => $p_descriptionPhotoAlt));
        if ($this->update->errorCode()!=0) {
            print_r($this->update->errorInfo());
            $r=false;
        }
        return $r;
    }
}
?>