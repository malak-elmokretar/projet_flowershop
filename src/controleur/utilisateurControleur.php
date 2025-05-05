<?php

function utilisateurControleur($twig, $db){
    $form = array();
    $utilisateur = new Utilisateur($db);
    $liste = $utilisateur->select();
    echo $twig->render('utilisateur.html.twig', array('form'=>$form,'liste'=>$liste));
}

function utilisateurModifControleur($twig, $db){
    $form = array(); if(isset($_GET['id'])){
        $utilisateur = new Utilisateur($db);
        $unUtilisateur = $utilisateur->selectById($_GET['id']); if ($unUtilisateur!=null){
            $form['utilisateur'] = $unUtilisateur;
            $role = new Role($db);
            $liste = $role->selectRole();
            $form['roles']=$liste;
        } else {
            $form['message'] = 'Utilisateur incorrect';
        }
    } else {
        if(isset($_POST['btModifier'])) {
            $utilisateur = new Utilisateur($db);
            $nom = $_POST['nom'];
            $prenom = $_POST['prenom'];
            $email = $_POST["inputEmailModification"];
            $role = $_POST['role'];
            $id = $_POST['id'];
            $exec=$utilisateur->update($id, $role, $nom, $prenom, $email);
            if(!$exec){
                $form['valide'] = false; 
                $form['message'] = 'Echec de la modification';
            } else {
                $form['valide'] = true;
                $form['message'] = 'Modification réussie';
            }
        } else {
            $form['message'] = 'Utilisateur non précisé';
        }
    }
    echo $twig->render('utilisateurModif.html.twig', array('form'=>$form));
}

?>