<?php

function inscrireControleur($twig, $db){
    $formInscription = array();
    if (isset($_POST['btInscrire'])){
        $inputEmail = $_POST['inputEmailInscription'];
        $inputPassword = $_POST['inputPasswordInscription'];
        $inputPassword2 =$_POST['inputPassword2Inscription'];
        $nom = $_POST['nom'];
        $prenom = $_POST['prenom'];
        $role = $_POST['role'];
        $formInscription['valide']= true;
        if ($inputPassword!=$inputPassword2){
            $formInscription['valide'] = false; 
            $formInscription['message'] = 'Les mots de passe sont différents';
        } else {
            $utilisateur = new Utilisateur($db);
            $exec = $utilisateur->insert($inputEmail, password_hash($inputPassword, PASSWORD_DEFAULT), $role, $nom, $prenom);
            if (!$exec){
                $formInscription['valide'] = false;
                $formInscription['message'] = "Problème d'insertion dans la table utilisateur";
            }
        }
        $formInscription['emailInscription']= $inputEmail;
        $formInscription['roleInscription']= $role;
    }
    echo $twig->render('inscrire.html.twig', array('formInscription'=>$formInscription));
}

?>