DROP DATABASE IF EXISTS conapesca;
CREATE DATABASE conapesca;
USE conapesca;

CREATE TABLE Roles (
    id INT PRIMARY KEY NOT NULL,
    NombreRol VARCHAR(20) UNIQUE NOT NULL
);
CREATE TABLE Users (
    id INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(30) NOT NULL,
    CURP VARCHAR(18) NOT NULL,
    Email VARCHAR(30),
    Password VARCHAR(20) NOT NULL,
    Rolid INT NOT NULL,
    FOREIGN KEY (Rolid) REFERENCES Roles(id)
);
CREATE TABLE Privilegios (
    id INT PRIMARY KEY NOT NULL,
    NombrePermiso VARCHAR(30) UNIQUE NOT NULL
);
CREATE TABLE AsignacionPermisos (
    id INT PRIMARY KEY NOT NULL,
    Rolid INT NOT NULL,
    Privid INT NOT NULL,
    Permitido BOOLEAN NOT NULL,
    FOREIGN KEY (Rolid) REFERENCES Roles(id),
    FOREIGN KEY (Privid) REFERENCES Privilegios(id)
);
CREATE TABLE Region (
    id INT PRIMARY KEY NOT NULL,
    NombreRegion VARCHAR(40) NOT NULL
);
CREATE TABLE Distrito (
    id INT PRIMARY KEY NOT NULL,
    NombreDistrito VARCHAR(30) NOT NULL,
    Regid INT NOT NULL,
    FOREIGN KEY (Regid) REFERENCES Region(id)
);
CREATE TABLE Municipio (
    id INT PRIMARY KEY NOT NULL,
    NombreMunicipio VARCHAR(30) NOT NULL,
    Disid INT NOT NULL,
    FOREIGN KEY (Disid) REFERENCES Distrito(id)
);
CREATE TABLE Localidad (
    id INT PRIMARY KEY NOT NULL,
    NombreLocalidad VARCHAR(30) NOT NULL,
    Munid INT NOT NULL,
    FOREIGN KEY (Munid) REFERENCES Municipio(id)
);
CREATE TABLE Oficinas (
    id INT PRIMARY KEY NOT NULL,
    NombreOficina VARCHAR(50) NOT NULL,
    Ubicacion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(10) NOT NULL,
    Email VARCHAR(40) NOT NULL
);



CREATE TABLE UnidadEconomicaPA (
    id INT PRIMARY KEY NOT NULL,
    Ofcid INT NOT NULL,
    FechaRegistro DATE NOT NULL,
    RNPA VARCHAR(50),
    FOREIGN KEY (Ofcid) REFERENCES Oficinas(id)
);

CREATE TABLE DatosGeneralesPA ( --Me quedpe hasta aqui
    id INT PRIMARY KEY NOT NULL,
    TipoPersona BOOLEAN NOT NULL,
    CURP VARCHAR(18) NOT NULL,
    RFC VARCHAR(13),
    Nombres VARCHAR(50) NOT NULL,
    ApPaterno VARCHAR(30) NOT NULL,
    ApMaterno VARCHAR(30) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo ENUM ('M', 'F') NOT NULL,
    GrupoSanguineo VARCHAR(4),
    Email VARCHAR(40),
    UEPAid INT NOT NULL,
    FOREIGN KEY (UEPAid) REFERENCES UnidadEconomicaPA(id)
);
CREATE TABLE DomicilioPA (
    id INT PRIMARY KEY NOT NULL,
    Calle VARCHAR(100) NOT NULL,
    NmExterior VARCHAR(6) NOT NULL,
    NmInterior VARCHAR(6) NOT NULL,
    CodigoPostal VARCHAR(10),
    LocID INT NOT NULL,
    Colonia VARCHAR(100) NOT NULL,
    TipoTelefono VARCHAR(20) NOT NULL,
    DGPAID INT NOT NULL,
    FOREIGN KEY (Locid) REFERENCES Localidad(id),
    FOREIGN KEY (DGPAid) REFERENCES DatosGeneralesPA(id)
);
CREATE TABLE TelefonosPA (
    id INT PRIMARY KEY NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Tipo VARCHAR(20) NOT NULL,
    DGPAid INT NOT NULL,
    FOREIGN KEY (DGPAid) REFERENCES DatosGeneralesPA(id)
);
CREATE TABLE PermisoPesca (
    id INT PRIMARY KEY NOT NULL,
    NombrePermiso VARCHAR(50) NOT NULL
);
CREATE TABLE ArtePesca (
    id INT PRIMARY KEY NOT NULL,
    NombreArtePesca VARCHAR(50) NOT NULL
);
CREATE TABLE Especies (
    id INT PRIMARY KEY NOT NULL,
    NombreEspecie VARCHAR(50) NOT NULL
);
CREATE TABLE Peces (
    id INT PRIMARY KEY NOT NULL,
    NombreComun VARCHAR(50) NOT NULL,
    NombreCientifico VARCHAR(100) NOT NULL,
    TPEspecieid INT NOT NULL,
    FOREIGN KEY (TPEspecieid) REFERENCES Especies(id)
);

