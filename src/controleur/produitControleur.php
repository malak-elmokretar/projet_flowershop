<?php

function produitControleur($twig, $db){
    $form = array();
    $produit = new Produit($db);
    $liste = $type->select();
    echo $twig->render('produits.html.twig', array('form'=>$form,'liste'=>$liste));
}

?>