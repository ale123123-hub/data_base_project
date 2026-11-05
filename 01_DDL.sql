create DATABASE Clinica;
use Clinica;

create table Pacient(
id INT Identity(1,1) Primary Key,
cnp CHAR(13) NOT NULL UNIQUE,
nume NVARCHAR(100) NOT NULL,
prenume NVARCHAR(100) NOT NULL,
telefon CHAR(10) NOT NULL
)

create table Doctor(
id INT Identity(1,1)Primary Key,
nume NVARCHAR(100) NOT NULL,
prenume NVARCHAR(100) NOT NULL,
telefon CHAR(10) NOT NULL,
email VARCHAR(100) NOT NULL
)

create table Specializari(
id INT Identity(1,1) Primary Key,
denumire NVARCHAR(100) NOT NULL UNIQUE
)

create table Medicamente(
id INT Identity(1,1) Primary Key,
denumire NVARCHAR(100) NOT NULL UNIQUE,
stoc INT NOT NULL)

create table Proceduri(
id INT Identity(1,1)Primary Key,
denumire VARCHAR(100) NOT NULL UNIQUE,
pret INT NOT NULL
CONSTRAINT CK_Proceduri_pret CHECK(pret>0)
)

create table Retete(
id INT Identity(1,1) Primary Key,
pacient_id INT NOT NULL,
doctor_id INT NOT NULL,
data_emitere DATE NOT NULL,
CONSTRAINT FK_paciet_id FOREIGN KEY (pacient_id) 
REFERENCES Pacient(id),
CONSTRAINT FK_doctor_id FOREIGN KEY (doctor_id)
REFERENCES Doctor(id)
)

create table Retete_Medicamente(
retete_id INT NOT NULL,
medicamente_id INT NOT NULL,
cantitate INT NOT NULL,
durata_zile INT NOT NULL DEFAULT 3,
CONSTRAINT PK_Retete_Medicamente PRIMARY KEY (retete_id,medicamente_id),
CONSTRAINT FK_retete_id FOREIGN KEY (retete_id)
REFERENCES Retete(id),
CONSTRAINT FK_medicamente_id FOREIGN KEY (medicamente_id)
REFERENCES Medicamente(id),
CONSTRAINT CK_Retete_Medicamente_cantitate CHECK (cantitate>=0)
)
create table Doctori_specializari(
doctor_id INT NOT NULL,
specializare_id INT NOT NULL,
CONSTRAINT PK_Doctori_specializari PRIMARY KEY (doctor_id, specializare_id),
CONSTRAINT FK_DS_doctor FOREIGN KEY (doctor_id)
REFERENCES Doctor(id),
CONSTRAINT FK_DS_specializare FOREIGN KEY (specializare_id)
REFERENCES Specializari(id)
)
create table Doctori_proceduri(
doctor_id INT NOT NULL,
procedura_id INT NOT NULL,
CONSTRAINT PK_Doctori_proceduri PRIMARY KEY (doctor_id, procedura_id),
CONSTRAINT FK_DP_doctor FOREIGN KEY (doctor_id)
REFERENCES Doctor(id),
CONSTRAINT FK_DP_procedura FOREIGN KEY (procedura_id)
REFERENCES Proceduri(id)
)

create table Programari(
id INT Identity(1,1) PRIMARY KEY,
pacient_id INT NOT NULL,
doctor_id INT NOT NULL,
procedura_id INT NOT NULL,
data_programare DATETIME2 NOT NULL DEFAULT GETDATE(),
CONSTRAINT FK_P_pacient_id FOREIGN KEY (pacient_id)
REFERENCES Pacient(id),
CONSTRAINT FK_P_doctor_id FOREIGN KEY (doctor_id)
REFERENCES Doctor(id),
CONSTRAINT FK_P_procedura_id FOREIGN KEY (procedura_id)
REFERENCES Proceduri(id)
)

create table Dosar_Medical(
pacient_id INT NOT NULL PRIMARY KEY,
grupa_sanguina VARCHAR(3) NOT NULL,
observatii VARCHAR(1000) NULL
CONSTRAINT FK_DM_pacient_id FOREIGN KEY (pacient_id)
REFERENCES Pacient(id)
)

DROP TABLE IF EXISTS Retete_Medicamente;
DROP TABLE IF EXISTS Programari;
DROP TABLE IF EXISTS Retete;
DROP TABLE IF EXISTS Doctori_proceduri;
DROP TABLE IF EXISTS Doctori_specializari;
DROP TABLE IF EXISTS Dosar_Medical;
DROP TABLE IF EXISTS Proceduri;
DROP TABLE IF EXISTS Medicamente;
DROP TABLE IF EXISTS Specializari;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Pacient;