CREATE TABLE DetallePA (
    id INT PRIMARY KEY NOT NULL,
    DGPAid INT NOT NULL,
    IniOperaciones DATE NOT NULL,
    ActvPesquera BOOLEAN NOT NULL,
    ActivoEmbMayor BOOLEAN NOT NULL,
    ActivoEmbMenor BOOLEAN NOT NULL,
    DocActaNacimiento BLOB NOT NULL,
    DocComprobanteDomicilio BLOB NOT NULL,
    DocCURP BLOB NOT NULL,
    DocIdentificacionOfc BLOB NOT NULL,
    DocRFC BLOB NOT NULL,
    FOREIGN KEY (DGPAid) REFERENCES DatosGeneralesPA(id)
);
CREATE TABLE PermisosPescaPA (
    id INT PRIMARY KEY NOT NULL,
    FolioPermiso VARCHAR(50) NOT NULL,
    FechaExpedicion DATE NOT NULL,
    FechaVigencia DATE NOT NULL,
    EstatusPermiso BOOLEAN NOT NULL,
    Nota TEXT,
    TPPPescaid INT NOT NULL,
    DetallePAid INT NOT NULL,
    DGPAid INT NOT NULL,
    FOREIGN KEY (TPPPescaid) REFERENCES PermisoPesca(id),
    FOREIGN KEY (DetallePAid) REFERENCES DetallePA(id),
    FOREIGN KEY (DGPAid) REFERENCES DatosGeneralesPA(id)
);
CREATE TABLE ArtePescaPermiso (
    id INT PRIMARY KEY NOT NULL,
    TPArtPescaid INT NOT NULL,
    PPPAid INT NOT NULL,
    FOREIGN KEY (PPPAid) REFERENCES PermisosPescaPA(id),
    FOREIGN KEY (TPArtPescaid) REFERENCES ArtePesca(id)
);
CREATE TABLE SociosDetallePA (
    id INT PRIMARY KEY NOT NULL,
    IniOperaciones DATE NOT NULL,
    ActvPesquera BOOLEAN NOT NULL,
    CantidadPescadores INT,
    CURP VARCHAR(18) NOT NULL,
    TipoPA BOOLEAN NOT NULL,
    DocActaNacimiento BLOB NOT NULL,
    DocActaConstitutiva BLOB NOT NULL,
    DocActaAsamblea BLOB NOT NULL,
    DocComprobanteDomicilio BLOB NOT NULL,
    DocCURP BLOB NOT NULL,
    DocIdentificacionOfc BLOB NOT NULL,
    DocRFC BLOB NOT NULL,
    DocAcreditacionRepresentanteLegal BLOB NOT NULL,
    DetallePAid INT NOT NULL,
    FOREIGN KEY (DetallePAid) REFERENCES DetallePA(id)
);



