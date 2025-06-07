-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 07 juin 2025 à 22:53
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `flowers`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ajouterProduit`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajouterProduit` (IN `p_nom` VARCHAR(100), IN `p_description` TEXT, IN `p_prix` FLOAT, IN `p_idType` INT, IN `p_idSaison` INT, IN `p_quantite` INT, IN `p_descriptionPhotoAlt` TEXT)   BEGIN
	INSERT INTO produit (nom, description, prix, idType, idSaison, quantite, descriptionPhotoAlt)
    	VALUES (p_nom, p_description, p_prix, p_idType, p_idSaison, p_quantite, p_descriptionPhotoAlt);
END$$

DROP PROCEDURE IF EXISTS `connexion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `connexion` (IN `p_email` VARCHAR(100))   BEGIN
	SELECT email, idRole, mdp
	FROM utilisateur
	WHERE email = p_email;
END$$

DROP PROCEDURE IF EXISTS `connexionAdministrateur`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `connexionAdministrateur` (IN `p_email` VARCHAR(100), `p_mdp` VARCHAR(256))   SELECT email, idRole, mdp
	FROM utilisateur
	WHERE email = p_email AND mdp = p_mdp AND idRole = 1$$

DROP PROCEDURE IF EXISTS `inscription`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inscription` (IN `p_email` VARCHAR(100), `p_mdp` VARCHAR(256), `p_nom` VARCHAR(100), `p_prenom` VARCHAR(100), `p_idRole` INT)   BEGIN
	INSERT INTO utilisateur(email, mdp, nom, prenom, idRole) VALUES (p_email, p_mdp, p_nom, p_prenom, p_idRole);
END$$

DROP PROCEDURE IF EXISTS `listerProduits`$$
CREATE DEFINER=`malak`@`%` PROCEDURE `listerProduits` ()   BEGIN
	SELECT produit.id, produit.nom, description, prix, type.libelle, saison.nomSaison, quantite, photo, descriptionPhotoAlt
    FROM produit
    LEFT JOIN saison ON produit.idSaison = saison.id
    LEFT JOIN type ON produit.idType = type.id
    ORDER BY produit.nom;
END$$

DROP PROCEDURE IF EXISTS `listerProduitsParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listerProduitsParId` (IN `p_idProduit` INT)   BEGIN
	SELECT produit.id, nom, description, prix, type.libelle, taille, nomSaison, quantite, photo, descriptionPhotoAlt
    FROM produit
    LEFT JOIN type ON produit.idType = type.id
    LEFT JOIN saison ON produit.idSaison = saison.id
    WHERE produit.id = p_idProduit;
END$$

DROP PROCEDURE IF EXISTS `listerRoles`$$
CREATE DEFINER=`malak`@`%` PROCEDURE `listerRoles` ()   BEGIN
SELECT id, libelle FROM role;
END$$

