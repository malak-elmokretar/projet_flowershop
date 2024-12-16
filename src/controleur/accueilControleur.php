<?php

function accueilControleur($twig){
    echo $twig->render('accueil.html.twig', array());
}

function aProposControleur($twig){
    echo $twig->render('aPropos.html.twig', array());
}

function contactControleur($twig){
    echo $twig->render('contact.html.twig', array());
}

function mentionsLegalesControleur($twig){
    echo $twig->render('mentionsLegales.html.twig', array());
}

function maintenanceControleur($twig){
    echo $twig->render('maintenance.html.twig', array());
}

?>