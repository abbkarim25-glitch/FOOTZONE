FOOTZONE — INSTALLATION XAMPP

1. Décompressez le dossier FOOTZONE dans C:\xampp\htdocs\
2. Démarrez Apache et MySQL dans XAMPP.
3. Ouvrez http://localhost/phpmyadmin
4. Importez database/footzone_database.sql
5. Vérifiez config/database.php (par défaut XAMPP : root, mot de passe vide).
6. Ouvrez http://localhost/FOOTZONE/

CRÉER UN ADMIN :
- Créez un compte normal via /register.php.
- Dans phpMyAdmin > footzone_db > SQL, exécutez :
  UPDATE users SET role='admin' WHERE email='votre-email@example.com';
- Reconnectez-vous. Le lien Admin sera visible.

INCLUS : accueil, catalogue, recherche, filtres catégorie/prix, tri, fiche produit,
inscription/connexion, panier en session, commande paiement livraison, historique,
admin produits/catégories/commandes/utilisateurs, PDO, requêtes préparées,
password_hash, sessions et jetons CSRF.

LIMITES DE LA VERSION MINI-PROJET :
- Panier stocké en session (tables carts/cart_items prévues dans MySQL).
- Contact en mode démonstration (pas d'envoi d'e-mail).
- Pas de paiement bancaire réel.
- Avis, favoris, variantes et multi-vendeurs non développés dans cette version.
- Les photos peuvent être placées dans assets/images et leur chemin saisi dans l'admin.
- Ce projet est pédagogique : des contrôles et tests supplémentaires sont nécessaires avant une mise en production.


PHOTOS DES PRODUITS (version complète)
- Huit photos JPG sont incluses dans assets/images/ (une par produit du catalogue).
- Si la base existe déjà : phpMyAdmin > footzone_db > SQL, exécuter
  database/ajouter_photos.sql puis database/ajouter_les_4_photos_manquantes.sql.
- Si vous créez la base pour la première fois : importer
  database/footzone_database.sql (les 8 associations de photos y sont incluses).
- Ensuite, actualiser le site avec Ctrl + F5.
- Les chemins d'images sont désormais construits depuis la racine du site,
  y compris dans les pages du dossier admin.
