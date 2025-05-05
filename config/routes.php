<?php
require_once '../src/controleur/_controleurs.php';

function getPage($db){
    $lesPages['accueil'] = "accueilControleur";
    $lesPages["administration"] = "administrationControleur";
    $lesPages['aPropos'] = "aProposControleur";
    $lesPages['contact'] = "contactControleur";
    $lesPages['connexion'] = "connexionControleur";
    $lesPages['deconnexion'] = "deconnexionControleur";
    $lesPages['inscription'] = "inscrireControleur";
    $lesPages['maintenance'] = "maintenanceControleur";
    $lesPages['mentionsLegales'] = "mentionsLegalesControleur";
    $lesPages['produit'] = "produitControleur";
    $lesPages['utilisateur'] = "utilisateurControleur";
    $lesPages['utilisateurModif'] = "utilisateurModifControleur";

    if ($db!=null) {
        if(isset($_GET['page'])){
            $page = $_GET['page']; 
        } else{
            $page = 'accueil';
        }
        if (!isset($lesPages[$page])){
            $page = 'accueil';
        }
        $contenu = $lesPages[$page];
    }
    else{
        $contenu = $lesPages['maintenance'];
    }
    return $contenu;
}

?>