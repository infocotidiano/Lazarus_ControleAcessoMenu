-- MySQL dump 10.15  Distrib 10.0.38-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: exemplo_controle_acesso_menu
-- ------------------------------------------------------
-- Server version	10.0.38-MariaDB

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
-- Table structure for table `crt_menu`
--

DROP TABLE IF EXISTS `crt_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crt_menu` (
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(150) DEFAULT NULL,
  `nivel` int(1) DEFAULT NULL,
  `indice` int(11) DEFAULT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crt_menu`
--

LOCK TABLES `crt_menu` WRITE;
/*!40000 ALTER TABLE `crt_menu` DISABLE KEYS */;
INSERT INTO `crt_menu` VALUES ('MenuItem1','Cadastros',1,0),('MenuItem10','   --Produto',1,4),('MenuItem11','   --Abre Caixa',1,6),('MenuItem12','   --Venda',1,7),('MenuItem13','   --Sangria',1,8),('MenuItem14','   --ReforÃ§o',1,9),('MenuItem15','   --Fecha Caixa',1,10),('MenuItem16','   --Rel Vendas PerÃ­odo',1,11),('MenuItem17','   --Rel Cupom Cancelado',1,12),('MenuItem18','   --Emite NFe',1,14),('MenuItem19','   --Rel NFe Emitidas Periodo',1,15),('MenuItem2','PDV',1,5),('MenuItem20','   --Rel NFe Canceladas',1,16),('MenuItem21','   --Entrada de Produto',2,18),('MenuItem22','   --Acerto de Estoque',2,19),('MenuItem23','   --Inventario',1,20),('MenuItem24','   --Cadastro Usuario',1,22),('MenuItem25','   --PermissÃµes',5,23),('MenuItem3','NFe',1,13),('MenuItem4','Estoque',1,17),('MenuItem5','Usuarios',1,21),('MenuItem6','Sair',1,24),('MenuItem7','   --Clientes',1,1),('MenuItem8','   --Fornecedores',1,2),('MenuItem9','   --Grupo de produto',1,3);
/*!40000 ALTER TABLE `crt_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctrl_usuario`
--

DROP TABLE IF EXISTS `ctrl_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctrl_usuario` (
  `nome` varchar(20) NOT NULL,
  `senha` varchar(20) DEFAULT NULL,
  `nivel` int(11) DEFAULT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctrl_usuario`
--

LOCK TABLES `ctrl_usuario` WRITE;
/*!40000 ALTER TABLE `ctrl_usuario` DISABLE KEYS */;
INSERT INTO `ctrl_usuario` VALUES ('admin','admin',9),('caixa','1234',1),('gerente','1234',2);
/*!40000 ALTER TABLE `ctrl_usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-16 12:41:51
