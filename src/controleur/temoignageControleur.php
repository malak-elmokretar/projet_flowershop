<?php

function temoignageControleur($twig, $db){
     $formTemoignage = array();
     if (isset($_POST["btnTemoignage"])){
        $inputEmail = $_POST["inputEmailTemoignage"];
        $inputPassword = $_POST["inputPasswordTemoignage"];
        $inputPassword2 =$_POST["inputPassword2Temoignage"];
        $nom = $_POST["nom"];
        $prenom = $_POST["prenom"];
        $role = $_POST["role"];
        $formTemoignage["valide"]= true;
        $temoignage = new Temoignage($db);
            $exec = $utilisateur->insert($inputEmail, password_hash($inputPassword, PASSWORD_DEFAULT), $role, $nom, $prenom);
            if (!$exec){
                $formInscription["valide"] = false;
                $formInscription["message"] = "Problème d'insertion dans la table utilisateur";
            }

        $formInscription["emailInscription"] = $inputEmail;
        $formInscription["roleInscription"] = $role;
    }

    echo $twig->render("inscrire.twig", array("formInscription"=>$formInscription));
}