<?php

function verifierMdp($mdp) {
    $nbMajuscules = 0;
    $nbMinuscules = 0;
    $nbChiffres = 0;
    $nbCaracteresSpeciaux = 0;

    for ($i = 0; $i < strlen($mdp); $i++) {
        $c = $mdp[$i];
        if (ctype_upper($c)) {
            $nbMajuscules++;
        } elseif (ctype_lower($c)) {
            $nbMinuscules++;
        } elseif (ctype_digit($c)) {
            $nbChiffres++;
        } elseif ((ord($c) >= 33 && ord($c) <= 46) || ord($c) == 64) {
            $nbCaracteresSpeciaux++;
        }
    }

    return strlen($mdp) >= 12 && $nbMajuscules >= 1 && $nbMinuscules >= 3 && $nbChiffres >= 4 && $nbCaracteresSpeciaux >= 1;
}

function inscrireControleur($twig, $db){
    $formInscription = array();
    if (isset($_POST["btInscrire"])){
        $inputEmail = $_POST["inputEmailInscription"];
        $inputPassword = $_POST["inputPasswordInscription"];
        $inputPassword2 =$_POST["inputPassword2Inscription"];
        $nom = $_POST["nom"];
        $prenom = $_POST["prenom"];
        $role = $_POST["role"];
        $formInscription["valide"]= true;

        if ($inputPassword != $inputPassword2){
            $formInscription["valide"] = false;
            $formInscription["message"] = "Les mots de passe sont différents";
        } elseif (!verifierMdp($inputPassword)) {
            $formInscription["valide"] = false;
            $formInscription["message"] = "Le mot de passe n'est pas assez complexe. Il doit contenir au moins 12 caractères, 1 majuscule, 3 minuscules, 4 chiffres et 1 caractère spécial.";
        } else {
            $utilisateur = new Utilisateur($db);
            $exec = $utilisateur->insert($inputEmail, password_hash($inputPassword, PASSWORD_DEFAULT), $role, $nom, $prenom);
            if (!$exec){
                $formInscription["valide"] = false;
                $formInscription["message"] = "Problème d'insertion dans la table utilisateur";
            }
        }

        $formInscription["emailInscription"] = $inputEmail;
        $formInscription["roleInscription"] = $role;
    }

    echo $twig->render("inscrire.html.twig", array("formInscription"=>$formInscription));
}

?>