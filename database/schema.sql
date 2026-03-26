CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `idAutor` int NOT NULL,
  `ime_prezime` varchar(45) NOT NULL,
  PRIMARY KEY (`idAutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clan`
--

DROP TABLE IF EXISTS `clan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clan` (
  `idClan` int NOT NULL,
  `ime_prezime` varchar(45) NOT NULL,
  PRIMARY KEY (`idClan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `izdavac`
--

DROP TABLE IF EXISTS `izdavac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `izdavac` (
  `idIzdavac` int NOT NULL,
  `naziv` varchar(45) NOT NULL,
  PRIMARY KEY (`idIzdavac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jezik`
--

DROP TABLE IF EXISTS `jezik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jezik` (
  `idJezik` int NOT NULL,
  `naziv` varchar(45) NOT NULL,
  PRIMARY KEY (`idJezik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knjiga`
--

DROP TABLE IF EXISTS `knjiga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knjiga` (
  `idKnjiga` int NOT NULL,
  `naziv` varchar(45) DEFAULT NULL,
  `brojStranica` int DEFAULT NULL,
  `Jezik_idJezik` int NOT NULL,
  `Izdavac_idIzdavac` int NOT NULL,
  PRIMARY KEY (`idKnjiga`),
  UNIQUE KEY `idKnjiga` (`idKnjiga`),
  KEY `fk_Knjiga_Jezik1_idx` (`Jezik_idJezik`),
  KEY `fk_Knjiga_Izdavac1_idx` (`Izdavac_idIzdavac`),
  CONSTRAINT `fk_Knjiga_Izdavac1` FOREIGN KEY (`Izdavac_idIzdavac`) REFERENCES `izdavac` (`idIzdavac`),
  CONSTRAINT `fk_Knjiga_Jezik1` FOREIGN KEY (`Jezik_idJezik`) REFERENCES `jezik` (`idJezik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knjiga_autor`
--

DROP TABLE IF EXISTS `knjiga_autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knjiga_autor` (
  `Knjiga_idKnjiga` int NOT NULL,
  `Autor_idAutor` int NOT NULL,
  PRIMARY KEY (`Knjiga_idKnjiga`,`Autor_idAutor`),
  KEY `fk_Knjiga_has_Autor_Autor1_idx` (`Autor_idAutor`),
  KEY `fk_Knjiga_has_Autor_Knjiga_idx` (`Knjiga_idKnjiga`),
  CONSTRAINT `fk_Knjiga_has_Autor_Autor1` FOREIGN KEY (`Autor_idAutor`) REFERENCES `autor` (`idAutor`),
  CONSTRAINT `fk_Knjiga_has_Autor_Knjiga` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knjiga_zanr`
--

DROP TABLE IF EXISTS `knjiga_zanr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knjiga_zanr` (
  `Knjiga_idKnjiga` int NOT NULL,
  `Zanr_idZanr` int NOT NULL,
  PRIMARY KEY (`Knjiga_idKnjiga`,`Zanr_idZanr`),
  KEY `fk_Knjiga_has_Zanr_Zanr1_idx` (`Zanr_idZanr`),
  KEY `fk_Knjiga_has_Zanr_Knjiga1_idx` (`Knjiga_idKnjiga`),
  CONSTRAINT `fk_Knjiga_has_Zanr_Knjiga1` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`),
  CONSTRAINT `fk_Knjiga_has_Zanr_Zanr1` FOREIGN KEY (`Zanr_idZanr`) REFERENCES `zanr` (`idZanr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posudba`
--

DROP TABLE IF EXISTS `posudba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posudba` (
  `idPosudba` int NOT NULL AUTO_INCREMENT,
  `datum_posudbe` date NOT NULL,
  `datum_vracanja` date DEFAULT NULL,
  `Primjerak_idPrimjerak` int NOT NULL,
  `Clan_idClan` int NOT NULL,
  `Zaposlenik_idZaposlenik` int NOT NULL,
  `rok_vracanja` date NOT NULL,
  PRIMARY KEY (`idPosudba`),
  UNIQUE KEY `idPosudba` (`idPosudba`),
  KEY `fk_Posudba_Primjerak1_idx` (`Primjerak_idPrimjerak`),
  KEY `fk_Posudba_Clan1_idx` (`Clan_idClan`),
  KEY `fk_Posudba_Zaposlenik1_idx` (`Zaposlenik_idZaposlenik`),
  CONSTRAINT `fk_Posudba_Clan1` FOREIGN KEY (`Clan_idClan`) REFERENCES `clan` (`idClan`),
  CONSTRAINT `fk_Posudba_Primjerak1` FOREIGN KEY (`Primjerak_idPrimjerak`) REFERENCES `primjerak` (`idPrimjerak`),
  CONSTRAINT `fk_Posudba_Zaposlenik1` FOREIGN KEY (`Zaposlenik_idZaposlenik`) REFERENCES `zaposlenik` (`idZaposlenik`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `primjerak`
--

DROP TABLE IF EXISTS `primjerak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `primjerak` (
  `idPrimjerak` int NOT NULL,
  `status` varchar(45) NOT NULL,
  `Knjiga_idKnjiga` int NOT NULL,
  PRIMARY KEY (`idPrimjerak`),
  UNIQUE KEY `idPrimjerak` (`idPrimjerak`),
  KEY `fk_Primjerak_Knjiga1_idx` (`Knjiga_idKnjiga`),
  CONSTRAINT `fk_Primjerak_Knjiga1` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zakasnina`
--

DROP TABLE IF EXISTS `zakasnina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zakasnina` (
  `idZakasnina` int NOT NULL AUTO_INCREMENT,
  `Posudba_idPosudba` int NOT NULL,
  PRIMARY KEY (`idZakasnina`),
  KEY `fk_Zakasnina_Posudba1_idx` (`Posudba_idPosudba`),
  CONSTRAINT `fk_Zakasnina_Posudba1` FOREIGN KEY (`Posudba_idPosudba`) REFERENCES `posudba` (`idPosudba`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zanr`
--

DROP TABLE IF EXISTS `zanr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zanr` (
  `idZanr` int NOT NULL,
  `naziv` varchar(45) NOT NULL,
  PRIMARY KEY (`idZanr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zaposlenik`
--

DROP TABLE IF EXISTS `zaposlenik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zaposlenik` (
  `idZaposlenik` int NOT NULL,
  `ime_prezime` varchar(45) NOT NULL,
  PRIMARY KEY (`idZaposlenik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-26 13:30:10
