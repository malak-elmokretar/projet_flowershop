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
        $unProduit = $produit->selectById($_GET["id"]);
        if ($unProduit != null){
            $form["produit"] = $unProduit;
            // $role = new Role($db);
            // $liste = $role->selectRole();
            // $form["roles"] = $liste;
        } else {
            $form["message"] = "Produit incorrect";
        }
    }
}
?>