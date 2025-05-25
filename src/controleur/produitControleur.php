<?php

function produitControleur($twig, $db){
    $form = array();
    $produit = new Produit($db);
    $liste = $produit->select();
    echo $twig->render("produit.html.twig", array("form"=>$form,"liste"=>$liste));
}

function ajoutProduitControleur($twig, $db) {
    $formAjoutProduit = array();
    if (isset($_POST["btnAjouterProduit"])) {
        $inputNom = $_POST["inputNomAjoutProduit"];
        $inputDescription = $_POST["inputDescriptionAjoutProduit"];
        $inputPrix = $_POST["inputPrixAjoutProduit"];
        $inputType = $_POST["type"];
        $inputSaison = $_POST["saison"];
        $inputQuantite = $_POST["inputQuantiteAjoutProduit"];
        $inputTexteAlternatif = $_POST["inputTexteAlternatifImageAjoutProduit"];
        $produit = new Produit($db);
        $exec = $produit->insert($inputNom, $inputDescription, $inputPrix, $inputType, $inputSaison, $inputQuantite, $inputTexteAlternatif);
            if (!$exec){
                $formInscription["valide"] = false;
                $formInscription["message"] = "Problème d'insertion dans la table utilisateur";
            }
    }
    echo $twig->render("ajoutProduit.twig", array("formAjoutProduit" => $formAjoutProduit));
}

function modifierProduitControleur($twig, $db) {
    $form = array();
    
    if (isset($_GET["id"])) {
        $produit = new Produit($db);
        $unProduit = $produit->selectByID($_GET["id"]);
        if ($unProduit != null){
            $form["produit"] = $unProduit;
            $saison = new Saison($db);
            $listeSaison = $saison->selectSaison();
            $form["saison"] = $listeSaison;
            $type = new Type($db);
            $listeType = $type->selectType();
            $form["type"] = $listeType;
        } else {
            $form["message"] = "Produit incorrect";
        }
    } elseif (isset($_POST["BtnModifierProduit"])) {
        $inputNom = $_POST["inputNomModifierProduit"];
        $inputDescription = $_POST["inputDescriptionModifierProduit"];
        $inputPrix = $_POST["inputPrixModifierProduit"];
        $inputType = $_POST["type"];
        $inputSaison = $_POST["saison"];
        $inputQuantite = $_POST["inputQuantiteModifierProduit"];
        $inputTexteAlternatif = $_POST["inputTexteAlternatifImageModifierProduit"];
        $produit = new Produit($db);
        $exec = $produit->update($idProduit, $inputDescription, $inputPrix, $inputType, $inputSaison, $inputQuantite, $inputTexteAlternatif);
        if (!$exec) {
            $form["valide"] = false;
            $form["message"] = "Échec de la modification";
        } else {
            $form["valide"] = true;
            $form["message"] = "Modification réussie";
        }
    } else {
        $form["message"] = "Produit non précisé";
    }

    echo $twig->render("modifierProduit.twig", array("form"=>$form));
}
?>