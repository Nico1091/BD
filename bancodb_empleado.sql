-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bancodb
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Cedula` varchar(10) NOT NULL,
  `Puesto` varchar(100) DEFAULT NULL,
  `Salario` int DEFAULT NULL,
  `Fecha_Contratacion` date NOT NULL DEFAULT (curdate()),
  `Cargo_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Empleado_UC` (`Cedula`),
  KEY `Empleado_Cargo_FK` (`Cargo_Id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Jose','Casanares','3425167283','Oficial de credito',5000000,'2024-10-14',1),(2,'Luis','Bedoya','3678902671','Gerente de credito',4000000,'2024-10-14',2),(3,'Angel','Villareal','3547725367','Analista de credito',2039999,'2024-10-14',3),(4,'Pedro','Cardenas','3648593784','Gerente de cuentas',6000000,'2024-10-14',4),(5,'Andres','Escobar','3546783922','Ejecutivo de cuentas',5000000,'2024-10-14',5),(6,'Jaime','Pedraza','3657848932','Asesor de cuentas',2000000,'2024-10-14',6),(7,'Jorge','Aleman','3546728931','Tesoreria general',2536000,'2024-10-14',7),(8,'Carlos','Brand','3789037380','Gerente de tesoreria',2333444,'2024-10-14',8),(9,'Juan','Conriquez','3546783679','Trader de tesoreria',3455431,'2024-10-14',9),(10,'Andrea','Guzman','3547378290','Gerente de servicio al cliente',34667890,'2024-10-14',10),(11,'Freimer','Escamilla','3456782923','Representante de atencion al cliente',4562343,'2024-10-15',11),(12,'Sebastian','Alarcon','3457890267','Asesor de servicio al cliente',4536678,'2024-10-15',12),(13,'Lina','Tejeiro','3567489567','Director de recursos humanos',2436893,'2024-10-15',13),(14,'Roller','Sierra','3567890456','Gerente de recursos Humanos',2349098,'2024-10-15',14),(15,'Carla','Camacaro','3456789098','Especialista en reclutamiento y seleccion',3600000,'2024-10-15',15);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-17  2:01:27
