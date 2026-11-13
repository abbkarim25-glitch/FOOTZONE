CREATE DATABASE IF NOT EXISTS footzone_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE footzone_db;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS wishlist,reviews,payments,order_items,orders,cart_items,carts,product_images,product_variants,products,categories,addresses,users;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE users(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,full_name VARCHAR(120) NOT NULL,email VARCHAR(190) NOT NULL UNIQUE,phone VARCHAR(30),password_hash VARCHAR(255) NOT NULL,role ENUM('customer','admin') NOT NULL DEFAULT 'customer',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE addresses(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL,label VARCHAR(50) DEFAULT 'Domicile',full_name VARCHAR(120) NOT NULL,phone VARCHAR(30) NOT NULL,street VARCHAR(255) NOT NULL,city VARCHAR(100) NOT NULL,postal_code VARCHAR(20),country VARCHAR(80) DEFAULT 'Tunisie',is_default TINYINT(1) DEFAULT 0,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE);
CREATE TABLE categories(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) NOT NULL,slug VARCHAR(120) NOT NULL UNIQUE,description TEXT,image VARCHAR(255),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE products(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,category_id INT UNSIGNED NOT NULL,name VARCHAR(180) NOT NULL,slug VARCHAR(200) NOT NULL UNIQUE,brand VARCHAR(100),description TEXT,price DECIMAL(10,3) NOT NULL,compare_price DECIMAL(10,3),stock INT UNSIGNED NOT NULL DEFAULT 0,sku VARCHAR(80) UNIQUE,status ENUM('active','inactive') DEFAULT 'active',featured TINYINT(1) DEFAULT 0,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(category_id) REFERENCES categories(id));
CREATE TABLE product_variants(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,product_id INT UNSIGNED NOT NULL,size VARCHAR(30),color VARCHAR(50),stock INT UNSIGNED DEFAULT 0,sku VARCHAR(80) UNIQUE,FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE);
CREATE TABLE product_images(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,product_id INT UNSIGNED NOT NULL,image_path VARCHAR(255) NOT NULL,is_main TINYINT(1) DEFAULT 0,sort_order INT DEFAULT 0,FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE);
CREATE TABLE carts(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL UNIQUE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE);
CREATE TABLE cart_items(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,cart_id INT UNSIGNED NOT NULL,product_id INT UNSIGNED NOT NULL,variant_id INT UNSIGNED,quantity INT UNSIGNED DEFAULT 1,added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(cart_id) REFERENCES carts(id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,FOREIGN KEY(variant_id) REFERENCES product_variants(id) ON DELETE SET NULL);
CREATE TABLE orders(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL,address_id INT UNSIGNED,order_number VARCHAR(30) NOT NULL UNIQUE,status ENUM('pending','confirmed','processing','shipped','delivered','cancelled') DEFAULT 'pending',subtotal DECIMAL(10,3) NOT NULL,shipping_cost DECIMAL(10,3) DEFAULT 0,total DECIMAL(10,3) NOT NULL,customer_name VARCHAR(120) NOT NULL,customer_phone VARCHAR(30) NOT NULL,shipping_address TEXT NOT NULL,notes TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id),FOREIGN KEY(address_id) REFERENCES addresses(id) ON DELETE SET NULL);
CREATE TABLE order_items(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,order_id INT UNSIGNED NOT NULL,product_id INT UNSIGNED,product_name VARCHAR(180) NOT NULL,unit_price DECIMAL(10,3) NOT NULL,quantity INT UNSIGNED NOT NULL,variant_description VARCHAR(100),FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL);
CREATE TABLE payments(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,order_id INT UNSIGNED NOT NULL,method ENUM('cash_on_delivery','bank_transfer','online') DEFAULT 'cash_on_delivery',status ENUM('pending','paid','failed','refunded') DEFAULT 'pending',amount DECIMAL(10,3) NOT NULL,transaction_reference VARCHAR(150),paid_at DATETIME,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE);
CREATE TABLE reviews(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL,product_id INT UNSIGNED NOT NULL,rating TINYINT UNSIGNED NOT NULL,comment TEXT,status ENUM('pending','approved','rejected') DEFAULT 'pending',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,CHECK(rating BETWEEN 1 AND 5),FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,UNIQUE KEY uq_review(user_id,product_id));
CREATE TABLE wishlist(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL,product_id INT UNSIGNED NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,UNIQUE KEY uq_wishlist(user_id,product_id));
INSERT INTO categories(name,slug,description) VALUES
('Chaussures de football','chaussures-football','Crampons pour tous les terrains'),('Maillots et tenues','maillots-tenues','Maillots, shorts et ensembles'),('Ballons','ballons','Ballons entrainement et match'),('Gants de gardien','gants-gardien','Gants de gardien'),('Protections','protections','Protège-tibias et protections'),('Sacs de sport','sacs-sport','Sacs et rangement'),('Équipements d’entraînement','entrainement','Plots et matériel technique'),('Accessoires','accessoires','Chaussettes et accessoires'),('Équipements de gardien','equipements-gardien','Matériel pour gardiens'),('Équipements de terrain et de but','terrain-but','Buts et filets'),('Arbitrage','arbitrage','Sifflets et cartons'),('Clubs et équipes','clubs-equipes','Kits collectifs');
INSERT INTO products(category_id,name,slug,brand,description,price,compare_price,stock,sku,featured) VALUES
(1,'Chaussures Speed Pro','chaussures-speed-pro','SportX','Chaussures pour terrain synthétique.',189.900,219.900,15,'FZ-SHOE-001',1),
(2,'Maillot Football Classic','maillot-football-classic','SportX','Maillot respirant pour match et entraînement.',79.900,NULL,30,'FZ-JER-001',1),
(3,'Ballon Match Elite','ballon-match-elite','ProBall','Ballon pour entraînement et match.',99.900,119.900,20,'FZ-BAL-001',1),
(4,'Gants Keeper Grip','gants-keeper-grip','KeeperPro','Gants avec paume antidérapante.',69.900,NULL,12,'FZ-GLOVE-001',0),
(5,'Protège-tibias Flex','protege-tibias-flex','SportX','Protections légères.',29.900,NULL,40,'FZ-PROT-001',0),
(6,'Sac de sport Football','sac-sport-football','TeamBag','Sac avec compartiment chaussures.',59.900,NULL,18,'FZ-BAG-001',0),
(7,'Kit entraînement 20 cônes','kit-entrainement-20-cones','TrainPro','Kit de cônes pour exercices techniques.',34.900,NULL,25,'FZ-TRAIN-001',0),
(8,'Chaussettes Football','chaussettes-football','SportX','Chaussettes longues de football.',19.900,NULL,50,'FZ-ACC-001',0);


-- Photos de démonstration FOOTZONE
INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/chaussures.jpg',1 FROM products WHERE slug='chaussures-speed-pro';
INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/maillot.jpg',1 FROM products WHERE slug='maillot-football-classic';
INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/ballon.jpg',1 FROM products WHERE slug='ballon-match-elite';
INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/gants.jpg',1 FROM products WHERE slug='gants-keeper-grip';

INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/protege-tibias.jpg',1 FROM products WHERE slug='protege-tibias-flex';
INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/sac.jpg',1 FROM products WHERE slug='sac-sport-football';
INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/cones.jpg',1 FROM products WHERE slug='kit-entrainement-20-cones';
INSERT INTO product_images(product_id,image_path,is_main)
SELECT id,'assets/images/chaussettes.jpg',1 FROM products WHERE slug='chaussettes-football';
