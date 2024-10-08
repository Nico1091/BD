CREATE DATABASE BancoDB;
USE BancoDB;

CREATE TABLE Sucursal (
    sucursal_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    CONSTRAINT UC_Sucursal UNIQUE (nombre, direccion)
);

CREATE TABLE Departamento (
    departamento_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

CREATE TABLE Cargo (
    cargo_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);



CREATE TABLE Cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    identificacion VARCHAR(20) NOT NULL UNIQUE,
    direccion VARCHAR(150),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    fecha_registro DATE NOT NULL DEFAULT (CURRENT_DATE())
);

CREATE TABLE Empleado (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    identificacion VARCHAR(20) NOT NULL UNIQUE,
    puesto VARCHAR(50),
    salario DECIMAL(10, 2),
    fecha_contratacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    sucursal_id INT,
    departamento_id INT,
    cargo_id INT,
    CONSTRAINT FK_Empleado_Sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id),
    CONSTRAINT FK_Empleado_Departamento FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id),
    CONSTRAINT FK_Empleado_Cargo FOREIGN KEY (cargo_id) REFERENCES Cargo(cargo_id)
);

CREATE TABLE Sucursal_Departamento (
    sucursal_id INT,
    departamento_id INT,
    jefe_id INT, -- Relaciona el jefe del departamento, si aplica
    CONSTRAINT FK_Sucursal_Departamento_Sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id),
    CONSTRAINT FK_Sucursal_Departamento_Departamento FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id),
    CONSTRAINT FK_Sucursal_Departamento_Jefe FOREIGN KEY (jefe_id) REFERENCES Empleado(empleado_id)
);

CREATE TABLE Cuenta (
    cuenta_id INT AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta VARCHAR(20) NOT NULL UNIQUE,
    tipo_cuenta ENUM('Ahorros', 'Corriente') NOT NULL,
    saldo DECIMAL(15, 2) NOT NULL DEFAULT 0,
    fecha_apertura DATE NOT NULL DEFAULT (CURRENT_DATE()),
    cliente_id INT,
    sucursal_id INT,
    CONSTRAINT FK_Cuenta_Cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    CONSTRAINT FK_Cuenta_Sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

CREATE TABLE Transaccion (
    transaccion_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_transaccion ENUM('Depósito', 'Retiro', 'Transferencia') NOT NULL,
    monto DECIMAL(15, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cuenta_origen_id INT,
    cuenta_destino_id INT,
    empleado_id INT,
    CONSTRAINT FK_Transaccion_CuentaOrigen FOREIGN KEY (cuenta_origen_id) REFERENCES Cuenta(cuenta_id),
    CONSTRAINT FK_Transaccion_CuentaDestino FOREIGN KEY (cuenta_destino_id) REFERENCES Cuenta(cuenta_id),
    CONSTRAINT FK_Transaccion_Empleado FOREIGN KEY (empleado_id) REFERENCES Empleado(empleado_id)
);

CREATE TABLE Prestamo (
    prestamo_id INT AUTO_INCREMENT PRIMARY KEY,
    monto DECIMAL(15, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    cliente_id INT,
    sucursal_id INT,
    CONSTRAINT FK_Prestamo_Cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    CONSTRAINT FK_Prestamo_Sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

CREATE TABLE PagoPrestamo (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    prestamo_id INT,
    monto_pagado DECIMAL(15, 2) NOT NULL,
    fecha_pago DATE NOT NULL DEFAULT (CURRENT_DATE()),
    cuenta_id INT,
    CONSTRAINT FK_PagoPrestamo_Prestamo FOREIGN KEY (prestamo_id) REFERENCES Prestamo(prestamo_id),
    CONSTRAINT FK_PagoPrestamo_Cuenta FOREIGN KEY (cuenta_id) REFERENCES Cuenta(cuenta_id)
);

CREATE TABLE TarjetaCredito (
    tarjeta_id INT AUTO_INCREMENT PRIMARY KEY,
    numero_tarjeta VARCHAR(20) NOT NULL UNIQUE,
    limite_credito DECIMAL(15, 2) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_expiracion DATE NOT NULL,
    cliente_id INT,
    sucursal_id INT,
    CONSTRAINT FK_TarjetaCredito_Cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    CONSTRAINT FK_TarjetaCredito_Sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

CREATE TABLE PagoTarjetaCredito (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    tarjeta_id INT,
    monto_pagado DECIMAL(15, 2) NOT NULL,
    fecha_pago DATE NOT NULL DEFAULT (CURRENT_DATE()),
    cuenta_id INT,
    CONSTRAINT FK_PagoTarjetaCredito_Tarjeta FOREIGN KEY (tarjeta_id) REFERENCES TarjetaCredito(tarjeta_id),
    CONSTRAINT FK_PagoTarjetaCredito_Cuenta FOREIGN KEY (cuenta_id) REFERENCES Cuenta(cuenta_id)
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