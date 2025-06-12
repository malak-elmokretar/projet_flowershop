<?php

class Composer{
    private $db, $insert;

    public function __construct() {
        $this->insert = $this->db->prepare("CALL AjouterCompositionPanier(':idCommande',':idProduit',':quantite')");
    }

    public function insert($idCommande, $idProduit, $quantite) {
        $r = true;
        $this->insert->execute(array(":idCommande"=>$idCommande, ":idProduit"=>$idProduit, ":quantite"=>$quantite));

        if ($this->insert->errorCode()!=0){
            print_r($this->insert->errorInfo());
            $r=false;
        }
        return $r;
    }
}



?>