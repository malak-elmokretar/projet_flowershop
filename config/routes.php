<?php
require_once '../src/controleur/_controleurs.php';
// require_once './connexion.php';

function getPage($db){
    $lesPages['accueil'] = "accueilControleur"; 
    $lesPages['contact'] = "contactControleur";
    $lesPages['mentionsLegales'] = "mentionsLegalesControleur";
    $lesPages['aPropos'] = "aProposControleur";
    $lesPages['inscrire']="inscrireControleur";
    $lesPages['maintenance']="maintenanceControleur";

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