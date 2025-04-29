<?php
// require_once '../config/connexion.php';
$config['serveur']='10.50.0.9';
$config['login'] = 'malak';
$config['mdp'] ='S98-p[Phwf6pxRL(';
$config['bd'] = 'flowers';

try{
    $db = new PDO('mysql:host='.$config['serveur'].';dbname='.$config['bd'],$config['login'], $config['mdp']);
}
catch(Exception $e){
    echo $e;
}
echo"coucou";
//$db = connect($config);
//$db->query("SELECT libelle FROM role WHERE id=0");
//echo strval($db);