CREATE TABLE UnidadEconomicaEmbMayor (
    id INT PRIMARY KEY NOT NULL,
    RNPA VARCHAR(50),
    Nombre VARCHAR(50) NOT NULL,
    ActivoPropio BOOLEAN NOT NULL,
    UEDuenoid INT NOT NULL,
    FOREIGN KEY (UEDuenoid) REFERENCES UnidadEconomicaPA(id)
);
CREATE TABLE DatosGeneralesEmbMA (
    id INT PRIMARY KEY NOT NULL,
    NombreEmbMayor VARCHAR(50) NOT NULL,
    RNPA VARCHAR(50),
    Matricula VARCHAR(50) NOT NULL,
    PuertoBase VARCHAR(50) NOT NULL,
    DocAcreditacionLegalMotor BLOB NOT NULL,
    DocCertificadoMatricula BLOB NOT NULL,
    DocComprobanteTenenciaLegal BLOB NOT NULL,
    DocCertificadoSegEmbs BLOB NOT NULL,
    UEEMMAid INT,
    FOREIGN KEY (UEEMMAid) REFERENCES UnidadEconomicaEmbMayor(id)
);
CREATE TABLE EmbarcacionesMayoresPA (
    id INT PRIMARY KEY NOT NULL,
    DGPAid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGPAid) REFERENCES DatosGeneralesPA(id),
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id)
);
CREATE TABLE TipoActividad (
    id INT PRIMARY KEY NOT NULL,
    NombreTipoActividad VARCHAR(50) NOT NULL
);
CREATE TABLE TipoCubierta (
    id INT PRIMARY KEY NOT NULL,
    NombreTipoCubierta VARCHAR(50) NOT NULL
);
CREATE TABLE MaterialCasco (
    id INT PRIMARY KEY NOT NULL,
    NombreMaterialCasco VARCHAR(50) NOT NULL
);
CREATE TABLE EquipoDeteccion (
    id INT PRIMARY KEY NOT NULL,
    NombreEquipoDeteccion VARCHAR(50)
);
CREATE TABLE SistemaConservacion (
    id INT PRIMARY KEY NOT NULL,
    NombreSistemaConservacion VARCHAR(50) NOT NULL
);
CREATE TABLE EquipoSeguridad (
    id INT PRIMARY KEY NOT NULL,
    NombreEquipoSeguridad VARCHAR(50) NOT NULL
);
CREATE TABLE EquipoSalvamento (
    id INT PRIMARY KEY NOT NULL,
    NombreEquipoSalvamento VARCHAR(50) NOT NULL
);
CREATE TABLE EquipoContraIncendio (
    id INT PRIMARY KEY NOT NULL,
    NombreEquipoContraIncendio VARCHAR(50) NOT NULL
);
CREATE TABLE EquipoRadioComunicacion (
    id INT PRIMARY KEY NOT NULL,
    NombreEquipoRadioComunicacion VARCHAR(50) NOT NULL
);
CREATE TABLE EquipoNavegacion ( --Hasta aquí me quede con las migraciones, modelos y controladores
    id INT PRIMARY KEY NOT NULL,
    NombreEquipoNavegacion VARCHAR(50) NOT NULL
);
CREATE TABLE CaractrsGenEmbMA(
    id INT PRIMARY KEY NOT NULL,
    TPActid INT NOT NULL,
    TPCubid INT NOT NULL,
    CdPatrones INT NOT NULL,
    CdMotoristas INT NOT NULL,
    CdPSEspecializados INT NOT NULL,
    CdPescadores INT NOT NULL,
    AnioConstruccion INT NOT NULL,
    MtrlCascoid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (TPActid) REFERENCES TipoActividad(id),
    FOREIGN KEY (TPCubid) REFERENCES TipoCubierta(id),
    FOREIGN KEY (MtrlCascoid) REFERENCES MaterialCasco(id),
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id)
);
CREATE TABLE ArtePescaEmbMA (
    id INT PRIMARY KEY NOT NULL,
    TPArtPescaid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (TPArtPescaid) REFERENCES ArtePesca(id)
);
CREATE TABLE EquipoDeteccionEmbMA (
    id INT PRIMARY KEY NOT NULL,
    EqpoDeteccionid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (EqpoDeteccionid) REFERENCES EquipoDeteccion(id)
);
CREATE TABLE SisConservacionEmbMA (
    id INT PRIMARY KEY NOT NULL,
    SisConservacionid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (SisConservacionid) REFERENCES SistemaConservacion(id)
);
CREATE TABLE EspeciesEmbMA (
    id INT PRIMARY KEY NOT NULL,
    TPEspecieid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (TPEspecieid) REFERENCES Especies(id)
);
CREATE TABLE EquipoSeguridadEmbMA (
    id INT PRIMARY KEY NOT NULL,
    EqpoSeguridadid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (EqpoSeguridadid) REFERENCES EquipoSeguridad(id)
);
CREATE TABLE EquipoSalvamentoEmbMA (
    id INT PRIMARY KEY NOT NULL,
    EqpoSalvamentoid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (EqpoSalvamentoid) REFERENCES EquipoSalvamento(id)
);
CREATE TABLE EquipoContraIncendioEmbMA (
    id INT PRIMARY KEY NOT NULL,
    EqpoContraIncendioid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (EqpoContraIncendioid) REFERENCES EquipoContraIncendio(id)
);
CREATE TABLE EquipoRadioComunicacionEmbMA (
    id INT PRIMARY KEY NOT NULL,
    EqpoRadioComunicacionid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (EqpoRadioComunicacionid) REFERENCES EquipoRadioComunicacion(id)
);
CREATE TABLE EquipoNavegacionEmbMA (
    id INT PRIMARY KEY NOT NULL,
    EqpoNavegacionid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (EqpoNavegacionid) REFERENCES EquipoNavegacion(id)
);
CREATE TABLE CaractrsFisEmbMA (
    id INT PRIMARY KEY NOT NULL,
    Eslora DECIMAL(10, 2) DEFAULT 0.00,
    Manga DECIMAL(10, 2) DEFAULT 0.00,
    Puntal DECIMAL(10, 2) DEFAULT 0.00,
    Calado DECIMAL(10, 2) DEFAULT 0.00,
    ArqueoNeto DECIMAL(10, 2) DEFAULT 0.00,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id)
);
CREATE TABLE MotorEmbMA (
    id INT PRIMARY KEY NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Serie VARCHAR(50) NOT NULL,
    Potencia DECIMAL(10, 2) DEFAULT 0.00,
    MtrPrincipal BOOLEAN NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id)
);
CREATE TABLE MotoresPorEmbMA (
    id INT PRIMARY KEY NOT NULL,
    DGEMMAid INT NOT NULL,
    MtrEmbMaid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (MtrEmbMaid) REFERENCES MotorEmbMA(id)
);
CREATE TABLE ArteEquipoPescaEmMA (
    id INT PRIMARY KEY NOT NULL,
    TPArtPescaid INT NOT NULL,
    TPEspecieid INT NOT NULL,
    Cantidad INT NOT NULL,
    Longitud DECIMAL(10, 2) DEFAULT 0.00,
    Altura DECIMAL(10, 2) DEFAULT 0.00,
    Malla DECIMAL(10, 2) DEFAULT 0.00,
    Material VARCHAR(50) DEFAULT 0.00,
    Reinales DECIMAL(10, 2) DEFAULT 0.00,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (TPArtPescaid) REFERENCES ArtePesca(id),
    FOREIGN KEY (TPEspecieid) REFERENCES Especies(id),
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id)
);
CREATE TABLE DocRegtrArtsPescaEmbMA (
    id INT PRIMARY KEY NOT NULL,
    DocFacturaElectronica BLOB NOT NULL,
    DocNotaRemision BLOB NOT NULL,
    DocFacturaEndosada BLOB NOT NULL,
    DocTestimonial BLOB NOT NULL,
    DocArteEquipoPescaEmMaID INT NOT NULL,
    ArteEquipoPescaEmMaID INT NOT NULL,
    FOREIGN KEY (ArteEquipoPescaEmMaid) REFERENCES ArteEquipoPescaEmMA(id)
);
CREATE TABLE ArteEquipoPescaPorEmbMA (
    id INT PRIMARY KEY NOT NULL,
    ArteEquipoPescaEmMaid INT NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id),
    FOREIGN KEY (ArteEquipoPescaEmMaid) REFERENCES ArteEquipoPescaEmMA(id)
);
CREATE TABLE CostosOperacionEmbMA (
    id INT PRIMARY KEY NOT NULL,
    Combustible DECIMAL(10, 2) DEFAULT 0.00,
    Lubricantes DECIMAL(10, 2) DEFAULT 0.00,
    Mantenimiento DECIMAL(10, 2) DEFAULT 0.00,
    Salarios DECIMAL(10, 2) DEFAULT 0.00,
    Seguros DECIMAL(10, 2) DEFAULT 0.00,
    Permisos DECIMAL(10, 2) DEFAULT 0.00,
    Impuestos DECIMAL(10, 2) DEFAULT 0.00,
    Avituallamiento DECIMAL(10, 2) DEFAULT 0.00,
    Preoperativos DECIMAL(10, 2) DEFAULT 0.00,
    AsistenciaTecnica DECIMAL(10, 2) DEFAULT 0.00,
    Administrativos DECIMAL(10, 2) DEFAULT 0.00,
    Otros DECIMAL(10, 2) DEFAULT 0.00,
    Total DECIMAL(10, 2) DEFAULT 0.00 NOT NULL,
    DGEMMAid INT NOT NULL,
    FOREIGN KEY (DGEMMAid) REFERENCES DatosGeneralesEmbMA(id)
);



