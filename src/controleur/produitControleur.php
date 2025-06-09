<?php

function produitControleur($twig, $db){
    $form = array();
    $produit = new Produit($db);

    $limite=3;
    if(!isset($_GET['nopage'])){
        $inf=0;
        $nopage=0;
    }
    else{
        $nopage=$_GET['nopage'];
        $inf=$nopage * $limite;
    }
    $r = $produit->selectCount();
    $nb = $r['nb']; 

    if (isset($_POST['btnAjoutP'])) {
        if (isset($_POST['id'])) {
            $form['valideAjout']=true;
            $unProduit = $produit->selectById($_POST['id']);
            if (!$unProduit) {
                $form['valideAjout']=false;
                $form['message'] = "Le produit n'existe pas";
            } else {
                if (isset($_SESSION['panier']) && is_array($_SESSION['panier'])) {
                    if (array_key_exists($unProduit['id'], $_SESSION['panier'])) {
                        $_SESSION['panier'][$unProduit['id']] ++;
                    } else {
                        $_SESSION['panier'][$unProduit['id']] = 1;
                    }
                } else {
                    $_SESSION['panier'] = array($unProduit['id'] => 1);
                }
                $form['message'] = "Le produit a bien été ajouté";
            }
        } else {
            $form['valideAjout'] = false;
            $form['message'] = "Vous n'avez pas sélectionner de produit";
        }
    }
 
    $liste = $produit->selectLimit($inf, $limite);
    $form["nbpages"] = ceil($nb/$limite);
    $form["nopage"] = $nopage;
    echo $twig->render("produit.twig", array("form"=>$form,"liste"=>$liste));
}

function produitAdminControleur($twig, $db) {
    $form = array();
    $produit = new Produit($db);
    if (isset($_POST["btnSupprimer"])) {
        $cocher = $_POST["cocher"];
        $form["valide"] = true;
        foreach ($cocher as $id) {
            $exec = $produit->delete($id);
            if (!$exec) {
                $form['valide'] = false;
                $form['message'] = 'Problème de suppression dans la table produit';
            }
        }
        header("Location: index.php?page=produit&etat=".$etat);
        exit;
    }

    if (isset($_GET["id"])) {
        $exec = $produit->delete($_GET["id"]);
        if (!$exec) {
            $form['valide'] = false;
            $form['message'] = 'Problème de suppression dans la table produit'; 
        } else {
            $form['valide'] = true;
            $form['message'] = 'Produit supprimé avec succès';
        }
        header("Location: index.php?page=produit&etat=".$etat);
        exit;
    }

    $limite=3;
    if(!isset($_GET['nopage'])){
        $inf=0;
        $nopage=0;
    }
    else{
        $nopage=$_GET['nopage'];
        $inf=$nopage * $limite;
    }
    $r = $produit->selectCount();
    $nb = $r['nb']; 
 
    $liste = $produit->selectLimit($inf, $limite);
    $form["nbpages"] = ceil($nb/$limite);
    $form["nopage"] = $nopage;

    echo $twig->render("produitAdmin.twig", array("form"=>$form,"liste"=>$liste));
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
        $upload = new Upload(array('png', 'gif', 'jpg', 'jpeg'), 'images', 500000);
        $photo = $upload->enregistrer('inputImageAjoutProduit');
        $inputTexteAlternatif = $_POST["inputTexteAlternatifImageAjoutProduit"];
        $produit = new Produit($db);
        $exec = $produit->insert($inputNom, $inputDescription, $inputPrix, $inputType, $inputSaison, $inputQuantite, $photo["nom"], $inputTexteAlternatif);
            if (!$exec){
                $formInscription["valide"] = false;
                $formInscription["message"] = "Problème d'insertion dans la table produit";
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
        $idProduit = $_POST["id"];
        $produit = new Produit($db);
        $exec = $produit->update($idProduit, $inputNom, $inputDescription, $inputPrix, $inputType, $inputSaison, $inputQuantite, $inputTexteAlternatif);
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

function produitFicheControleur($twig, $db) {
    if (isset($_POST['btAjoutP'])) {
        if (isset($_POST['id'])) {
            $form['valideAjout']=true;
            $unProduit = $produit->selectById($_POST['id']);
            if (!$unProduit) {
                $form['valideAjout']=false;
                $form['message'] = "Le produit n'existe pas";
            } else {
                if (isset($_SESSION['panier']) && is_array($_SESSION['panier'])) {
                    if (array_key_exists($unProduit['id'], $_SESSION['panier'])) {
                        $_SESSION['panier'][$unProduit['id']] ++;
                    } else {
                        $_SESSION['panier'][$unProduit['id']] = 1;
                    }
                } else {
                    $_SESSION['panier'] = array($unProduit['id'] => 1);
                }
                $form['message'] = "Le produit a bien été ajouté";
            }
        } else {
            $form['valideAjout'] = false;
            $form['message'] = "Vous n'avez pas sélectionner de produit";
        }
    }
    echo $twig->render("produitFiche.twig", array(
        // "form"=>$form
    ));
}

?>