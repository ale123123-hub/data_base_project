use Clinica;
--queries and questions

--Cerinta 1:
--Descriere: Pentru fiecare pacient care are cel putin o reteta activa, afișați numele pacientului si numele doctorului responsabil, ordonate descrescător dupa data de emitere.
SELECT P.nume as pacient ,D.nume as doctor from Pacient P
join Retete R on R.pacient_id=P.id
join Doctor D on R.doctor_id=D.id
where R.id IS NOT NULL
ORDER BY R.data_emitere DESC

--Cerinta 2
--Descriere:Afișați programările din intervalul 10-12 noiembrie 2026 pentru procedurile cu prețul de cel puțin 180 lei, cu numele pacientului, numele doctorului, denumirea procedurii și prețul, ordonate cronologic.
Select P.nume as pacient ,D.nume as doctor ,Procedura.denumire as procedura,Procedura.pret as pret,data_programare from Programari Programare
join Proceduri Procedura on Procedura.id=Programare.procedura_id
join Doctor D on Programare.doctor_id=D.id
join Pacient P on P.id=Programare.pacient_id
where Procedura.pret >=180 and data_programare>='2026-11-10' AND data_programare<'2026-11-13'
ORDER BY data_programare;

--Cerinta 3
--Descriere:Afișați denumirea și stocul medicamentelor care au fost prescrise în rețete emise de doctori cu specializarea Cardiologie.
Select M.denumire,M.stoc from Retete_Medicamente RM
join Medicamente M on M.id=RM.medicamente_id
join Retete R on R.id=RM.retete_id
join Doctor D on R.doctor_id=D.id
where doctor_id in (Select doctor_id from Doctori_specializari where specializare_id like(select id from Specializari where denumire = 'Cardiologie'))

--Cerinta 4
--Denumire:afișați procedurile pentru care veniturile din programări depășesc 300 lei, cu denumirea procedurii, numărul de programări și venitul total, în ordinea descrescătoare a venitului.
Select denumire,COUNT(*) as numar_programari,SUM(pret) as venit_total from Proceduri 
join Programari P on Proceduri.id=P.procedura_id
GROUP BY denumire
Having Sum(pret)>300
Order by venit_total desc


--Cerinta 5
--Denumire:Pentru doctorii care pot efectua cel puțin 3 proceduri, afișați numele, numărul de proceduri și prețul minim, maxim și mediu al procedurilor lor.
select nume,prenume,Count(*)as numar_proceduri,MIN(P.pret)as pret_min,MAX(P.pret)as pret_max from Doctor
join Doctori_proceduri DP on DP.doctor_id=id
join Proceduri P on DP.procedura_id=P.id
group by nume,prenume
having COUNT(*)>=3 

--Cerinta 6
--Denumire:Afișați pacienții care nu au nicio programare, cu numele, prenumele, grupa sanguină și observațiile din dosarul medical. Acolo unde dosarul nu are observații, afișați textul Fara observatii.
select nume,prenume,DM.grupa_sanguina,ISNULL(DM.observatii, 'Fara observartii') from Pacient
join Dosar_Medical DM on Pacient.id=DM.pacient_id
left join Programari P on P.PACIENT_ID=Pacient.id
where P.id is NULL

--Cerinta 7
--Denumire:Afișați doctorii al căror venit total din programări (suma prețurilor procedurilor programate la ei) 
--este mai mare decât venitul mediu pe doctor. Pentru fiecare, afișați numele, 
--numărul de specializări distincte, numărul de pacienți distincți programați și venitul total, în ordinea descrescătoare a venitului.
SELECT D.nume,
       (SELECT COUNT(*)
        FROM Doctori_specializari DS
        WHERE DS.doctor_id = D.id) AS numar_specializari,
       COUNT(DISTINCT P.pacient_id) AS numar_pacienti_distincti,
       SUM(Pro.pret) AS venit_total
FROM Doctor D
JOIN Programari P  ON P.doctor_id = D.id
JOIN Proceduri Pro ON Pro.id = P.procedura_id
GROUP BY D.id, D.nume
HAVING SUM(Pro.pret) > (SELECT AVG(CAST(venit AS DECIMAL(10,2)))
                        FROM (SELECT SUM(Pro.pret) AS venit
                              FROM Programari P
                              JOIN Proceduri Pro ON Pro.id = P.procedura_id
                              GROUP BY P.doctor_id) AS venituri_doctori)
ORDER BY venit_total DESC;
--Cerinta 8
--Descriere:Afișați pacienții care au cel puțin o programare, dar nu au primit nicio rețetă, ordonați după nume.
SELECT pa.nume, pa.prenume
FROM Pacient pa
WHERE EXISTS     (SELECT 1 FROM Programari P WHERE P.pacient_id = pa.id)
  AND NOT EXISTS (SELECT 1 FROM Retete R WHERE R.pacient_id=pa.id)
ORDER BY pa.nume;

--Cerinta 9
--Descriere:Actualizați stocul medicamentelor prescrise, scăzând din stoc cantitatea totală prescrisă în rețete. Modificați doar medicamentele care apar în cel puțin o rețetă.
select id, denumire, stoc from Medicamente order by id;

Update Medicamente 
set stoc=stoc-(select SUM(Rm.cantitate) from Retete_Medicamente RM
where Medicamente.id=RM.medicamente_id
)
where exists (select 1
              from Retete_Medicamente RM
              where RM.medicamente_id = Medicamente.id) 

--Cerinta 10
--Descriere:Programați pacientul cu id 7 la Ecografie abdominală (procedura 3), pe 14.11.2026 ora 10:00, la doctorul cu id-ul cel mai mic dintre cei care pot efectua această procedură. Apoi afișați programarea cu un SELECT.
INSERT INTO Programari (pacient_id, doctor_id, procedura_id, data_programare)
SELECT 7, MIN(DP.doctor_id), 3, '2026-11-14 10:00'
FROM Doctori_proceduri DP
WHERE DP.procedura_id = 3;

select * from Programari
--Cerinta 11
--Descriere:Ștergeți dosarele medicale ale pacienților care nu apar în nicio programare și nu au nicio rețetă.
DELETE FROM Dosar_Medical
WHERE pacient_id NOT IN (SELECT pacient_id FROM Programari)
  AND NOT EXISTS (SELECT 1
                  FROM Retete R
                  WHERE R.pacient_id = Dosar_Medical.pacient_id);
select* from Dosar_Medical