CREATE TABLE UnidadEconomicaEmbMenor (
    id INT PRIMARY KEY NOT NULL,
    RNPA VARCHAR(50),
    Nombre VARCHAR(100) NOT NULL,
    UEDueno INT NOT NULL,
    FOREIGN KEY (UEDueno) REFERENCES UnidadEconomicaPA(id)
);
CREATE TABLE DatosGeneralesEmbME (
    id INT PRIMARY KEY NOT NULL,
    NombreEmbarcacion VARCHAR(100) NOT NULL,
    RNPA VARCHAR(50),
    Matricula VARCHAR(50) NOT NULL,
    TPActid INT NOT NULL,
    MtrlCascoid INT NOT NULL,
    CapacidadCarga DECIMAL(10, 2) DEFAULT 0.00,
    MedidaEslora DECIMAL(10, 2) DEFAULT 0.00,
    AcreditacionLegalMotor BLOB,
    CertificadoMatricula BLOB,
    ComprobanteTenenciaLegal BLOB,
    CertificadoSeguridadEmbarcaciones BLOB,
    UEEMMEid INT,
    FOREIGN KEY (UEEMMEid) REFERENCES UnidadEconomicaEmbMenor(id),
    FOREIGN KEY (TPActid) REFERENCES TipoActividad(id),
    FOREIGN KEY (MtrlCascoid) REFERENCES MaterialCasco(id)
);
CREATE TABLE TipoMotor (
    id INT PRIMARY KEY NOT NULL,
    NombreTipoMotor VARCHAR(50) NOT NULL
);
CREATE TABLE MotorEmbMenor (
    id INT PRIMARY KEY NOT NULL,
    TPMotorid INT NOT NULL,
    Marca VARCHAR(20) NOT NULL,
    Potencia DECIMAL(10, 2) DEFAULT 0.00,
    Serie VARCHAR(20) NOT NULL,
    Combustible VARCHAR(20) NOT NULL,
    DGEMMEid INT,
    FOREIGN KEY (DGEMMEid) REFERENCES DatosGeneralesEmbME(id),
    FOREIGN KEY (TPMotorid) REFERENCES TipoMotor(id)
);
CREATE TABLE MotoresPorEmbMe (
    id INT PRIMARY KEY NOT NULL,
    DGEMMEid INT NOT NULL,
    MtrEmbMeid INT NOT NULL,
    FOREIGN KEY (DGEMMEid) REFERENCES DatosGeneralesEmbME(id),
    FOREIGN KEY (MtrEmbMeid) REFERENCES MotorEmbMenor(id)
);
CREATE TABLE ArteEquipoPescaEmMenor (
    id INT PRIMARY KEY NOT NULL,
    TPArtPescaid INT NOT NULL,
    TPEspecieid INT NOT NULL,
    Cantidad INT NOT NULL,
    Longitud DECIMAL(10, 2) DEFAULT 0.00,
    Altura DECIMAL(10, 2) DEFAULT 0.00,
    Malla DECIMAL(10, 2) DEFAULT 0.00,
    Material VARCHAR(50) NOT NULL,
    Reinales DECIMAL(10, 2) DEFAULT 0.00,
    DGEMMEid INT NOT NULL,
    FOREIGN KEY (TPArtPescaid) REFERENCES ArtePesca(id),
    FOREIGN KEY (TPEspecieid) REFERENCES Especies(id),
    FOREIGN KEY (DGEMMEid) REFERENCES DatosGeneralesEmbME(id)
);
CREATE TABLE DocRegtrArtsPesca (
    id INT PRIMARY KEY NOT NULL,
    DocFacturaElectronica BLOB NOT NULL,
    DocNotaRemision BLOB NOT NULL,
    DocFacturaEndosada BLOB NOT NULL,
    DocTestimonial BLOB NOT NULL,
    DocArteEquipoPescaEmMaID INT NOT NULL,
    ArteEquipoPescaEmMeid INT NOT NULL,
    FOREIGN KEY (ArteEquipoPescaEmMeid) REFERENCES ArteEquipoPescaEmMenor(id)
);
CREATE TABLE ArteEquipoPescaPorEmbMe (
    AEPPEMMAid INT PRIMARY KEY NOT NULL,
    DGEMMEid INT NOT NULL,
    ArteEquipoPescaEmMeid INT NOT NULL,
    FOREIGN KEY (ArteEquipoPescaEmMeid) REFERENCES ArteEquipoPescaEmMenor(id),
    FOREIGN KEY (DGEMMEid) REFERENCES DatosGeneralesEmbME(id)
);



