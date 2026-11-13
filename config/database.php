<?php
$host='localhost'; $db='footzone_db'; $user='root'; $pass='';
try {
 $pdo=new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4",$user,$pass,[
  PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,
  PDO::ATTR_EMULATE_PREPARES=>false
 ]);
} catch(PDOException $e) { exit('Erreur MySQL : vérifiez config/database.php et importez le fichier SQL.'); }
