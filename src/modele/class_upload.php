<?php

class Upload {
    private $extensions, $chemin, $taille;

    public function __construct($extensions, $chemin, $taille){ 
        $this->extensions = $extensions;
        $this->chemin = $chemin;
        $this->taille = $taille;
    }

    public function enregistrer($data){ 
        $fichier = array(); 
        $fichier['nom'] = null;
        $fichier['erreur'] = null;

        if(isset($_FILES[$data])){
            if(!empty($_FILES[$data]['name'])){
                $extension = strtolower(pathinfo($_FILES[$data]['name'], PATHINFO_EXTENSION));
                if(!in_array($extension, $this->extensions)) {
                    $fichier['erreur'] = 'Veuillez sélectionner un fichier de type : ' . implode(', ', $this->extensions);
                } else {
                    if($_FILES[$data]['size'] > $this->taille){
                        $fichier['erreur'] = 'Votre fichier doit faire moins de '.($this->taille / 1000).'Ko !';
                    } else {
                        $nom = basename($_FILES[$data]['name']);
                        $nom = strtr($nom,'ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöùúûüýÿ',
                                            'AAAAAACEEEEIIIIOOOOOUUUUYaaaaaaceeeeiiiioooooouuuuyy');
                        $nom = preg_replace('/([^.a-z0-9]+)/i', '_', $nom);
                        $nom = uniqid() . '_' . $nom;
                        if(move_uploaded_file($_FILES[$data]['tmp_name'], $this->chemin . '/' . $nom)){
                            $fichier['nom'] = $nom;
                        } else {
                            $fichier['erreur'] = "Erreur lors de l'upload du fichier.";
                        }
                    }
                }
            } else {
                $fichier['erreur'] = "Aucun fichier sélectionné.";
            }
        } else {
            $fichier['erreur'] = "Fichier non envoyé.";
        }

        return $fichier;
    }
}
?>