-- FOOTZONE : corriger/ajouter les photos de démonstration sans créer de doublons.
-- À exécuter dans phpMyAdmin > base footzone_db > onglet SQL.
-- Les anciennes images de ces 4 produits sont remplacées proprement.

DELETE pi
FROM product_images AS pi
INNER JOIN products AS p ON p.id = pi.product_id
WHERE p.slug IN (
    'chaussures-speed-pro',
    'maillot-football-classic',
    'ballon-match-elite',
    'gants-keeper-grip'
);

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/chaussures.jpg', 1, 0
FROM products WHERE slug = 'chaussures-speed-pro';

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/maillot.jpg', 1, 0
FROM products WHERE slug = 'maillot-football-classic';

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/ballon.jpg', 1, 0
FROM products WHERE slug = 'ballon-match-elite';

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/gants.jpg', 1, 0
FROM products WHERE slug = 'gants-keeper-grip';

-- Vérification : chaque produit ci-dessus doit avoir exactement une photo principale.
SELECT p.name, pi.image_path, pi.is_main
FROM products AS p
LEFT JOIN product_images AS pi ON pi.product_id = p.id AND pi.is_main = 1
WHERE p.slug IN (
    'chaussures-speed-pro',
    'maillot-football-classic',
    'ballon-match-elite',
    'gants-keeper-grip'
)
ORDER BY p.id;
