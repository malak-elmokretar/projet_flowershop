-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 22 mai 2025 à 06:12
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
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(10, 15, '', '2025-05-10 01:59:54');

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `photo` text NOT NULL,
  `descriptionPhotoAlt` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idType` (`idType`),
  KEY `idSaison` (`idSaison`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `nom`, `description`, `prix`, `idType`, `idSaison`, `quantite`, `photo`, `descriptionPhotoAlt`) VALUES
(1, 'Rose', 'Lorem', 5.45, 1, 1, 0, './images/background1.png', ''),
(2, 'Tulipe', 'ipsum', 8, 2, 2, 0, './images/background2.png', ''),
(3, 'Marguerite', 'lorem ipsum', 7.99, 1, 4, 0, './images/butterfly.png', ''),
(4, 'Fleur rouge', 'lorem ispum ahbfhe', 3.5, 2, 1, 0, './images/background4.png', ''),
(5, 'Assortiment de roses', 'Un joli assortiment de roses de toutes les couleurs', 34, 3, 1, 12, '', '89');

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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `saison`
--

INSERT INTO `saison` (`id`, `nomSaison`, `date_debut`, `date_fin`) VALUES
(1, 'Printemps', '2025-03-20', '2025-06-20'),
(2, 'Été', '2025-06-21', '2025-09-21'),
(3, 'Automne', '2025-09-22', '2025-12-20'),
(4, 'Hiver', '2025-12-21', '2026-03-19'),
(5, 'Saint Valentin', '2025-02-14', '2025-02-14'),
(6, 'Nouvel an', '2025-12-31', '2026-01-01'),
(7, 'Toussaint', '2025-11-01', '2025-11-01'),
(8, 'Pâques', '2025-04-20', '2025-04-20'),
(9, 'Fête des mères', '2025-05-05', '2025-05-05'),
(10, 'Fête des pères', '2025-06-15', '2025-06-15'),
(12, 'Félicitations', '2025-01-01', '2025-12-31'),
(13, 'Naissance', '2025-01-01', '2025-12-31'),
(14, 'Mariage', '2025-01-01', '2025-12-31'),
(15, 'Deuil', '2025-01-01', '2025-12-31'),
(16, 'Noël', '2025-12-24', '2025-12-25');

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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`id`, `libelle`, `taille`) VALUES
(1, 'Petit bouquet', 'petit'),
(2, 'Bouquet moyen', 'moyen'),
(3, 'Grand bouquet', 'grand');

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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `email`, `mdp`, `nom`, `prenom`, `idRole`) VALUES
(14, 'elmokretarmalak25@gmail.com', '$2y$10$M/Y8AWgYKKj8ycqPOfU9du85w4nP8fS6cOFc4Tn0mhBbcwMG4LhGS', 'EL MOKRETAR', 'Malak', 1),
(15, 'malak@nabi.com', 'chocolat', 'EL MOKRETAR', 'Malak', 1),
(16, 'example@example.fr', '$2y$10$yGimzSjo6SzI64Jq0lJuCuOf2Ryv/AM7BA4ISE0xja5widWeoNzRq', 'Doe', 'Jane', 2),
(8, 'hammedikelian@gmail.com', '$2y$10$fxlqi8eIBW1UVBZ6YnjKmO.FTVpcFVon3KHR0JOBMYXmjY00SMnRS', 'kelian', 'kelian', 1);

--
-- Déclencheurs `utilisateur`
--
DROP TRIGGER IF EXISTS `repertorierAnciensMDP`;
DELIMITER $$
CREATE TRIGGER `repertorierAnciensMDP` BEFORE UPDATE ON `utilisateur` FOR EACH ROW BEGIN
	INSERT INTO `anciensmdp`(`idUtilisateur`, `mdp`, `dateModification`) VALUES (NEW.idUtilisateur,OLD.mdp, CURRENT_TIMESTAMP);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `suppression_utilisateur`;
DELIMITER $$
CREATE TRIGGER `suppression_utilisateur` AFTER DELETE ON `utilisateur` FOR EACH ROW BEGIN
    	INSERT INTO utilisateur_supprime (idUtilisateurSupprime, email, mdp, nom, prenom, idRole, date_supp) VALUES (OLD.idUtilisateur, OLD.email, OLD.mdp, OLD.nom, OLD.prenom, OLD.idRole, CURRENT_TIMESTAMP);
        DELETE FROM utilisateur
        WHERE utilisateur.idUtilisateur = OLD.idUtilisateur;
    END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `verifierMDPDejaUtilise`;
DELIMITER $$
CREATE TRIGGER `verifierMDPDejaUtilise` BEFORE UPDATE ON `utilisateur` FOR EACH ROW IF EXISTS (
        SELECT 1
        FROM anciensmdp
        WHERE idUtilisateur = NEW.idUtilisateur
          AND mdp = NEW.mdp
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Votre mot de passe ne doit pas être un mdp que vous avez déjà utilisé.';
    END IF
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur_supprime`
--

INSERT INTO `utilisateur_supprime` (`id`, `idUtilisateurSupprime`, `email`, `mdp`, `nom`, `prenom`, `idRole`, `date_supp`) VALUES
(1, 1, 'elmokretarmalak25@gmail.com', '$2y$10$.AFGFVhZOVGdnvMaBYEqYet9yy5kjOgHUHn681/oac4gGvCtkWnM2', 'EL MOKRETAR', 'Malak', 1, '2025-04-30 11:33:12');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
