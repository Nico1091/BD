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
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(70) NOT NULL,
  `Descripcion` varchar(300) DEFAULT NULL,
  `Departamento_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Cargo_UC` (`Nombre`),
  KEY `Empleado_Cargo_FK` (`Departamento_Id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES (1,'oficial de credito','Asesora los clientes sobre productos crediticios',1),(2,'Gerente de credito','Supervisa el proceso de otrorgar credito y prestamos',1),(3,'Analista de credito','Evalua y analiza el proceso para otorgar creditos al cliente ademas de realizar informes',1),(4,'Gerente de cuentas','Supervisa operaciones relacionadas  con las cuentas  del cliente',2),(5,'Ejecutivo de cuentas','Asiste a los clientes en apertura y administracion de cuentas bancarias  ademas de explicar las opciones que ofrece el banco para el rano y uso de las mismas',2),(6,'Asesor de cuentas','Asesora personalmente a los clientes para escoger la cuenta adaptada a sus necesidades ademas de mostrar tasas de interes  y tarifas acorde al uso de las mismas',2),(7,'Tesoreria General','Supervisa la liquidez de las inversionnes Bancarias',3),(8,'Gerente de tesoreria','Gestionas las inversiones y transacciones en los mercados coordina operaciones diarias y se asegura de la liquidez bancaria',3),(9,'Trader de tesoreria','Ejecuta operaciones en el mercado financiero,compra y vende activos como bonos y divisas y otros instrumentos para gestionar riesgos  y mejorar rentabilidad',3),(10,'Gerente de servicio al cliente','Supervisa la calidad de atencion al cliente a partir del personal ademas de establecer politicas y procedimientos para mejorar la satisfacion al cliente',4),(11,'Representante de atencion al cliente','Punto de contacto con el cliente en fisico o de manera virtual,Atiende consultas  sobre productos y servicios,cuentas bancarias,tarjetas de credito y prestamos',4),(12,'Asesor de servicio al cliente','Ofrece asesoramiennto personalizado a los clientes para la comprension de sus propias inversiones ademas de ofrecer soluciones y recomendaciones adecuadas al usuario',4),(13,'Director de recursos Humanos','Responsable de la gestion global, define la estrategia de recursos humanos,se alinea con las necesidades de los empleados',5),(14,'Gerente de recursos Humanos','Supervisa las operaciones diarias del departamento de Recursos Humanos(RR.HH),se encarga de implementar politicas de contratacion formacion y compensacion, Gestionamiento de relaciones en el area empresarial',5),(15,'Especialista en reclutamiento y seleccion','Gestiona todo el proceso de contratacion desde la busqueda de candidatos hasta laentrevista y seleccion,Colabora  con los departamenntos del banco para verificar el personal que le es requerido',5);
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-17  2:01:29
