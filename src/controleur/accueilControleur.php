<?php

function accueilControleur($twig){
    echo $twig->render("accueil.twig", array());
}

function aProposControleur($twig){
    echo $twig->render("aPropos.twig", array());
}


function mentionsLegalesControleur($twig){
    echo $twig->render("mentionsLegales.twig", array());
}

function maintenanceControleur($twig){
    echo $twig->render("maintenance.twig", array());
}

function administrationControleur($twig){
    echo $twig->render("administration.twig", array());
}

function rechercheControleur($twig){
    echo $twig->render("recherche.twig", array());
}

?>