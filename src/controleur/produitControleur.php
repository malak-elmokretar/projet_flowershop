<?php

function produitControleur($twig, $db){
    $form = array();
    $produit = new Produit($db);
    $liste = $produit->select();
    echo $twig->render('produit.html.twig', array('form'=>$form,'liste'=>$liste));
}

?>