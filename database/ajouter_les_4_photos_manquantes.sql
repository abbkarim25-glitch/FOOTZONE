-- FOOTZONE : ajouter les photos aux 4 produits qui n'en avaient pas.
-- Importer ce fichier dans phpMyAdmin > base footzone_db > onglet SQL.
-- Les fichiers JPG correspondants sont dans assets/images/.

DELETE pi
FROM product_images AS pi
INNER JOIN products AS p ON p.id = pi.product_id
WHERE p.slug IN (
    'protege-tibias-flex',
    'sac-sport-football',
    'kit-entrainement-20-cones',
    'chaussettes-football'
);

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/protege-tibias.jpg', 1, 0
FROM products WHERE slug = 'protege-tibias-flex';

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/sac.jpg', 1, 0
FROM products WHERE slug = 'sac-sport-football';

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/cones.jpg', 1, 0
FROM products WHERE slug = 'kit-entrainement-20-cones';

INSERT INTO product_images (product_id, image_path, is_main, sort_order)
SELECT id, 'assets/images/chaussettes.jpg', 1, 0
FROM products WHERE slug = 'chaussettes-football';

-- Vérifier les photos associées aux produits.
SELECT p.name, pi.image_path, pi.is_main
FROM products AS p
LEFT JOIN product_images AS pi ON pi.product_id = p.id AND pi.is_main = 1
ORDER BY p.id;