CREATE TABLE UnidadEconomicaInsAcu (
    id INT PRIMARY KEY NOT NULL,
    RNPA VARCHAR(50),
    Nombre VARCHAR(100) NOT NULL,
    PropietarioArrendamiento BOOLEAN NOT NULL,
    UEDueno INT NOT NULL,
    FOREIGN KEY (UEDueno) REFERENCES UnidadEconomicaPA(id)
);
CREATE TABLE DatosGeneralesInsAcu (
    id INT PRIMARY KEY NOT NULL,
    NombreInstalacion VARCHAR(50) NOT NULL,
    RNPA VARCHAR(50),
    Ubicacion VARCHAR(100) NOT NULL,
    Acceso TEXT NOT NULL,
    Locid INT NOT NULL,
    UEIAid INT,
    DocActaCreacion BLOB NOT NULL,
    DocMapaLocalizacion BLOB NOT NULL,
    DocPlanoInstalaciones BLOB NOT NULL,
    DocAcreditacionLegalInstalacion BLOB NOT NULL,
    DocComprobanteDomicilio BLOB NOT NULL,
    DocEspeTecnicasFisicas BLOB NOT NULL,
    DocExpedienteFotograficoMapaLocalizacion BLOB NOT NULL,
    FOREIGN KEY (Locid) REFERENCES Localidad(id),
    FOREIGN KEY (UEIAid) REFERENCES UnidadEconomicaInsAcu(id)
);
CREATE TABLE DatosTecnicosInsAcu (
    id INT PRIMARY KEY NOT NULL,
    UsoComercial BOOLEAN,
    UsoDidacta BOOLEAN,
    UsoFomento BOOLEAN,
    UsoInvestigacion BOOLEAN,
    UsoRecreativo BOOLEAN,
    UsoOtro TEXT,
    TipoLaboratorio BOOLEAN,
    TipoGranja BOOLEAN,
    TipoCentroAcuicola BOOLEAN,
    TipoOtro TEXT,
    ModeloIntensivo BOOLEAN,
    ModeloSemiintensivo BOOLEAN,
    ModeloExtensivo BOOLEAN,
    ModeloHiperintensivo BOOLEAN,
    ModeloOtro TEXT,
    AreaTotal DECIMAL(10, 2) DEFAULT 0.00,
    AreaAcuicola DECIMAL(10, 2) DEFAULT 0.00,
    AreaRestante TEXT,
    CapacidadProduccionMiles INT,
    CapacidadProduccionToneladas DECIMAL(10, 2) DEFAULT 0.00,
    DGIAid INT,
    FOREIGN KEY (DGIAid) REFERENCES DatosGeneralesInsAcu(id)
);
CREATE TABLE EspecieObjetivo (
    id INT PRIMARY KEY NOT NULL,
    NombreComun VARCHAR(50) NOT NULL,
    NombreCientifico VARCHAR(100) NOT NULL,
    TPEspecieid INT NOT NULL,
    FOREIGN KEY (TPEspecieid) REFERENCES Especies(id)
);
CREATE TABLE EspeciesObjetivoInsAcu (
    id INT PRIMARY KEY NOT NULL,
    DTIAid INT NOT NULL,
    EspecieOid INT NOT NULL,
    FOREIGN KEY (DTIAid) REFERENCES DatosTecnicosInsAcu(id),
    FOREIGN KEY (EspecieOid) REFERENCES EspecieObjetivo(id)
);
CREATE TABLE TipoActivos (
    id INT PRIMARY KEY NOT NULL,
    NombreActivo VARCHAR(100) NOT NULL
);
CREATE TABLE ActivosProducciónIA (
    id INT PRIMARY KEY NOT NULL,
    DGIAid INT,
    TPActivoid INT NOT NULL,
    Clave VARCHAR(50) NOT NULL,
    Cantidad INT NOT NULL,
    Largo DECIMAL(10, 2) DEFAULT 0.00,
    Ancho DECIMAL(10, 2) DEFAULT 0.00,
    Altura DECIMAL(10, 2) DEFAULT 0.00,
    Capacidad DECIMAL(10, 2) DEFAULT 0.00,
    UnidadMedida ENUM (
        'METRO CUADRADO',
        'METRO CUBICO',
        'KILOGRAMO',
        'LITRO',
        'PIEZA'
    ) NOT NULL,
    FOREIGN KEY (DGIAid) REFERENCES DatosGeneralesInsAcu(id),
    FOREIGN KEY (TPActivoid) REFERENCES TipoActivos(id)
);
CREATE TABLE FuentesCapAguaIA (
    id INT PRIMARY KEY NOT NULL,
    FTPozoProfundo BOOLEAN,
    FTPozoCieloAbierto BOOLEAN,
    FTRio BOOLEAN,
    FTLago BOOLEAN,
    FTArroyo BOOLEAN,
    FTPresa BOOLEAN,
    FTMar BOOLEAN,
    FTOtro TEXT,
    FlujoAguaLxM DECIMAL(10, 2) DEFAULT 0.00,
    DGIAid INT,
    FOREIGN KEY (DGIAid) REFERENCES DatosGeneralesInsAcu(id)
);
CREATE TABLE ActivosProduccionPorIA (
    id INT PRIMARY KEY NOT NULL,
    DGIAid INT NOT NULL,
    APIAid INT NOT NULL,
    FOREIGN KEY (DGIAid) REFERENCES DatosGeneralesInsAcu(id),
    FOREIGN KEY (APIAid) REFERENCES ActivosProducciónIA(id)
);
CREATE TABLE AdmiTrabajadoresIA (
    id INT PRIMARY KEY NOT NULL,
    NumFamilias INT,
    NumMujeres INT,
    NumHombres INT,
    Integ15Menos INT,
    Integ16a25 INT,
    Integ26a35 INT,
    Integ36a45 INT,
    Integ46a60 INT,
    IntegMas60 INT,
    RequiereCont BOOLEAN,
    Temporales INT,
    Permanentes INT,
    TotalIntegrantes INT NOT NULL,
    DGIAid INT,
    FOREIGN KEY (DGIAid) REFERENCES DatosGeneralesInsAcu(id)
);
CREATE TABLE AdmiTrabajadoresPorIA (
    id INT PRIMARY KEY NOT NULL,
    ATIAid INT NOT NULL,
    DGIAid INT NOT NULL,
    FOREIGN KEY (ATIAid) REFERENCES AdmiTrabajadoresIA(id),
    FOREIGN KEY (DGIAid) REFERENCES DatosGeneralesInsAcu(id)
);
CREATE TABLE TipoModalidad (
    id INT PRIMARY KEY NOT NULL,
    NombreModalidad VARCHAR(30) NOT NULL
);
CREATE TABLE TipoProceso (
    id INT PRIMARY KEY NOT NULL,
    NombreProceso VARCHAR(30) NOT NULL
);
CREATE TABLE TipoSolicitud (
    id INT PRIMARY KEY NOT NULL,
    NombreSolicitud VARCHAR(30) NOT NULL
);
CREATE TABLE SolicitudDetalle (
    id INT PRIMARY KEY NOT NULL,
    FolioSolicitud VARCHAR(13) NOT NULL,
    FechaSolicitud DATE,
    TPProcesoid INT NOT NULL,
    TPModalidadid INT NOT NULL,
    TPSolicitudid INT NOT NULL,
    FOREIGN KEY (TPProcesoid) REFERENCES TipoProceso(id),
    FOREIGN KEY (TPModalidadid) REFERENCES TipoModalidad(id),
    FOREIGN KEY (TPSolicitudid) REFERENCES TipoSolicitud(id)
);
