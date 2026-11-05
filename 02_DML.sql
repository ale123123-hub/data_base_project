use Clinica;
--populare tabele

-- 1. Pacient (10) 
INSERT INTO Pacient (cnp, nume, prenume, telefon) VALUES
('1990512303412', N'Popescu',  N'Andrei',   '0740123456'),
('2950823124567', N'Ionescu',  N'Maria',    '0741234567'),
('5010304125678', N'Mureșan',  N'Vlad',     '0742345678'),
('6020615326789', N'Dumitru',  N'Ioana',    '0743456789'),
('1880921011234', N'Stan',     N'Mihai',    '0744567890'),
('2970118401235', N'Georgescu',N'Elena',    '0745678901'),
('1851130303346', N'Marin',    N'Cristian', '0746789012'),
('2920407244457', N'Toma',     N'Alexandra','0747890123'),--8
('5040928125568', N'Rusu',     N'Daniel',   '0748901234'),
('6050314336679', N'Neagu',    N'Sofia',    '0749012345');
 
-- 2. Doctor (6) 
INSERT INTO Doctor (nume, prenume, telefon, email) VALUES
(N'Pop',     N'Elena',   '0750111222', 'elena.pop@clinica.ro'),
(N'Rusu',    N'Mihai',   '0750333444', 'mihai.rusu@clinica.ro'),
(N'Mureșan', N'Ioana',   '0750555666', 'ioana.muresan@clinica.ro'),--3
(N'Câmpean', N'Radu',    '0750777888', 'radu.campean@clinica.ro'),
(N'Vlad',    N'Ana',     '0750999000', 'ana.vlad@clinica.ro'),
(N'Toma',    N'Bogdan',  '0751112233', 'bogdan.toma@clinica.ro');
 
-- 3. Specializari (5) 
INSERT INTO Specializari (denumire) VALUES
(N'Cardiologie'),   -- id 1
(N'Pediatrie'),     -- id 2
(N'Dermatologie'),  -- id 3
(N'Ortopedie'),     -- id 4
(N'Neurologie');    -- id 5
 
-- 4. Medicamente (6) 
INSERT INTO Medicamente (denumire, stoc) VALUES
(N'Paracetamol 500 mg',200),  
(N'Ibuprofen 400 mg',150),  
(N'Amoxicilină 500 mg',80),  
(N'Omeprazol 20 mg',120),  
(N'Loratadină 10 mg',90),  
(N'Atorvastatină 20 mg',60);  
 
-- 5. Proceduri (5) 
INSERT INTO Proceduri (denumire, pret) VALUES
(N'Consultație generală',150),  -- id 1
(N'Tomografie',200),  -- id 2
(N'Ecografie abdominală',250),  -- id 3
(N'Consult dermatologic',180),  -- id 4
(N'Radiografie',220);  -- id 5
 
-- 6. Dosar_Medical (10, cate unul pentru fiecare pacient) 
INSERT INTO Dosar_Medical (pacient_id, grupa_sanguina, observatii) VALUES
(1,  'A+', N'Alergie la penicilină'),
(2,  '0+', NULL),
(3,  'B+', N'Control periodic'),
(4,  'AB+', NULL),
(5,  'A-', N'Hipertensiune ușoară'),
(6,  '0-', NULL),
(7,  'B-', N'Fumător'),
(8,  'A+', NULL),
(9,  '0+', N'Antecedente familiale cardiace'),
(10, 'AB-', NULL);
 
-- 7. Doctori_specializari
-- doctorii 1, 2, 3: o singura specializare
-- doctorii 4, 5: doua specializari
-- doctorul 6: trei specializari
INSERT INTO Doctori_specializari (doctor_id, specializare_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4), (4, 5),
(5, 1), (5, 4),
(6, 2), (6, 3), (6, 5);
 
-- 8. Doctori_proceduri
-- doctorii 1, 2, 3: cate 3 proceduri diferite
-- doctorii 4, 5, 6: cate o singura procedura
INSERT INTO Doctori_proceduri (doctor_id, procedura_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 3), (2, 5),
(3, 1), (3, 4), (3, 5),
(4, 5),
(5, 2),
(6, 4);
 
--  9. Retete 
INSERT INTO Retete (pacient_id, doctor_id, data_emitere) VALUES
(1, 1, '2026-10-05'),  -- reteta 1 (2 medicamente)
(2, 2, '2026-10-07'),  -- reteta 2
(4, 4, '2026-10-12'),  -- reteta 3
(6, 6, '2026-10-20'),  -- reteta 4
(8, 3, '2026-10-28');  -- reteta 5
 
-- 10. Retete_Medicamente
INSERT INTO Retete_Medicamente (retete_id, medicamente_id, cantitate, durata_zile) VALUES
(1, 6, 1, 30),
(1, 4, 1, 14),
(2, 2, 2, 5),
(4, 3, 3, 7);

INSERT INTO Retete_Medicamente (retete_id, medicamente_id, cantitate) VALUES
(3, 1, 2),
(5, 5, 1);
 
-- 11. Programari
-- perechile (doctor_id, procedura_id) exista in Doctori_proceduri
INSERT INTO Programari (pacient_id, doctor_id, procedura_id, data_programare) VALUES
(1, 1, 2, '2026-11-10 09:00'),
(2, 2, 1, '2026-11-10 10:30'),
(3, 3, 4, '2026-11-11 11:00'),
(4, 4, 5, '2026-11-12 14:00'),
(5, 5, 2, '2026-11-12 15:30'),
(6, 6, 4, '2026-11-13 09:30');

select* from pacient
select* from doctor
select* from specializari
select* from medicamente
select* from proceduri
select* from retete
select* from retete_medicamente
select* from doctori_specializari
select* from doctori_proceduri
select* from programari
select* from dosar_medical