DROP PROCEDURE IF EXISTS `listerUtilisateurs`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listerUtilisateurs` ()   BEGIN
	SELECT utilisateur.idUtilisateur, email, idRole, nom, prenom, libelle
    FROM utilisateur
    JOIN role ON utilisateur.idRole = role.id
    ORDER BY nom;
END$$

DROP PROCEDURE IF EXISTS `listerUtilisateursParId`$$
CREATE DEFINER=`malak`@`%` PROCEDURE `listerUtilisateursParId` (IN `p_idUtilisateur` INT)   BEGIN
	SELECT idUtilisateur, email, nom, prenom, idRole
	FROM utilisateur
    WHERE idUtilisateur=p_idUtilisateur
    ORDER BY idUtilisateur;
END$$

DROP PROCEDURE IF EXISTS `modifierMDP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modifierMDP` (IN `p_idUtilisateur` INT, `p_mdp` VARCHAR(256))   BEGIN
	UPDATE utilisateur
    SET mdp = p_mdp
    WHERE idUtilisateur = p_idUtilisateur;
END$$

DROP PROCEDURE IF EXISTS `modifierProduit`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `modifierProduit` (IN `p_id` INT, IN `p_nom` VARCHAR(100), IN `p_description` TEXT, IN `p_prix` FLOAT, IN `p_idType` INT, IN `p_idSaison` TINYINT, IN `p_quantite` INT, IN `p_descriptionPhotoAlt` TEXT)   BEGIN
    UPDATE produit
    SET
        nom = p_nom,
        description = p_description,
        prix = p_prix,
        idType = p_idType,
        idSaison = p_idSaison,
        quantite = p_quantite,
        descriptionPhotoAlt = p_descriptionPhotoAlt
    WHERE id = p_id;
END$$

DROP PROCEDURE IF EXISTS `modifierUtilisateur`$$
CREATE DEFINER=`malak`@`%` PROCEDURE `modifierUtilisateur` (IN `p_idUtilisateur` INT, `p_email` VARCHAR(100), `p_nom` VARCHAR(100), `p_prenom` VARCHAR(100), `p_idRole` INT)   BEGIN
	UPDATE utilisateur
    SET nom = p_nom, prenom = p_prenom, idRole = p_idRole, email = p_email WHERE idUtilisateur = p_idUtilisateur;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `anciensmdp`
--

DROP TABLE IF EXISTS `anciensmdp`;
CREATE TABLE IF NOT EXISTS `anciensmdp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUtilisateur` int DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  `dateModification` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `anciensmdp`
--

INSERT INTO `anciensmdp` (`id`, `idUtilisateur`, `mdp`, `dateModification`) VALUES
(1, 16, 'nana', '2025-05-10 00:00:00'),
(2, 16, '58', '2025-05-10 01:01:11'),
(3, 16, '58', '2025-05-10 01:01:11'),
(4, 14, '58', '2025-05-10 01:01:11'),
(5, 8, '58', '2025-05-10 01:01:11'),
(6, 16, '248', '2025-05-10 01:01:11'),
(7, 15, '58', '2025-05-10 01:01:11'),
(8, 15, 'nana2', '2025-05-10 01:57:23'),
(9, 15, 'lslsll', '2025-05-10 01:59:45'),
(10, 15, '', '2025-05-10 01:59:54'),
(11, 16, '$2y$10$yGimzSjo6SzI64Jq0lJuCuOf2Ryv/AM7BA4ISE0xja5widWeoNzRq', '2025-05-22 09:37:38'),
(12, 16, '$2y$10$9Q0zNr8XeyeFYgfNnytRZOoCh9LUF4eUjc2wBls7AKMATYJ2nDz5S', '2025-05-22 09:37:38'),
(13, 16, '$2y$10$9Q0zNr8XeyeFYgfNnytRZOoCh9LUF4eUjc2wBls7AKMATYJ2nDz5S', '2025-05-22 09:38:14'),
(14, 16, '$2y$10$02HKTeL9kS0ROXKhtLhAreM8V9JscLoMSYlXgB6S21yYYN/UBjrma', '2025-05-22 09:38:14'),
(15, 16, '$2y$10$02HKTeL9kS0ROXKhtLhAreM8V9JscLoMSYlXgB6S21yYYN/UBjrma', '2025-05-22 10:34:39'),
(16, 16, '$2y$10$2c/1Q/eBBAZK73zGcGdscOYIqaVVwDr.q.DwWVa4R91Sj8vGm4icG', '2025-05-22 10:34:39'),
(17, 16, '$2y$10$2c/1Q/eBBAZK73zGcGdscOYIqaVVwDr.q.DwWVa4R91Sj8vGm4icG', '2025-05-22 10:37:11'),
(18, 16, '$2y$10$4uf13CA65wyRggdsa8nSC.4ivPZVW78uzGl.DY7dNUWn.dk/BOwUa', '2025-05-22 10:37:11'),
(19, 16, '$2y$10$4uf13CA65wyRggdsa8nSC.4ivPZVW78uzGl.DY7dNUWn.dk/BOwUa', '2025-05-22 10:42:47'),
(20, 16, '$2y$10$ukJUzTbT0XogF9BEoYnqD.6mcKvZLBOvVmLG4pFdlr7zjW0opIX/2', '2025-05-22 10:42:47'),
(21, 16, '$2y$10$ukJUzTbT0XogF9BEoYnqD.6mcKvZLBOvVmLG4pFdlr7zjW0opIX/2', '2025-05-22 10:49:48'),
(22, 16, '$2y$10$ukJUzTbT0XogF9BEoYnqD.6mcKvZLBOvVmLG4pFdlr7zjW0opIX/2', '2025-05-22 10:49:48'),
(23, 16, '$2y$10$FMEO1wFgWuu5kCflFIfZJOIlC4GLUKe8hjSbCibF98qKMT3k67Suy', '2025-05-22 10:49:48'),
(24, 16, '$2y$10$FMEO1wFgWuu5kCflFIfZJOIlC4GLUKe8hjSbCibF98qKMT3k67Suy', '2025-05-22 11:00:31'),
(25, 16, '$2y$10$BsfOt1jnriDzxrqnnHn9g.FuzjiEVZunaneNj./Ht0uTDzXKld7e6', '2025-05-22 11:00:31'),
(26, 16, '$2y$10$BsfOt1jnriDzxrqnnHn9g.FuzjiEVZunaneNj./Ht0uTDzXKld7e6', '2025-05-22 11:16:18'),
(27, 16, '$2y$10$OPYALTrQX1CIMdha/Ql.x.VZyP91Y3nzg76p0VLp4SNWUIcRH52BW', '2025-05-22 11:18:35'),
(28, 16, '$2y$10$qKP4Kok.5lA9mXfxM2hDSuJ1YkUTivxiCJKv0Pz3LjheIQ68anIP2', '2025-05-22 11:27:43'),
(29, 16, '$2y$10$P0c/byxgsp/snjJ6lZ6SNOICNMf8M8u80Sm8Q3jogKxYHrp9rowAu', '2025-05-22 11:28:23');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `idCommande` int NOT NULL AUTO_INCREMENT,
  `montant` float DEFAULT NULL,
  `dateCommande` datetime DEFAULT NULL,
  `etat` int DEFAULT NULL,
  `idUtilisateur` int DEFAULT NULL,
  PRIMARY KEY (`idCommande`),
  KEY `idUtilisateur` (`idUtilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `composer`
