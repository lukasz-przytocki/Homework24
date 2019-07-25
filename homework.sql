-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE pracownik (
id INT AUTO_INCREMENT PRIMARY KEY,
imie VARCHAR(20), 
nazwisko VARCHAR (30),
wyplata DECIMAL(10,2),
data_urodzenia DATE, 
stanowisko VARCHAR(30));

-- 2. Wstawia do tabeli co najmniej 6 pracowników

INSERT INTO pracownik(imie, nazwisko, wyplata, data_urodzenia, stanowisko)
VALUES ('Jan','Kowalski',5000, '1988-01-23', 'Kierowca autobusu'),
	   ('Karol','Nowak',4000,'1999-03-10','Listonosz'),
       ('Anna','Korzeniowska','6000','1993-09-21','Inżynier budownictwa'),
       ('Dominika','Gil','3500', '2001-06-30','Kelnerka'),
       ('Piotr','Zawada',5500,'1990-08-12','Żołnierz zawodowy'),
       ('Izabela','Prus',4500,'1989-11-02','Pielęgniarka');
       
 -- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku      
       select * from pracownik order by nazwisko;
	
-- 4. Pobiera pracowników na wybranym stanowisku

	  select * from pracownik where stanowisko='Listonosz';   
      
-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat

	select * from pracownik where ABS(DATEDIFF(data_urodzenia, CURDATE()))>=30*365;
    
-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%

select id, imie, nazwisko, wyplata+(wyplata*0.1), data_urodzenia, stanowisko from pracownik where stanowisko='Pielęgniarka';

-- 7. Usuwa najmłodszego pracownika

-- select data_urodzenia from pracownik where data_urodzenia=(select MIN(data_urodzenia) from pracownik);
-- delete from pracownik where data_urodzenia=(select MIN(data_urodzenia) from pracownik);
-- select * from pracownik;

-- 8. Usuwa tabelę pracownik

drop table pracownik;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)

CREATE TABLE stanowisko(
nazwa_st VARCHAR(20),
opis_st VARCHAR(50),
wypłata_st DECIMAL(10,2));

-- 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)

CREATE TABLE adres(
ulica_numer VARCHAR(30),
kod_pocztowy VARCHAR(10),
miejscowość VARCHAR(30));

-- 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres

CREATE TABLE pracownik(
prac_id INT,
imie VARCHAR(10),
nazwisko VARCHAR(20));

ALTER TABLE adres
ADD COLUMN prac_id INT;

ALTER TABLE stanowisko
ADD COLUMN prac_id INT;

select * from pracownik;
select * from adres;
select * from stanowisko;

-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

INSERT INTO pracownik(prac_id, imie, nazwisko)
VALUES(1, 'Jan','Kowalski'),
      (2, 'Karol','Zięba'),
      (3, 'Anna','Zawada');

INSERT INTO adres (ulica_numer, kod_pocztowy, miejscowość,prac_id)
VALUES('Mickiewicza 12/5', '51-160','Wrocław',1),
      ('Słowackiego 5/6','12-120','Kraków',2),
      ('Bolka i Lolka 32','01-300','Warszawa',3);
	
 INSERT INTO stanowisko(nazwa_st,opis_st,wypłata_st,prac_id)
VALUES('Kierownik','Zarządzanie zasobami i projektem',15000,1),
       ('Sprzedawca','Kontakt z klientem, sprzedaz bezposlrednia', 5000,1),
       ('Informatyk','Zarzadzanie infrastruktura IT',7000,3);

-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)

select imie, nazwisko, adres.ulica_numer, adres.kod_pocztowy, adres.miejscowość, stanowisko.nazwa_st as stanowisko from pracownik
INNER JOIN adres ON pracownik.prac_id=adres.prac_id
INNER JOIN stanowisko ON pracownik.prac_id=stanowisko.prac_id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie

select sum(wypłata_st)as SUMA_WYPŁAT from stanowisko;

--15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)

select imie, nazwisko, a.ulica_numer, a.kod_pocztowy, a.miejscowość, s.nazwa_st from pracownik p
INNER JOIN adres a ON p.prac_id=a.prac_id
INNER JOIN stanowisko s ON p.prac_id=s.prac_id
where a.kod_pocztowy='01-300';
