<?php

function utilisateurControleur($twig, $db){
    $form = array();
    $utilisateur = new Utilisateur($db);
    $liste = $utilisateur->select();
    echo $twig->render("utilisateur.html.twig", array("form"=>$form,"liste"=>$liste));
}

function utilisateurModifControleur($twig, $db){
    $form = array();

    if(isset($_GET["id"])){
        $utilisateur = new Utilisateur($db);
        $unUtilisateur = $utilisateur->selectById($_GET["id"]);
        if ($unUtilisateur != null){
            $form["utilisateur"] = $unUtilisateur;
            $role = new Role($db);
            $liste = $role->selectRole();
            $form["roles"] = $liste;
        } else {
            $form["message"] = "Utilisateur incorrect";
        }

    } elseif(isset($_POST["btModifier"])) {
        $utilisateur = new Utilisateur($db);
        $nom = $_POST["nom"];
        $prenom = $_POST["prenom"];
        $email = $_POST["inputEmailModification"];
        $role = $_POST["role"];
        $id = $_POST["id"];
        $mdp = $_POST["inputPasswordModification"];
        $mdp2 = $_POST["inputPassword2Modification"];
        if (!empty($mdp) || !empty($mdp2)) {
            if ($mdp !== $mdp2) {
                $form["valide"] = false;
                $form["message"] = "Les mots de passe sont différents";
                echo $twig->render("utilisateurModif.html.twig", array("form"=>$form));
                return;
            } else {
                $utilisateur->updateMDP($id, password_hash($mdp, PASSWORD_DEFAULT));
            }
        }
        $exec = $utilisateur->update($id, $role, $nom, $prenom, $email);
        if (!$exec) {
            $form["valide"] = false;
            $form["message"] = "Échec de la modification";
        } else {
            $form["valide"] = true;
            $form["message"] = "Modification réussie";
        }

    } else {
        $form["message"] = "Utilisateur non précisé";
    }
    echo $twig->render("utilisateurModif.html.twig", array("form"=>$form));
}


?>