--

DROP TABLE IF EXISTS `composer`;
CREATE TABLE IF NOT EXISTS `composer` (
  `idCommande` int DEFAULT NULL,
  `idProduit` int DEFAULT NULL,
  `quantite` int DEFAULT NULL,
  KEY `idCommande` (`idCommande`),
  KEY `idProduit` (`idProduit`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `codePostal` int DEFAULT NULL,
  `numeroTelephone` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `siteWeb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`id`, `nom`, `adresse`, `ville`, `codePostal`, `numeroTelephone`, `email`, `siteWeb`) VALUES
(2, 'Exotica Fleur', 'Ccal Cap Sud 162 av Pierre Sémard', 'Avignon', 84000, '0490851190', '[value-7]', 'https://exoticafleurs.com'),
(3, 'Fleuristerie du Sud', '12 Rue de la Lavande', 'Nice', 6000, '04 93 00 0', 'contact@fleuristeriedusud.fr', 'www.fleuristeriedusud.fr'),
(4, 'Les Fleurs de Provence', '78 Avenue de la Mer', 'Marseille', 13008, '04 91 45 3', 'info@fleursdeprovence.fr', 'www.fleursdeprovence.fr'),
(5, 'Le Jardin des Fleurs', '3 Rue des Tuileries', 'Toulon', 83000, '04 94 88 3', 'jardin@fleurs-toulon.fr', 'www.jardindesfleurs.fr'),
(6, 'L\'Art Floral', '9 Boulevard de la République', 'Aix-en-Provence', 13100, '04 42 21 6', 'art@floral-aix.fr', 'www.artfloral-aix.fr'),
(7, 'Fleurs et Bouquets', '45 Rue de la Gare', 'Cannes', 6400, '04 97 06 8', 'contact@fleursetbouquets-cannes.fr', 'www.fleursetbouquets-cannes.fr'),
(8, 'Fleuriste du Parc', '22 Allée des Acacias', 'Antibes', 6600, '04 93 34 5', 'parc@fleuriste-antibes.fr', 'www.fleuristeduparc.fr');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `listerproduits`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `listerproduits`;
CREATE TABLE IF NOT EXISTS `listerproduits` (
`description` text
,`descriptionPhotoAlt` text
,`id` int
,`libelle` varchar(100)
,`libelleOccasion` varchar(100)
,`nom` varchar(100)
,`nomSaison` varchar(100)
,`photo` varchar(255)
,`prix` float
,`quantite` int
,`taille` enum('unite','petit','moyen','grand')
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `listerroles`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `listerroles`;
CREATE TABLE IF NOT EXISTS `listerroles` (
`id` int
,`libelle` varchar(50)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `listertype`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `listertype`;
CREATE TABLE IF NOT EXISTS `listertype` (
`id` int
,`libelle` varchar(100)
,`taille` enum('unite','petit','moyen','grand')
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `listerutilisateurs`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `listerutilisateurs`;
CREATE TABLE IF NOT EXISTS `listerutilisateurs` (
`idUtilisateur` int
,`nom` varchar(100)
,`prenom` varchar(100)
,`email` varchar(100)
,`libelle` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure de la table `occasion`
--

DROP TABLE IF EXISTS `occasion`;
CREATE TABLE IF NOT EXISTS `occasion` (
  `idOccasion` int NOT NULL AUTO_INCREMENT,
  `libelleOccasion` varchar(100) DEFAULT NULL,
  `idSaison` int DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  PRIMARY KEY (`idOccasion`),
  KEY `idSaison` (`idSaison`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `occasion`
--

INSERT INTO `occasion` (`idOccasion`, `libelleOccasion`, `idSaison`, `dateDebut`, `dateFin`) VALUES
(1, 'Saint Valentin', 4, '2025-02-14', '2025-02-14'),
(2, 'Nouvel an', 4, '2025-12-31', '2026-01-01'),
(3, 'Toussaint', 3, '2025-11-01', '2025-11-01'),
(4, 'Pâques', 1, '2025-04-20', '2025-04-20'),
(5, 'Fête des pères', 1, '2025-06-15', '2025-06-15'),
(6, 'Félicitations', 0, '2025-01-01', '2025-12-31'),
(7, 'Naissance', 0, '2025-01-01', '2025-12-31'),
(8, 'Mariage', 0, '2025-01-01', '2025-12-31'),
(9, 'Deuil', 0, '2025-01-01', '2025-12-31'),
(10, 'Noël', 4, '2025-12-24', '2025-12-25'),
(11, 'Oral épreuve E6', 2, '2025-06-12', '2025-06-13');

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `description` text,
  `prix` float DEFAULT NULL,
  `idType` int DEFAULT NULL,
  `idSaison` tinyint DEFAULT NULL,
  `quantite` int NOT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descriptionPhotoAlt` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idType` (`idType`),
  KEY `idSaison` (`idSaison`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `nom`, `description`, `prix`, `idType`, `idSaison`, `quantite`, `photo`, `descriptionPhotoAlt`) VALUES
(2, 'Tulipes', 'ipsum', 8, 1, 0, 0, './images/bouquet4.png', 'un bouquet de tulipes'),
(3, 'Marguerite', 'lorem ipsum', 7.99, 1, 4, 0, './images/bouquet7.png', ''),
(6, 'Pivoine', 'Une jolie fleur printanière', 3, 4, 1, 842, './images/bouquetPivoines', 'Photo de pivoines'),
(7, 'Muguet', 'Brins de muguet ', 9.99, 1, 1, 50, NULL, 'brin de muguet'),
(8, 'Muguet', 'Brins de muguet ', 15, 1, 1, 50, NULL, 'brin de muguet');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`id`, `libelle`) VALUES
(1, 'Administrateur'),
(2, 'Client');

-- --------------------------------------------------------

--
-- Structure de la table `saison`
--

DROP TABLE IF EXISTS `saison`;
CREATE TABLE IF NOT EXISTS `saison` (
  `id` tinyint NOT NULL AUTO_INCREMENT,
  `nomSaison` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `saison`
--

INSERT INTO `saison` (`id`, `nomSaison`, `date_debut`, `date_fin`) VALUES
(1, 'Printemps', '2025-03-20', '2025-06-20'),
(2, 'Été', '2025-06-21', '2025-09-21'),
(3, 'Automne', '2025-09-22', '2025-12-20'),
(4, 'Hiver', '2025-12-21', '2026-03-19'),
(0, 'Année entière', '2025-01-01', '2026-12-31'),
(5, 'Printemps-Été', '2025-03-20', '2025-09-21'),
(6, 'Automne-Hiver', '2025-09-22', '2026-03-19');

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) DEFAULT NULL,
  `taille` enum('unite','petit','moyen','grand') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`id`, `libelle`, `taille`) VALUES
(1, 'Petit bouquet', 'petit'),
(2, 'Bouquet moyen', 'moyen'),
(3, 'Grand bouquet', 'grand'),
(4, 'Unité', 'unite');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `idUtilisateur` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `mdp` varchar(256) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `idRole` int DEFAULT '2',
  PRIMARY KEY (`idUtilisateur`),
  UNIQUE KEY `email` (`email`),
  KEY `idRole` (`idRole`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `email`, `mdp`, `nom`, `prenom`, `idRole`) VALUES
(22, 'championsLDC@psg.fr', '$2y$10$.FmJQngVmL.CVZe1mujEnOJEPxNpXsFqtXy.ewaXmM8f5V36A.r9W', 'DOUÉ', 'Désiré', 2),
(19, 'mauderatrice@nabi.com', '$2y$10$4xCxVdgLC4aHu8OG4vkV6uyp4rIcQ1c79M1NnRSdYdQnmtBySpsqO', 'Eratrice', 'Maude', 1),
(20, 'elmokretarmalak25@gmail.com', '$2y$10$CJXn9eoeyFdnVXF8tcjvBON7JnNZK1bgQy3bGZ7GG5Y4Bv9MX/7w2', 'EL MOKRETAR', 'Malak', 2),
(21, 'jeanpeuplu@ryoosyo.fr', '$2y$10$j./LawZ1hnw4P.jpJxBwXuXToFcmU1Vt125Tv.1jVxPrfeOGJjGY.', 'Peuplu', 'Jean', 2),
(23, 'johndoe@nabi.fr', '$2y$10$m6Zi7b4ojbihZTOpDVs.8ewjmmYcteFqrGJytxsHQcBeGtfu8mowm', 'DOE', 'John', 1),
(41, 'henri.renaud@mail.com', '$2y$10$WEJIVHM8UsvdJ8jPxwXLKeghQmYKnTwub2HOoDZboawcGDRNmQbCe', 'Renaud', 'Henri', 2),
(40, 'gabrielle.leroy@icloud.com', '$2y$10$gCSUUnz2wC8Ue2JVSUSJ6e3/wczsWx1KSOlacY8KLokeFjp/v7Ei.', 'Leroy', 'Gabrielle', 2),
(39, 'francois.moreau@orange.fr', '$2y$10$RUFviUFbG9CatmMP266a2ecwbuW8OKlQqJnnfaqG5g5jt7IJZOnfm', 'Moreau', 'François', 1),
(38, 'emilie.durand@hotmail.com', '$2y$10$n.Do1KqeC1i7qNNujPXsoeZXDUlSj8l9msrJdJeztFYg1MeA7HTYa', 'Durand', 'Emilie', 2),
(36, 'charlotte.leblanc@outlook.com', '$2y$10$W37YGt.eKy2gnfW/55CQFeoQHm60WzwUpIDSaW8RvtFWzD.7TCRSO', 'LeBlanc', 'Charlotte', 2),
(35, 'bernard.martin@yahoo.fr', '$2y$10$.ziSFBU8lkLueZyYBoFLYebDV./JQCEngV6eNjVe0zkX8m8JPq1kq', 'Martin', 'Bernard', 2),
(34, 'alice.dupont@gmail.com', '$2y$10$CGSRBt9WrDmTIPV01Wbbxux2vPkJXP0gvsS5mnGzlY2jUTM180xtm', 'Dupont', 'Alice', 2),
(42, 'isabelle.faure@free.fr', '$2y$10$LhfQjbV6CGZwFPDij2alCOUifOCKHd1cZF/2N0wc/SrKPoo0vSDa2', 'Faure', 'Isabelle', 2),
(45, 'malakvreiuh@gmail.com', '$2y$10$lvE4dPNmpyH2TlFOvBVejO/sewOWpLYp96uxDtGl1JPTUiGumrbZe', 'malak', 'malak', 1),
(44, 'romain.lagarde@handballjo.com', '$2y$10$r8jpoTpU8iaNUWXs91NaX.qAucG9.jo7Cpl6JocOyomjx45gEanlm', 'Lagarde', 'Romain', 2);

--
-- Déclencheurs `utilisateur`
--
DROP TRIGGER IF EXISTS `historique_anciens_utilisateurs`;
DELIMITER $$
CREATE TRIGGER `historique_anciens_utilisateurs` AFTER DELETE ON `utilisateur` FOR EACH ROW BEGIN
    INSERT INTO utilisateur_supprime (idUtilisateurSupprime, email, mdp, nom, prenom, idRole, date_supp)
    VALUES (OLD.idUtilisateur, OLD.email, OLD.mdp, OLD.nom, OLD.prenom, OLD.idRole, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_supprime`
--

DROP TABLE IF EXISTS `utilisateur_supprime`;
CREATE TABLE IF NOT EXISTS `utilisateur_supprime` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUtilisateurSupprime` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mdp` varchar(256) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `idRole` int DEFAULT NULL,
  `date_supp` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idUtilisateurSupprime` (`idUtilisateurSupprime`),
  KEY `idRole` (`idRole`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur_supprime`
--

INSERT INTO `utilisateur_supprime` (`id`, `idUtilisateurSupprime`, `email`, `mdp`, `nom`, `prenom`, `idRole`, `date_supp`) VALUES
(1, 1, 'elmokretarmalak25@gmail.com', '$2y$10$.AFGFVhZOVGdnvMaBYEqYet9yy5kjOgHUHn681/oac4gGvCtkWnM2', 'EL MOKRETAR', 'Malak', 1, '2025-04-30 11:33:12'),
(2, 8, 'hammedikelian@gmail.com', '$2y$10$fxlqi8eIBW1UVBZ6YnjKmO.FTVpcFVon3KHR0JOBMYXmjY00SMnRS', 'kelian', 'kelian', 1, '2025-05-22 09:42:14'),
(3, 37, 'daniel.robert@live.fr', '$2y$10$v7zklgA4RODICe6gca6q5OB5OjukHLQL4hpVvrdhS7YsNipZnoDca', 'Robert', 'Daniel', 1, '2025-06-06 21:06:40');

-- --------------------------------------------------------

--
-- Structure de la vue `listerproduits`
--
DROP TABLE IF EXISTS `listerproduits`;

DROP VIEW IF EXISTS `listerproduits`;
CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%` SQL SECURITY DEFINER VIEW `listerproduits`  AS SELECT `produit`.`description` AS `description`, `produit`.`descriptionPhotoAlt` AS `descriptionPhotoAlt`, `produit`.`id` AS `id`, `type`.`libelle` AS `libelle`, `occasion`.`libelleOccasion` AS `libelleOccasion`, `produit`.`nom` AS `nom`, `saison`.`nomSaison` AS `nomSaison`, `produit`.`photo` AS `photo`, `produit`.`prix` AS `prix`, `produit`.`quantite` AS `quantite`, `type`.`taille` AS `taille` FROM (((`produit` left join `saison` on((`produit`.`idSaison` = `saison`.`id`))) left join `occasion` on((`saison`.`id` = `occasion`.`idSaison`))) left join `type` on((`produit`.`idType` = `type`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `listerroles`
--
DROP TABLE IF EXISTS `listerroles`;

DROP VIEW IF EXISTS `listerroles`;
CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%` SQL SECURITY DEFINER VIEW `listerroles`  AS SELECT `role`.`id` AS `id`, `role`.`libelle` AS `libelle` FROM `role` ;

-- --------------------------------------------------------

--
-- Structure de la vue `listertype`
--
DROP TABLE IF EXISTS `listertype`;

DROP VIEW IF EXISTS `listertype`;
CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%` SQL SECURITY DEFINER VIEW `listertype`  AS SELECT `type`.`id` AS `id`, `type`.`libelle` AS `libelle`, `type`.`taille` AS `taille` FROM `type` ;

-- --------------------------------------------------------

--
-- Structure de la vue `listerutilisateurs`
--
DROP TABLE IF EXISTS `listerutilisateurs`;

DROP VIEW IF EXISTS `listerutilisateurs`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listerutilisateurs`  AS SELECT `utilisateur`.`idUtilisateur` AS `idUtilisateur`, `utilisateur`.`nom` AS `nom`, `utilisateur`.`prenom` AS `prenom`, `utilisateur`.`email` AS `email`, `role`.`libelle` AS `libelle` FROM (`utilisateur` join `role` on((`role`.`id` = `utilisateur`.`idRole`))) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
