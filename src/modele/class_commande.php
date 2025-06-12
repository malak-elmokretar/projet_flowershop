<?php

class Commande{
    private $db, $insert, $selectByDateClient;

    public function __construct() {
        $this->insert = $this->db->prepare("CALL creerCommande(:idCommande,:idProduit,:quantite)");
        $this->selectByDateClient = $db->prepare("CALL ListerCommandesParDateClient (:p_idUtilisateur, :p_dateCommande");
    }

    public function insert($idCommande, $idProduit, $quantite){
        $r = true;
        $this->insert->execute(array(":idCommande"=>$idCommande, ":idProduit"=>$idProduit, ":quantite"=>$quantite));

        if ($this->insert->errorCode()!=0){
            print_r($this->insert->errorInfo());
            $r=false;
        }
        return $r;
    }

    public function selectByDateClient($idUtilisateur, $dateCommande) {
        $this->selectByDateClient->execute(array(":p_idUtilisateur"=>$idUtilisateur, ":p_dateCommande" => $dateCommande));
        if ($this->selectByDateClient->errorCode()!=0){
            print_r($this->selectByDateClient->errorInfo());
        }
        return $this->selectByDateClient->fetch();
    }
}