<?php
require_once "../src/controleur/_controleurs.php";

function getPage($db) {
    $lesPages["accueil"] = "accueilControleur;0";
    $lesPages["administration"] = "administrationControleur;1";
    $lesPages["ajoutProduit"] = "ajoutProduitControleur;1";
    $lesPages["aPropos"] = "aProposControleur;0";
    $lesPages["contact"] = "contactControleur;0";
    $lesPages["connexion"] = "connexionControleur;0";
    $lesPages["deconnexion"] = "deconnexionControleur;0";
    $lesPages["inscription"] = "inscrireControleur;0";
    $lesPages["maintenance"] = "maintenanceControleur;0";
    $lesPages["mentionsLegales"] = "mentionsLegalesControleur;0";
    $lesPages["produit"] = "produitControleur;0";
    $lesPages["modifierProduit"] = "modifierProduitControleur;1";
    $lesPages["utilisateur"] = "utilisateurControleur;1";
    $lesPages["utilisateurModif"] = "utilisateurModifControleur;1";
    $lesPages["recherche"] = "rechercheControleur;0";
    $lesPages["produitFiche"] = "produitFicheControleur;0";
    $lesPages["produitAdmin"] = "produitAdminControleur;1";
    $lesPages["panier"] = "panierControleur;0";

    if ($db!=null) {
        if (isset($_GET['page'])) {
            $page = $_GET['page'];
        } else {
            $page = 'accueil';
        }
        if (!isset($lesPages[$page])) {
            $page = 'accueil';
        }
        $explose = explode(";",$lesPages[$page]);
        $role = $explose[1];
        if ($role != 0) {
            if (isset($_SESSION['login'])) {
                if (isset($_SESSION['role'])) {
                    if ($role!=$_SESSION['role']) {
                        $contenu = 'accueilControleur';
                    } else {
                        $contenu = $explose[0];
                    }
                } else {
                    $contenu = 'accueilControleur';
                }
            } else {
                $contenu = 'accueilControleur';
            } 
        } else { 
            $contenu = $explose[0];
        } 
    } else { 
        $contenu = $lesPages['maintenance']; 
    } 
    return $contenu; 
} 

?>