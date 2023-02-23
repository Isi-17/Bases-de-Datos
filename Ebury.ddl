-- Generado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   en:        2022-01-24 20:36:09 CET
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE banco (
    nombre_banco            VARCHAR2(25 CHAR) NOT NULL,
    tipo_banco              VARCHAR2(25 CHAR),
    pais_abrebiatura        VARCHAR2(25 CHAR) NOT NULL,
    direccion_código_postal INTEGER NOT NULL
);

CREATE UNIQUE INDEX banco__idx ON
    banco (
        direccion_código_postal
    ASC );

ALTER TABLE banco ADD CONSTRAINT banco_pk PRIMARY KEY ( nombre_banco );

CREATE TABLE cliente (
    identificador           INTEGER NOT NULL,
    activo                  CHAR(1) NOT NULL,
    fecha_apertura          DATE,
    fecha_cierre            DATE,
    correo                  VARCHAR2(25 CHAR),
    teléfono                INTEGER,
    direccion_código_postal INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( identificador );

ALTER TABLE cliente ADD CONSTRAINT cliente_teléfono_un UNIQUE ( teléfono );

ALTER TABLE cliente ADD CONSTRAINT cliente_correo_un UNIQUE ( correo );

CREATE TABLE cr_poo (
    cuenta_referencia_iban VARCHAR2(34 CHAR) NOT NULL,
    pooled_número_cuenta   INTEGER NOT NULL
);

ALTER TABLE cr_poo ADD CONSTRAINT cr_poo_pk PRIMARY KEY ( cuenta_referencia_iban,
                                                          pooled_número_cuenta );

CREATE TABLE cuenta_ebury (
    número_cuenta         INTEGER NOT NULL,
    fecha_alta            DATE NOT NULL,
    fecha_baja            DATE,
    cliente_identificador INTEGER NOT NULL
);

ALTER TABLE cuenta_ebury ADD CONSTRAINT cuenta_ebury_pk PRIMARY KEY ( número_cuenta );

CREATE TABLE cuenta_externa (
    iban         VARCHAR2(34 CHAR) NOT NULL,
    swift        VARCHAR2(11 CHAR),
    beneficiario VARCHAR2(35 CHAR)
);

ALTER TABLE cuenta_externa ADD CONSTRAINT cuenta_externa_pk PRIMARY KEY ( iban );

CREATE TABLE cuenta_referencia (
    iban               VARCHAR2(34 CHAR) NOT NULL,
    banco_nombre_banco VARCHAR2(25 CHAR) NOT NULL
);

ALTER TABLE cuenta_referencia ADD CONSTRAINT cuenta_referencia_pk PRIMARY KEY ( iban );

CREATE TABLE currency_account (
    número_cuenta          INTEGER NOT NULL,
    cuenta_referencia_iban VARCHAR2(34 CHAR) NOT NULL
);

CREATE UNIQUE INDEX currency_account__idx ON
    currency_account (
        cuenta_referencia_iban
    ASC );

ALTER TABLE currency_account ADD CONSTRAINT currency_account_pk PRIMARY KEY ( número_cuenta );

CREATE TABLE datos (
    tipo_autorizacion      INTEGER NOT NULL,
    empresa_identificador  INTEGER NOT NULL,
    persona_autorizada_dni VARCHAR2(9 CHAR) NOT NULL
);

ALTER TABLE datos
    ADD CONSTRAINT datos_pk PRIMARY KEY ( tipo_autorizacion,
                                          empresa_identificador,
                                          persona_autorizada_dni );

CREATE TABLE direccion (
    código_postal INTEGER NOT NULL,
    calle         VARCHAR2(25 CHAR) NOT NULL,
    numero        INTEGER NOT NULL
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( código_postal );

CREATE TABLE div_trans (
    divisa_nombre_divisa           VARCHAR2(25 CHAR) NOT NULL,
    transaccion_numero_transaccion VARCHAR2(25 CHAR) NOT NULL
);

ALTER TABLE div_trans ADD CONSTRAINT div_trans_pk PRIMARY KEY ( divisa_nombre_divisa,
                                                                transaccion_numero_transaccion );

CREATE TABLE divisa (
    nombre_divisa     VARCHAR2(25 CHAR) NOT NULL,
    abreviatura       VARCHAR2(25 CHAR) NOT NULL,
    símbolo           VARCHAR2(25 CHAR) NOT NULL,
    tipo_cambio_dolar NUMBER NOT NULL
);

ALTER TABLE divisa ADD CONSTRAINT divisa_pk PRIMARY KEY ( nombre_divisa );

ALTER TABLE divisa ADD CONSTRAINT divisa_símbolo_un UNIQUE ( símbolo );

ALTER TABLE divisa ADD CONSTRAINT divisa_abreviatura_un UNIQUE ( abreviatura );

CREATE TABLE empresa (
    identificador INTEGER NOT NULL,
    nombre        INTEGER,
    razon_social  VARCHAR2(25 CHAR) NOT NULL,
    nif           VARCHAR2(25 CHAR),
    pagina_web    VARCHAR2(25 CHAR),
    teléfono      INTEGER,
    correo        VARCHAR2(25 CHAR)
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( identificador );

ALTER TABLE empresa ADD CONSTRAINT empresa_nombre_un UNIQUE ( nombre );

ALTER TABLE empresa ADD CONSTRAINT empresa_nif_un UNIQUE ( nif );

ALTER TABLE empresa ADD CONSTRAINT empresa_pagina_web_un UNIQUE ( pagina_web );

ALTER TABLE empresa ADD CONSTRAINT empresa_teléfono_un UNIQUE ( teléfono );

ALTER TABLE empresa ADD CONSTRAINT empresa_correo_un UNIQUE ( correo );

CREATE TABLE externa (
    numero_transaccion  VARCHAR2(25 CHAR) NOT NULL,
    cuenta_externa_iban VARCHAR2(34 CHAR) NOT NULL
);

ALTER TABLE externa ADD CONSTRAINT externa_pk PRIMARY KEY ( numero_transaccion );

CREATE TABLE individual (
    identificador    INTEGER NOT NULL,
    nombre           VARCHAR2(25 CHAR) NOT NULL,
    apellidos        VARCHAR2(25 CHAR) NOT NULL,
    correo           VARCHAR2(25 CHAR),
    dni              VARCHAR2(9 CHAR),
    fecha_nacimiento DATE,
    teléfono         INTEGER,
    ocupación        VARCHAR2(25 CHAR)
);

ALTER TABLE individual ADD CONSTRAINT individual_pk PRIMARY KEY ( identificador );

ALTER TABLE individual ADD CONSTRAINT individual_correo_un UNIQUE ( correo );

ALTER TABLE individual ADD CONSTRAINT individual_dni_un UNIQUE ( dni );

ALTER TABLE individual ADD CONSTRAINT individual_teléfono_un UNIQUE ( teléfono );

CREATE TABLE interna (
    numero_transaccion         VARCHAR2(25 CHAR) NOT NULL,
    comisión                   NUMBER NOT NULL,
    cuenta_ebury_número_cuenta INTEGER NOT NULL
);

ALTER TABLE interna ADD CONSTRAINT interna_pk PRIMARY KEY ( numero_transaccion );

CREATE TABLE pais (
    abrebiatura VARCHAR2(25 CHAR) NOT NULL,
    nombre_país VARCHAR2(25 CHAR) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( abrebiatura );

CREATE TABLE pais_divisa (
    divisa_nombre_divisa VARCHAR2(25 CHAR) NOT NULL,
    pais_abrebiatura     VARCHAR2(25 CHAR) NOT NULL
);

ALTER TABLE pais_divisa ADD CONSTRAINT pais_divisa_pk PRIMARY KEY ( divisa_nombre_divisa,
                                                                    pais_abrebiatura );

CREATE TABLE persona_autorizada (
    dni                     VARCHAR2(9 CHAR) NOT NULL,
    nombre                  VARCHAR2(25 CHAR),
    apellidos               VARCHAR2(25 CHAR),
    direccion_código_postal INTEGER NOT NULL
);

ALTER TABLE persona_autorizada ADD CONSTRAINT persona_autorizada_pk PRIMARY KEY ( dni );

CREATE TABLE pooled (
    número_cuenta INTEGER NOT NULL
);

ALTER TABLE pooled ADD CONSTRAINT pooled_pk PRIMARY KEY ( número_cuenta );

CREATE TABLE saldo (
    cantidad                   NUMBER NOT NULL,
    cuenta_ebury_número_cuenta INTEGER NOT NULL,
    divisa_nombre_divisa       VARCHAR2(25 CHAR) NOT NULL
);

ALTER TABLE saldo ADD CONSTRAINT saldo_pk PRIMARY KEY ( cuenta_ebury_número_cuenta,
                                                        divisa_nombre_divisa );

CREATE TABLE segregated (
    número_cuenta          INTEGER NOT NULL,
    cuenta_referencia_iban VARCHAR2(34 CHAR) NOT NULL
);

ALTER TABLE segregated ADD CONSTRAINT segregated_pk PRIMARY KEY ( número_cuenta );

CREATE TABLE transaccion (
    numero_transaccion         VARCHAR2(25 CHAR) NOT NULL,
    fecha_realización          DATE NOT NULL,
    fecha_ejecución            DATE NOT NULL,
    cantidad_enviada           NUMBER,
    cantidad_recibida          NUMBER,
    cuenta_ebury_número_cuenta INTEGER NOT NULL
);

ALTER TABLE transaccion ADD CONSTRAINT transaccion_pk PRIMARY KEY ( numero_transaccion );

ALTER TABLE banco
    ADD CONSTRAINT banco_direccion_fk FOREIGN KEY ( direccion_código_postal )
        REFERENCES direccion ( código_postal );

ALTER TABLE banco
    ADD CONSTRAINT banco_pais_fk FOREIGN KEY ( pais_abrebiatura )
        REFERENCES pais ( abrebiatura );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_direccion_fk FOREIGN KEY ( direccion_código_postal )
        REFERENCES direccion ( código_postal );

ALTER TABLE cr_poo
    ADD CONSTRAINT cr_poo_cuenta_referencia_fk FOREIGN KEY ( cuenta_referencia_iban )
        REFERENCES cuenta_referencia ( iban );

ALTER TABLE cr_poo
    ADD CONSTRAINT cr_poo_pooled_fk FOREIGN KEY ( pooled_número_cuenta )
        REFERENCES pooled ( número_cuenta );

ALTER TABLE cuenta_ebury
    ADD CONSTRAINT cuenta_ebury_cliente_fk FOREIGN KEY ( cliente_identificador )
        REFERENCES cliente ( identificador );

ALTER TABLE cuenta_referencia
    ADD CONSTRAINT cuenta_referencia_banco_fk FOREIGN KEY ( banco_nombre_banco )
        REFERENCES banco ( nombre_banco );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE currency_account
    ADD CONSTRAINT currency_account_cuenta_ebury_fk FOREIGN KEY ( número_cuenta )
        REFERENCES cuenta_ebury ( número_cuenta );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE currency_account
    ADD CONSTRAINT currency_account_cuenta_referencia_fk FOREIGN KEY ( cuenta_referencia_iban )
        REFERENCES cuenta_referencia ( iban );

ALTER TABLE datos
    ADD CONSTRAINT datos_empresa_fk FOREIGN KEY ( empresa_identificador )
        REFERENCES empresa ( identificador );

ALTER TABLE datos
    ADD CONSTRAINT datos_persona_autorizada_fk FOREIGN KEY ( persona_autorizada_dni )
        REFERENCES persona_autorizada ( dni );

ALTER TABLE div_trans
    ADD CONSTRAINT div_trans_divisa_fk FOREIGN KEY ( divisa_nombre_divisa )
        REFERENCES divisa ( nombre_divisa );

ALTER TABLE div_trans
    ADD CONSTRAINT div_trans_transaccion_fk FOREIGN KEY ( transaccion_numero_transaccion )
        REFERENCES transaccion ( numero_transaccion );

ALTER TABLE empresa
    ADD CONSTRAINT empresa_cliente_fk FOREIGN KEY ( identificador )
        REFERENCES cliente ( identificador );

ALTER TABLE externa
    ADD CONSTRAINT externa_cuenta_externa_fk FOREIGN KEY ( cuenta_externa_iban )
        REFERENCES cuenta_externa ( iban );

ALTER TABLE externa
    ADD CONSTRAINT externa_transaccion_fk FOREIGN KEY ( numero_transaccion )
        REFERENCES transaccion ( numero_transaccion );

ALTER TABLE individual
    ADD CONSTRAINT individual_cliente_fk FOREIGN KEY ( identificador )
        REFERENCES cliente ( identificador );

ALTER TABLE interna
    ADD CONSTRAINT interna_cuenta_ebury_fk FOREIGN KEY ( cuenta_ebury_número_cuenta )
        REFERENCES cuenta_ebury ( número_cuenta );

ALTER TABLE interna
    ADD CONSTRAINT interna_transaccion_fk FOREIGN KEY ( numero_transaccion )
        REFERENCES transaccion ( numero_transaccion );

ALTER TABLE pais_divisa
    ADD CONSTRAINT pais_divisa_divisa_fk FOREIGN KEY ( divisa_nombre_divisa )
        REFERENCES divisa ( nombre_divisa );

ALTER TABLE pais_divisa
    ADD CONSTRAINT pais_divisa_pais_fk FOREIGN KEY ( pais_abrebiatura )
        REFERENCES pais ( abrebiatura );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE persona_autorizada
    ADD CONSTRAINT persona_autorizada_direccion_fk FOREIGN KEY ( direccion_código_postal )
        REFERENCES direccion ( código_postal );

ALTER TABLE pooled
    ADD CONSTRAINT pooled_cuenta_ebury_fk FOREIGN KEY ( número_cuenta )
        REFERENCES cuenta_ebury ( número_cuenta );

ALTER TABLE saldo
    ADD CONSTRAINT saldo_cuenta_ebury_fk FOREIGN KEY ( cuenta_ebury_número_cuenta )
        REFERENCES cuenta_ebury ( número_cuenta );

ALTER TABLE saldo
    ADD CONSTRAINT saldo_divisa_fk FOREIGN KEY ( divisa_nombre_divisa )
        REFERENCES divisa ( nombre_divisa );

ALTER TABLE segregated
    ADD CONSTRAINT segregated_cuenta_ebury_fk FOREIGN KEY ( número_cuenta )
        REFERENCES cuenta_ebury ( número_cuenta );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE segregated
    ADD CONSTRAINT segregated_cuenta_referencia_fk FOREIGN KEY ( cuenta_referencia_iban )
        REFERENCES cuenta_referencia ( iban );

ALTER TABLE transaccion
    ADD CONSTRAINT transaccion_cuenta_ebury_fk FOREIGN KEY ( cuenta_ebury_número_cuenta )
        REFERENCES cuenta_ebury ( número_cuenta );

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_3 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_3 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            22
-- CREATE INDEX                             2
-- ALTER TABLE                             62
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  11
-- WARNINGS                                 0
