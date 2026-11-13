<?php require 'includes/functions.php';unset($_SESSION['user']);session_regenerate_id(true);flash('Déconnexion effectuée.');go('index.php');?>
