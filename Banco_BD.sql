create database BancoDB;
use BancoDB;

create table Sucursal (
    Id int auto_increment,
    Nombre varchar(30) not null,
    Direccion varchar(50) not null,
    Ciudad varchar(30) not null,
    Codigo_postal varchar(10),
    Telefono varchar(10),
    primary key (Id),
    constraint Sucursal_UC unique(Nombre, Direccion)
);
insert into Sucursal values
(1,'Bancolombia_1','Av 15 cll 20 10-14','Bogota','0101','3217493247'),
(2,'Bancolombia_2','Av 17 cll 15 20-10','Medellin','0102','3246789076'),
(3,'Bancolombia_3','Av 20 cll 17 08-15','Cali','0103','3457890983'),
(4,'Bancolombia_4','Av 27 cll 30 15-09','Cucuta','0104','3759203048'),
(5,'Bancolombia_5','Av 30 cll 27 18-20','Barranquilla','0105','3238495020');


create table Departamento (
    Id int auto_increment,
    Nombre varchar(30) not null,
    Descripcion varchar(200),
    primary key(Id),
    constraint Departamento_UC unique(Nombre)
);

insert into Departamento values
(1,'Credito y prestamos','Solicitudes y aprobacion de prestamos Clientes individuales y empresas'),
(2,'Cuentas y depositos','Administrar cuentas corriente,ahorro y depositos'),
(3,'Tesoreria','Gestionar Flujo de efectivo e inversionnes'),
(4,'Atencion al cliente','Gestionar relaciones con los clientes quejas consultas y reclamaciones'),
(5,'Recursos Humanos','Gestionar personal y autorizar contratacion,formacion,desarrollo y bienestar de los empleados');


create table Cargo (
    Id int auto_increment,	
    Nombre varchar(20) not null,
    Descripcion varchar(30),
    Departamento_Id int,
    primary key(Id),
    constraint Empleado_Cargo_FK foreign key(Departamento_id) references Departamento(Id),
    constraint  Cargo_UC unique(Nombre)
);



create table Cliente (
	Id int auto_increment,
    Nombre varchar(20) not null,
    Apellido varchar(20) not null,
    Cedula varchar(20) not null ,
    Direccion varchar(30),
    Telefono varchar(10),
    Correo varchar(10),
    Fecha_registro date not null default(current_date()),
    primary key(Id),
    constraint Cliente_UC Unique(Cedula)
);



create table Empleado (
    Id int auto_increment ,
    Nombre varchar(20) not null,
    Apellido varchar(20) not null,
    Cedula varchar(10) not null,
    Puesto varchar(30),
    Salario decimal(8,2),
    Fecha_Contratacion date not null default(current_date()),
    Cargo_Id INT,
    primary key(Id),
    constraint Empleado_UC unique(Cedula),
    constraint Empleado_Cargo_FK foreign key(Cargo_id) references Cargo(Id)
);



create table Sucursal_Departamento (
    Sucursal_Id int,
    Departamento_Id int,
    constraint Sucursal_FK foreign key(Sucursal_Id) references Sucursal(Id),
    constraint Departamento_FK foreign key(Departamento_Id) references Departamento(Id)
);
drop table Sucursal_Departamento;


create table Cuenta (
    Id int auto_increment ,
    Numero_Cuenta varchar(20) not null,
    Tipo_Cuenta enum('Ahorros', 'Corriente') not null,
    Saldo decimal(15, 2) not null default 0,
    Fecha_Apertura date not null default (current_date()),
    Cliente_Id int,
    Sucursal_Id int,
    primary key(Id),
    constraint Cuenta_UC unique(Numero_Cuenta),
    constraint Cuenta_Cliente_FK foreign key (Cliente_Id) references Cliente(Id),
    constraint Cuenta_Sucursal_FK foreign key(Sucursal_Id) references Sucursal(Id)
);



create table Transaccion (
    Id int auto_increment ,
    Tipo_Transaccion enum('Depósito', 'Retiro', 'Transferencia') not null,
    Monto decimal(15, 2) not null,
    Fecha_Transaccion timestamp default current_timestamp,
    Cuenta_Destino_Id INT,
    Primary Key(Id),
    constraint Transaccion_Cuenta_Destino_FK foreign key(Cuenta_Destino_Id) references Cuenta(Id)
);



create table Prestamo (
    Id int auto_increment,
    Monto decimal(15, 2) not null,
    Tasa_Interes decimal(5, 2) not null,
    Fecha_Inicio date not null,
    Fecha_Fin date not null,
    Cuenta_Id int,
    primary key(Id),
    constraint Prestamo_Cuenta_FK foreign key(Cuenta_Id) references Cuenta(Id)
);



create table Tarjeta_Credito (
    Id int auto_increment,
    Numero_Tarjeta varchar(20) not null unique,
    Limite_Credito decimal(15, 2) not null,
    Fecha_Emision date not null,
    Fecha_Expiracion date not null,
    Cuenta_Id int,
    primary key(Id),
    constraint Tarjeta_Credito_Cuenta_FK foreign key (Cuenta_Id) references Cuenta(Id)
);



DELIMITER //

CREATE TRIGGER Un_Gerente_Por_Sucursal
BEFORE INSERT ON Empleado
FOR EACH ROW
BEGIN
    DECLARE num_gerentes INT;
    IF NEW.cargo_id = (SELECT cargo_id FROM Cargo WHERE nombre = 'Gerente') THEN
        SELECT COUNT(*) INTO num_gerentes 
        FROM Empleado
        WHERE cargo_id = (SELECT cargo_id FROM Cargo WHERE nombre = 'Gerente')
          AND sucursal_id = NEW.sucursal_id;
        IF num_gerentes >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Solo puede haber un gerente por sucursal';
        END IF;
    END IF;
END;
//
DELIMITER ;

DELIMITER //

CREATE TRIGGER Limite_Cuentas_Por_Cliente
BEFORE INSERT ON Cuenta
FOR EACH ROW
BEGIN
    DECLARE num_cuentas INT;
    SELECT COUNT(*) INTO num_cuentas
    FROM Cuenta
    WHERE cliente_id = NEW.cliente_id
      AND tipo_cuenta = NEW.tipo_cuenta
      AND sucursal_id = NEW.sucursal_id;
    IF num_cuentas >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un cliente no puede tener más de 3 cuentas del mismo tipo en la misma sucursal';
    END IF;
END;
//
DELIMITER ;

DELIMITER //

CREATE TRIGGER Un_Jefe_Por_Departamento
BEFORE INSERT ON Sucursal_Departamento
FOR EACH ROW
BEGIN
    DECLARE num_jefes INT;
    SELECT COUNT(*) INTO num_jefes
    FROM Sucursal_Departamento
    WHERE departamento_id = NEW.departamento_id
      AND sucursal_id = NEW.sucursal_id
      AND jefe_id IS NOT NULL;
    IF num_jefes >= 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo puede haber un jefe por departamento en cada sucursal';
    END IF;
END;
//
DELIMITER ;