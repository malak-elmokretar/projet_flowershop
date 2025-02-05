-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 05 fév. 2025 à 10:55
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

DROP PROCEDURE IF EXISTS `lister_utilisateurs`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `lister_utilisateurs` ()   BEGIN
	SELECT utilisateur.id, email, idRole, nom, prenom, libelle
    FROM utilisateur
    JOIN role ON utilisateur.idRole = role.id
    ORDER BY nom;
END$$

DELIMITER ;

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
  PRIMARY KEY (`id`),
  KEY `idType` (`idType`),
  KEY `idSaison` (`idSaison`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `nom`, `description`, `prix`, `idType`, `idSaison`) VALUES
(1, 'Rose', 'Lorem', 5.45, 1, 1),
(2, 'Tulipe', 'ipsum', 8, 2, 2),
(3, 'Marguerite', 'lorem ipsum', 7.99, 1, 4),
(4, 'Fleur rouge', 'lorem ispum ahbfhe', 3.5, 2, 1);

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
  `nom` varchar(100) DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `mdp` varchar(256) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `idRole` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idRole` (`idRole`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `email`, `mdp`, `nom`, `prenom`, `idRole`) VALUES
(1, 'elmokretarmalak25@gmail.com', '$2y$10$.AFGFVhZOVGdnvMaBYEqYet9yy5kjOgHUHn681/oac4gGvCtkWnM2', 'EL MOKRETAR', 'Malak', 1),
(2, 'rthrh@gjhb.com', '$2y$10$UIRSWW9gN9apnFP.9q7nAOye7j4EWlr1hPYiRHbeLqerERDk6qJy6', 'DOE', 'jane', 1),
(3, 'rthrkmh@gjhb.com', '$2y$10$MNd.0diq9A/9wRCVGc4LMelYUHNwA7/rim6Lqb.it41Zw7UTgnQKK', 'DOE', 'jange', 2),
(4, 'rt24444424lkh@gjhb.com', '$2y$10$fc1Y8GOEDWthWRbscIhEK.dgUXrUwL8Uf6w1EsMNez4U1CbnTtKz2', 'DOE', 'jange', 2),
(5, 'johndoe@example.com', '$2y$10$o1IVbBU.1EwhvEplzqwRm.le3o5Oz/8M.Gi7zUaxCxwGtZrj1.G/i', 'DOE', 'John', 2),
(6, 'jBlick@hyzeuf.com', '$2y$10$M526jBo16cROl6OcEFM8r.ZSE0SqMDyTzJ6xnOYoUjelVfX03yNDq', 'Blick', 'Juliette', 2),
(8, 'hammedikelian@gmail.com', '$2y$10$fxlqi8eIBW1UVBZ6YnjKmO.FTVpcFVon3KHR0JOBMYXmjY00SMnRS', 'kelian', 'kelian', 1),
(9, 'malak@flower.com', '$2y$10$L9VoyhhilTazWSDLG6vS0eKSjnRqmGp3zjYvYmtgGQRaPe64HncZG', 'Malak', 'Malak', 2),
(10, 'malakmalak@flower.com', '$2y$10$DI9QxhZXw5HkbU.7JoSi5.Eri2OewbiPyJlzL4oqZaowb4yAn1lQa', 'Malak', 'Malak', 2);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_supprime`
--

DROP TABLE IF EXISTS `utilisateur_supprime`;
CREATE TABLE IF NOT EXISTS `utilisateur_supprime` (
  `id` int NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mdp` varchar(256) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `idRole` int DEFAULT '1',
  `date_supp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idRole` (`idRole`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
