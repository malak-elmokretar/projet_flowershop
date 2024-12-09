<?php

function accueilControleur($twig){
    echo $twig->render('accueil.html.twig', array());
    // echo "Page d'accueil du site";
}

function aProposControleur($twig){
    // echo "À propos";
    echo $twig->render('aPropos.html.twig', array());
}

function contactControleur($twig){
    // echo "Contact";
    echo $twig->render('contact.html.twig', array());
}

function mentionsLegalesControleur($twig){
    // echo "Mentions légales";
    echo $twig->render('mentionsLegales.html.twig', array());
}


?>