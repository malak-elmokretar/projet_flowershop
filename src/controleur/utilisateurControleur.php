<?php

function utilisateurControleur($twig, $db){
    $form = array();
    $utilisateur = new Utilisateur($db);
    $liste = $utilisateur->select();
    echo $twig->render('utilisateur.html.twig', array('form'=>$form,'liste'=>$liste));
}

function utilisateurModifControleur($twig, $db) {
     $form = array(); if(isset($_GET['id'])){
        $utilisateur = new Utilisateur($db);
        $unUtilisateur = $utilisateur->selectById($_GET['id']);
        if ($unUtilisateur!=null){
            $form['utilisateur'] = $unUtilisateur;
        } else {
            $form['message'] = 'Utilisateur incorrect';
        }
    } else {
        $form['message'] = 'Utilisateur non précisé';
    }
    echo $twig->render('utilisateurModif.html.twig', array('form'=>$form));
}

?>