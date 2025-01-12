<?php
// require_once '../config/connexion.php';
$config['serveur']='192.168.56.102';
$config['login'] = 'malak';
$config['mdp'] ='S98-p[Phwf6pxRL(';
$config['bd'] = 'flowers';

function connect($config){ 
    try{
        $db = new PDO('mysql:host='.$config['serveur'].';dbname='.$config['bd'],$config['login'], $config['mdp']);
    }
    catch(Exception $e){
        $db = NULL;
    }
    return $db;
}
$db = connect($config);
$db->query("SELECT libelle FROM role WHERE id=0");
echo strval($db);