<?php

class Produit{
    private $db;
    private $insert;
    private $select;
    private $selectById;
    private $update;
    private $delete;
    private $selectLimit;
    private $selectCount;

    public function __construct($db){
        $this->db = $db;
        $this->insert = $this->db->prepare("INSERT INTO produit (nom, description, prix, idType, idSaison, quantite, photo, descriptionPhotoAlt) VALUES (:p_nom, :p_description, :p_prix, :p_idType, :p_idSaison, :p_quantite, :p_photo, :p_descriptionPhotoAlt)");
        $this->select = $db->prepare("SELECT * FROM listerProduits");
        $this->selectById = $db->prepare("SELECT produit.id, nom, description, prix, type.libelle, taille, nomSaison, quantite, photo, descriptionPhotoAlt FROM produit LEFT JOIN type ON produit.idType = type.id LEFT JOIN saison ON produit.idSaison = saison.id WHERE produit.id = :idProduit");
        $this->update = $db->prepare("CALL modifierProduit(:p_id, :p_nom, :p_description, :p_prix, :p_idType, :p_idSaison, :p_quantite, :p_descriptionPhotoAlt)");
        $this->delete = $db->prepare("DELETE FROM produit WHERE id=:id");
        $this->selectLimit = $db->prepare("SELECT * FROM produit ORDER BY nom LIMIT :inf, :limite");
        $this->selectCount =$db->prepare("SELECT COUNT(*) AS nb FROM produit"); 
    }

    public function insert($nom, $description, $prix, $idType, $idSaison, $quantite, $photo, $p_descriptionPhotoAlt){
        $r = true;
        $this->insert->execute(array(":p_nom"=>$nom, ":p_description"=>$description, ":p_prix"=>$prix, ":p_idType"=>$idType, ":p_idSaison"=>$idSaison, ":p_quantite" => $quantite, ":p_photo"=>$photo, ":p_descriptionPhotoAlt" => $p_descriptionPhotoAlt));

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

    public function update($idProduit, $nom, $description, $prix, $idType, $idSaison, $quantite, $p_descriptionPhotoAlt){
        $r = true;
        $this->update->execute(array(":p_id"=>$idProduit, ":p_nom"=>$nom, ":p_description"=>$description, ":p_prix"=>$prix, ":p_idType"=>$idType, ":p_idSaison" => $idSaison, ":p_quantite" => $quantite, ":p_descriptionPhotoAlt" => $p_descriptionPhotoAlt));
        if ($this->update->errorCode()!=0) {
            print_r($this->update->errorInfo());
            $r=false;
        }
        return $r;
    }

    public function delete($id){
        $r = true;
        $this->delete->execute(array(":id" => $id));
        if ($this->delete->errorCode()!=0){
            print_r($this->delete->errorInfo());
        }
        return $r;
    }

    public function selectLimit($inf, $limite){ 
        $this->selectLimit->bindParam(':inf', $inf, PDO::PARAM_INT);
        $this->selectLimit->bindParam(':limite', $limite, PDO::PARAM_INT);
        $this->selectLimit->execute();
        if ($this->selectLimit->errorCode()!=0){
            print_r($this->selectLimit->errorInfo());
        }
        return $this->selectLimit->fetchAll();
    } 

    public function selectCount(){
        $this->selectCount->execute();
        if ($this->selectCount->errorCode()!=0){
            print_r($this->selectCount->errorInfo());
        }
        return $this->selectCount->fetch();
    }
}
?>