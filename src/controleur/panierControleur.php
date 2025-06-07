<?php

function panierControleur($twig,$db){
  $form = array();
  $liste = array();
  if (!empty($_SESSION['panier'])) {
    $ids = array_keys($_SESSION['panier']);
    $produits = new Produit($db);
    $liste = $produits->selectIn($ids); 
  }
  echo $twig->render('panier.twig', array('form'=>$form,'liste'=>$liste));
} 

?>