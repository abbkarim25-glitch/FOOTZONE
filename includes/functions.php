<?php
if(session_status()===PHP_SESSION_NONE) session_start();
require_once __DIR__.'/../config/database.php';
function e($v){return htmlspecialchars((string)($v??''),ENT_QUOTES,'UTF-8');}
function money($v){return number_format((float)$v,3,',',' ').' TND';}
function go($url){header('Location: '.$url);exit;}
function flash($m,$type='success'){$_SESSION['flash']=['m'=>$m,'t'=>$type];}
function csrf(){if(empty($_SESSION['csrf']))$_SESSION['csrf']=bin2hex(random_bytes(32));return $_SESSION['csrf'];}
function check_csrf(){if(!hash_equals(csrf(),$_POST['csrf']??'')){http_response_code(419);exit('Formulaire expiré. Rechargez la page.');}}
function logged(){return isset($_SESSION['user']);}
function admin(){return logged()&&($_SESSION['user']['role']==='admin');}
function need_login(){if(!logged()){flash('Connectez-vous pour continuer.','warning');go('login.php');}}
function need_admin(){if(!admin()){flash('Accès administrateur requis.','danger');go('../login.php');}}
function cart_count(){return array_sum($_SESSION['cart']??[]);}
// Construit un chemin d'image absolu depuis la racine du projet.
// Cela évite les chemins cassés, notamment depuis les pages du dossier /admin.
$scriptDir = str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '/FOOTZONE/index.php'));
if (basename($scriptDir) === 'admin') {
    $scriptDir = dirname($scriptDir);
}
if (!defined('FOOTZONE_BASE_URL')) {
    define('FOOTZONE_BASE_URL', rtrim($scriptDir, '/'));
}
function img($p) {
    $path = trim((string)($p['image_path'] ?? ''));
    if ($path === '') {
        $path = 'assets/images/placeholder.svg';
    }
    // Autorise aussi les URL externes si l'administrateur en ajoute une.
    if (preg_match('~^(https?://|data:)~i', $path)) {
        return $path;
    }
    return FOOTZONE_BASE_URL . '/' . ltrim($path, '/');
}
