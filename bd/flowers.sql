-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 30 jan. 2025 à 10:16
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `saison`
--

INSERT INTO `saison` (`id`, `nom`, `date_debut`, `date_fin`) VALUES
(1, 'Printemps', '2025-03-20', '2025-06-20'),
(2, 'Ete', '2025-06-21', '2025-09-21'),
(3, 'Automne', '2025-09-22', '2025-12-20'),
(4, 'hiver', '2025-12-21', '2026-03-19');

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) DEFAULT NULL,
  `taille` ENUM('unite', 'petit', 'moyen', 'grand'),
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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `email`, `mdp`, `nom`, `prenom`, `idRole`) VALUES
(1, 'elmokretarmalak25@gmail.com', '$2y$10$KOBfKjC6iEgYYCltWklOY.6vFEyhK5APikyB7bmlBGrhuqo61p4u.', 'EL MOKRETAR', 'Malak', 1),
(2, 'rthrh@gjhb.com', '$2y$10$UIRSWW9gN9apnFP.9q7nAOye7j4EWlr1hPYiRHbeLqerERDk6qJy6', 'DOE', 'jane', 1),
(3, 'rthrkmh@gjhb.com', '$2y$10$MNd.0diq9A/9wRCVGc4LMelYUHNwA7/rim6Lqb.it41Zw7UTgnQKK', 'DOE', 'jange', 2),
(4, 'rt24444424lkh@gjhb.com', '$2y$10$fc1Y8GOEDWthWRbscIhEK.dgUXrUwL8Uf6w1EsMNez4U1CbnTtKz2', 'DOE', 'jange', 2),
(5, 'johndoe@example.com', '$2y$10$o1IVbBU.1EwhvEplzqwRm.le3o5Oz/8M.Gi7zUaxCxwGtZrj1.G/i', 'DOE', 'John', 2),
(6, 'jBlick@hyzeuf.com', '$2y$10$M526jBo16cROl6OcEFM8r.ZSE0SqMDyTzJ6xnOYoUjelVfX03yNDq', 'Blick', 'Juliet', 2);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
