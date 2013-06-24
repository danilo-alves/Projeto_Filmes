-- MySQL dump 10.13  Distrib 5.5.27, for osx10.6 (i386)
--
-- Host: localhost    Database: Projeto_Filmes
-- ------------------------------------------------------
-- Server version	5.5.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Avaliacao`
--

DROP TABLE IF EXISTS `Avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Avaliacao` (
  `Id_Filme` int(11) NOT NULL,
  `Id_Usuario` int(11) NOT NULL,
  KEY `FK50A7F079F141767E` (`Id_Filme`),
  KEY `FK50A7F079FCCCE718` (`Id_Usuario`),
  CONSTRAINT `FK50A7F079F141767E` FOREIGN KEY (`Id_Filme`) REFERENCES `tbl_Filme` (`Id_Filme`),
  CONSTRAINT `FK50A7F079FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Avaliacao`
--

LOCK TABLES `Avaliacao` WRITE;
/*!40000 ALTER TABLE `Avaliacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `Avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario_Grupo`
--

DROP TABLE IF EXISTS `Usuario_Grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario_Grupo` (
  `Id_Usuario` int(11) NOT NULL,
  `Id_Grupo` int(11) NOT NULL,
  KEY `FK7A8B07D8FCCCE718` (`Id_Usuario`),
  KEY `FK7A8B07D8F166188E` (`Id_Grupo`),
  CONSTRAINT `FK7A8B07D8F166188E` FOREIGN KEY (`Id_Grupo`) REFERENCES `tbl_Grupo` (`Id_Grupo`),
  CONSTRAINT `FK7A8B07D8FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario_Grupo`
--

LOCK TABLES `Usuario_Grupo` WRITE;
/*!40000 ALTER TABLE `Usuario_Grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `Usuario_Grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Avaliacao`
--

DROP TABLE IF EXISTS `tbl_Avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Avaliacao` (
  `Id_Avaliacao` int(11) NOT NULL AUTO_INCREMENT,
  `Nota` int(11) DEFAULT NULL,
  `Critica` varchar(300) DEFAULT NULL,
  `Id_Filme` int(11) DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  `Pontuacao` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Avaliacao`),
  KEY `FKCDC49538F141767E` (`Id_Filme`),
  KEY `FKCDC49538FCCCE718` (`Id_Usuario`),
  CONSTRAINT `FKCDC49538F141767E` FOREIGN KEY (`Id_Filme`) REFERENCES `tbl_Filme` (`Id_Filme`),
  CONSTRAINT `FKCDC49538FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Avaliacao`
--

LOCK TABLES `tbl_Avaliacao` WRITE;
/*!40000 ALTER TABLE `tbl_Avaliacao` DISABLE KEYS */;
INSERT INTO `tbl_Avaliacao` VALUES (1,5,'bom filme',1,1,76),(2,5,'Power Ranger is the best',1,1,1),(3,3,'Power Ranger is the best',1,1,-1),(4,3,'blabalbal',1,1,1),(5,3,'blabalbal',1,1,1),(6,3,'sdadaslkdja askldja dklasjd aslk',1,1,NULL),(7,1,'askdaklajskdlada',1,1,NULL);
/*!40000 ALTER TABLE `tbl_Avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Comentario`
--

DROP TABLE IF EXISTS `tbl_Comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Comentario` (
  `Id_Comentario` int(11) NOT NULL AUTO_INCREMENT,
  `Comentario` varchar(100) DEFAULT NULL,
  `Data` datetime DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  `Id_Filme` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Comentario`),
  KEY `FK3B57B722F141767E` (`Id_Filme`),
  KEY `FK3B57B722FCCCE718` (`Id_Usuario`),
  CONSTRAINT `FK3B57B722F141767E` FOREIGN KEY (`Id_Filme`) REFERENCES `tbl_Filme` (`Id_Filme`),
  CONSTRAINT `FK3B57B722FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Comentario`
--

LOCK TABLES `tbl_Comentario` WRITE;
/*!40000 ALTER TABLE `tbl_Comentario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_Comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Filme`
--

DROP TABLE IF EXISTS `tbl_Filme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Filme` (
  `Id_Filme` int(11) NOT NULL AUTO_INCREMENT,
  `Titulo` varchar(100) DEFAULT NULL,
  `Ano` int(11) DEFAULT NULL,
  `Duracao` int(11) DEFAULT NULL,
  `Sinopse` varchar(2000) DEFAULT NULL,
  `Trailer` varchar(500) DEFAULT NULL,
  `Data_Adicao` date DEFAULT NULL,
  `NotaMedia` float DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  `Id_Genero` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Filme`),
  KEY `FKEA7EA780FCCCE718` (`Id_Usuario`),
  KEY `FKEA7EA78039E7E7E8` (`Id_Genero`),
  CONSTRAINT `FKEA7EA78039E7E7E8` FOREIGN KEY (`Id_Genero`) REFERENCES `tbl_Genero` (`Id_Genero`),
  CONSTRAINT `FKEA7EA780FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Filme`
--

LOCK TABLES `tbl_Filme` WRITE;
/*!40000 ALTER TABLE `tbl_Filme` DISABLE KEYS */;
INSERT INTO `tbl_Filme` VALUES (1,'Circulo de Fogo',2013,60,'																					O filme mostrará a batalha dos humanos contra criaturas monstruosas chamadas Kaiju - o termo que designa os monstros colossais do cinema japonês. Para combater os inimigos, os homens criaram uma arma especial, os Jaegers - robôs gigantes que são controlados por dois pilotos cujas mentes fica\r\n						\r\n						\r\n						\r\n						','A0Bc461CCLU','2013-06-23',8.89286,1,1);
/*!40000 ALTER TABLE `tbl_Filme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Genero`
--

DROP TABLE IF EXISTS `tbl_Genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Genero` (
  `Id_Genero` int(11) NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id_Genero`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Genero`
--

LOCK TABLES `tbl_Genero` WRITE;
/*!40000 ALTER TABLE `tbl_Genero` DISABLE KEYS */;
INSERT INTO `tbl_Genero` VALUES (1,'Ação'),(2,'Comédia'),(3,'Drama'),(4,'Suspense');
/*!40000 ALTER TABLE `tbl_Genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Grupo`
--

DROP TABLE IF EXISTS `tbl_Grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Grupo` (
  `Id_Grupo` int(11) NOT NULL AUTO_INCREMENT,
  `Nome_Grupo` varchar(100) DEFAULT NULL,
  `Descricao` varchar(2000) DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Grupo`),
  KEY `FKEA90F888FCCCE718` (`Id_Usuario`),
  CONSTRAINT `FKEA90F888FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Grupo`
--

LOCK TABLES `tbl_Grupo` WRITE;
/*!40000 ALTER TABLE `tbl_Grupo` DISABLE KEYS */;
INSERT INTO `tbl_Grupo` VALUES (1,'Pacific Rim Fans','  fan fan fan fan fan fan fab again dalkdaskldaj skldajs dkla ',1),(2,'Star Wars Fan Boy','    Star Wars is an American epic space opera franchise centered on a film series created by George Lucas. boa blab blab ',1),(3,'Super Homem Fan Group','     suppepepepepe saakldasjkdlasj daklsjd askldja ',1),(4,'dasdasdas',' ',32);
/*!40000 ALTER TABLE `tbl_Grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Imagem`
--

DROP TABLE IF EXISTS `tbl_Imagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Imagem` (
  `Id_Imagem` int(11) NOT NULL AUTO_INCREMENT,
  `Imagem_Path` varchar(300) DEFAULT NULL,
  `Id_Filme` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Imagem`),
  KEY `FK6AA81A33F141767E` (`Id_Filme`),
  CONSTRAINT `FK6AA81A33F141767E` FOREIGN KEY (`Id_Filme`) REFERENCES `tbl_Filme` (`Id_Filme`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Imagem`
--

LOCK TABLES `tbl_Imagem` WRITE;
/*!40000 ALTER TABLE `tbl_Imagem` DISABLE KEYS */;
INSERT INTO `tbl_Imagem` VALUES (1,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER1/circulofogo6.jpeg',1);
/*!40000 ALTER TABLE `tbl_Imagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ImagemGrupo`
--

DROP TABLE IF EXISTS `tbl_ImagemGrupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_ImagemGrupo` (
  `Id_Imagem` int(11) NOT NULL AUTO_INCREMENT,
  `Imagem_Path` varchar(300) DEFAULT NULL,
  `Id_Grupo` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Imagem`),
  KEY `FKB77D69F6F166188E` (`Id_Grupo`),
  CONSTRAINT `FKB77D69F6F166188E` FOREIGN KEY (`Id_Grupo`) REFERENCES `tbl_Grupo` (`Id_Grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ImagemGrupo`
--

LOCK TABLES `tbl_ImagemGrupo` WRITE;
/*!40000 ALTER TABLE `tbl_ImagemGrupo` DISABLE KEYS */;
INSERT INTO `tbl_ImagemGrupo` VALUES (6,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER1/superman8.jpg',1),(7,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER1/superman4.jpg',3),(8,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER1/neutrino-azul1.jpeg',2);
/*!40000 ALTER TABLE `tbl_ImagemGrupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ImagemUsuario`
--

DROP TABLE IF EXISTS `tbl_ImagemUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_ImagemUsuario` (
  `Id_Imagem` int(11) NOT NULL AUTO_INCREMENT,
  `Imagem_Path` varchar(300) DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Imagem`),
  KEY `FKB410217BFCCCE718` (`Id_Usuario`),
  CONSTRAINT `FKB410217BFCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ImagemUsuario`
--

LOCK TABLES `tbl_ImagemUsuario` WRITE;
/*!40000 ALTER TABLE `tbl_ImagemUsuario` DISABLE KEYS */;
INSERT INTO `tbl_ImagemUsuario` VALUES (1,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER29/computron.jpg',29),(2,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER30/object4.jpg',30),(3,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER31/object1.png',31),(5,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER1/computron7.jpg',1),(6,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER32/computron.jpg',32),(7,'/Applications/ColdFusion10/cfusion/wwwroot/Projeto_Filmes/UserData/USER33/computron.jpg',33);
/*!40000 ALTER TABLE `tbl_ImagemUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ListaDesejo`
--

DROP TABLE IF EXISTS `tbl_ListaDesejo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_ListaDesejo` (
  `Id_Lista` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Filme` int(11) DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Lista`),
  KEY `FK405C2D5AF141767E` (`Id_Filme`),
  KEY `FK405C2D5AFCCCE718` (`Id_Usuario`),
  CONSTRAINT `FK405C2D5AF141767E` FOREIGN KEY (`Id_Filme`) REFERENCES `tbl_Filme` (`Id_Filme`),
  CONSTRAINT `FK405C2D5AFCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ListaDesejo`
--

LOCK TABLES `tbl_ListaDesejo` WRITE;
/*!40000 ALTER TABLE `tbl_ListaDesejo` DISABLE KEYS */;
INSERT INTO `tbl_ListaDesejo` VALUES (1,1,1);
/*!40000 ALTER TABLE `tbl_ListaDesejo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Resenha`
--

DROP TABLE IF EXISTS `tbl_Resenha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Resenha` (
  `Id_Resenha` int(11) NOT NULL AUTO_INCREMENT,
  `Conteudo` varchar(300) DEFAULT NULL,
  `Status` double DEFAULT NULL,
  `Id_Filme` int(11) DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Resenha`),
  KEY `FKB9C95C61F141767E` (`Id_Filme`),
  KEY `FKB9C95C61FCCCE718` (`Id_Usuario`),
  CONSTRAINT `FKB9C95C61F141767E` FOREIGN KEY (`Id_Filme`) REFERENCES `tbl_Filme` (`Id_Filme`),
  CONSTRAINT `FKB9C95C61FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Resenha`
--

LOCK TABLES `tbl_Resenha` WRITE;
/*!40000 ALTER TABLE `tbl_Resenha` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_Resenha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Usuario`
--

DROP TABLE IF EXISTS `tbl_Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Usuario` (
  `Id_Usuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Senha` varchar(255) DEFAULT NULL,
  `Descricao` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id_Usuario`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Usuario`
--

LOCK TABLES `tbl_Usuario` WRITE;
/*!40000 ALTER TABLE `tbl_Usuario` DISABLE KEYS */;
INSERT INTO `tbl_Usuario` VALUES (1,'Danilo Alves de Jesus','daniloaj@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220','adakjhdasjk'),(3,'Maria','maria@mail.com','40BD001563085FC35165329EA1FF5C5ECBDBBEEF',NULL),(4,'Maria','mama@mail.com','7B52009B64FD0A2A49E6D8A939753077792B0554',NULL),(5,'teste','teste@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220',NULL),(6,'t2','t2@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220',NULL),(7,'t4','t4@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220',NULL),(8,'Valmir','valmir@mail.com','40BD001563085FC35165329EA1FF5C5ECBDBBEEF',NULL),(9,'Helton','tiozao@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220',NULL),(10,'Joao','joao@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220',NULL),(29,'user','user@mail.com','40BD001563085FC35165329EA1FF5C5ECBDBBEEF',NULL),(30,'Cleide','cleide@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220',NULL),(31,'user3','user3@mail.com','7110EDA4D09E062AA5E4A390B0A572AC0D2C0220',NULL),(32,'Admin','admin@mail.com','D033E22AE348AEB5660FC2140AEC35850C4DA997','							\r\n						'),(33,'José de Almeida','jose@mail.com','4A3487E57D90E2084654B6D23937E75AF5C8EE55','							\r\n						');
/*!40000 ALTER TABLE `tbl_Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Usuario_Grupo`
--

DROP TABLE IF EXISTS `tbl_Usuario_Grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_Usuario_Grupo` (
  `idUsrGrp` int(11) NOT NULL AUTO_INCREMENT,
  `Data` date DEFAULT NULL,
  `Id_Grupo` int(11) DEFAULT NULL,
  `Id_Usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsrGrp`),
  KEY `FK1B393517FCCCE718` (`Id_Usuario`),
  KEY `FK1B393517F166188E` (`Id_Grupo`),
  CONSTRAINT `FK1B393517F166188E` FOREIGN KEY (`Id_Grupo`) REFERENCES `tbl_Grupo` (`Id_Grupo`),
  CONSTRAINT `FK1B393517FCCCE718` FOREIGN KEY (`Id_Usuario`) REFERENCES `tbl_Usuario` (`Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Usuario_Grupo`
--

LOCK TABLES `tbl_Usuario_Grupo` WRITE;
/*!40000 ALTER TABLE `tbl_Usuario_Grupo` DISABLE KEYS */;
INSERT INTO `tbl_Usuario_Grupo` VALUES (1,'2013-06-21',1,1),(3,'2013-06-23',1,30),(6,'2013-06-23',2,30),(18,'2013-06-23',2,1),(21,'2013-06-23',3,1);
/*!40000 ALTER TABLE `tbl_Usuario_Grupo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-24 17:58:26
