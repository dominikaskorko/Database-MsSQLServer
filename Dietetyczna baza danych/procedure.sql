GO
IF OBJECT_ID('AktualizujPomiar','P') IS NOT NULL
DROP PROC AktualizujPomiar
IF OBJECT_ID('DodajUżytkownika','P') IS NOT NULL
DROP PROC DodajUżytkownika
IF OBJECT_ID('DodajDoListyZakupów','P') IS NOT NULL
DROP PROC DodajDoListyZakupów
IF OBJECT_ID('UsuńZListyZakupów','P') IS NOT NULL
DROP PROC UsuńZListyZakupów
IF OBJECT_ID('DodajOcenęTreningu','P') IS NOT NULL
DROP PROC DodajOcenęTreningu
IF OBJECT_ID('DodajOcenęJadłospisu','P') IS NOT NULL
DROP PROC DodajOcenęJadłospisu
IF OBJECT_ID('ZaplanujTrening','P') IS NOT NULL
DROP PROC ZaplanujTrening
IF OBJECT_ID('ZaplanujJadłospis','P') IS NOT NULL
DROP PROC ZaplanujJadłospis
IF OBJECT_ID('ZapiszTrening','P') IS NOT NULL
DROP PROC ZapiszTrening
IF OBJECT_ID('ZapiszJadłospis','P') IS NOT NULL
DROP PROC ZapiszJadłospis
IF OBJECT_ID('ZmieńOcenęTreningu','P') IS NOT NULL
DROP PROC ZmieńOcenęTreningu
IF OBJECT_ID('ZmieńOcenęJadłospisu','P') IS NOT NULL
DROP PROC ZmieńOcenęJadłospisu
IF OBJECT_ID('DodajZnajomego','P') IS NOT NULL
DROP PROC DodajZnajomego
GO

CREATE PROCEDURE AktualizujPomiar
(@Nazwa VARCHAR(20), @Waga INT, @ObwódPasa INT)
AS
DECLARE @IDUżytkownika VARCHAR(20)
DECLARE @DataPomiaru DATETIME
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@nazwa)
SET @DataPomiaru=SYSDATETIME()
INSERT INTO AktualnePomiary VALUES
(@IDUżytkownika,@dataPomiaru,@waga,@obwódPasa)
GO

CREATE PROCEDURE DodajZnajomego
(@NazwaUżytkownika1 VARCHAR(20),@NazwaUżytkownika2 VARCHAR(100))
AS
DECLARE @IDUżytkownika1 INT, @IDUżytkownika2 INT
SET @IDUżytkownika1=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika1)
SET @IDUżytkownika2=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika2)
INSERT INTO Znajomi
VALUES (@IDUżytkownika1,@IDUżytkownika2),(@IDUżytkownika2,@IDUżytkownika1)
GO

CREATE PROCEDURE ZmieńOcenęJadłospisu
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
UPDATE OcenioneJadłospisy
SET OcenioneJadłospisy.Ocena=@Ocena WHERE OcenioneJadłospisy.IDUżytkownika=@IDUżytkownika AND OcenioneJadłospisy.IDJadłospisu=@IDJadłospisu
GO

CREATE PROCEDURE ZmieńOcenęTreningu
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
UPDATE OcenioneTreningi 
SET
Ocena = @Ocena
WHERE IDUżytkownika = @IDUżytkownika AND IDTreningu = @IDTreningu
GO

CREATE PROCEDURE ZapiszTrening
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100))
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZapisaneTreningi VALUES
(@IDUżytkownika,@IDTreningu)
GO

CREATE PROCEDURE ZapiszJadłospis
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100))
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
INSERT INTO ZapisaneJadłospisy VALUES
(@IDUżytkownika,@IDJadłospisu)
GO

CREATE PROCEDURE ZaplanujTrening
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@DataRozpoczęcia DATE, @DataZakończenia DATE)
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO ZaplanowaneTreningi VALUES
(@IDUżytkownika,@IDTreningu,@DataRozpoczęcia,@DataZakończenia)
GO

CREATE PROCEDURE ZaplanujJadłospis
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100),@Data DATE)
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
INSERT INTO ZaplanowaneJadłospisy VALUES
(@IDUżytkownika,@IDJadłospisu,@Data)
GO

CREATE PROCEDURE DodajOcenęTreningu
(@NazwaUżytkownika VARCHAR(20),@NazwaTreningu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDTreningu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDTreningu=(SELECT IDTreningu FROM Treningi WHERE Treningi.NazwaTreningu=@NazwaTreningu)
INSERT INTO OcenioneTreningi VALUES
(@IDUżytkownika,@IDTreningu,@Ocena)
GO

CREATE PROCEDURE DodajOcenęJadłospisu
(@NazwaUżytkownika VARCHAR(20),@NazwaJadłospisu VARCHAR(100),@Ocena INT)
AS
DECLARE @IDUżytkownika INT, @IDJadłospisu INT
SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
SET @IDJadłospisu=(SELECT IDJadłospisu FROM Jadłospisy WHERE Jadłospisy.NazwaJadłospisu=@NazwaJadłospisu)
INSERT INTO OcenioneJadłospisy VALUES
(@IDUżytkownika,@IDJadłospisu,@Ocena)
GO

CREATE PROCEDURE UsuńZListyZakupów
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaUżytkownika VARCHAR(20))
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDUżytkownika INT
	SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakupów WHERE ListaZakupów.NazwaSklepu=@NazwaSklepu AND ListaZakupów.IDUżytkownika=@IDUżytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	DELETE  FROM SkładListyZakupów WHERE 
	SkładListyZakupów.IDListy=@IDListy AND SkładListyZakupów.IDProduktu=@IDProduktu

GO

CREATE PROCEDURE DodajDoListyZakupów
(@NazwaProduktu VARCHAR(100), @NazwaSklepu VARCHAR(100), @NazwaUżytkownika VARCHAR(20), @IlośćPorcji INT)
AS
	DECLARE @IDProduktu INT, @IDListy INT, @IDUżytkownika INT
	SET @IDUżytkownika=(SELECT IDUżytkownika FROM Użytkownicy WHERE Użytkownicy.NazwaUżytkownika=@NazwaUżytkownika)
	SET @IDListy=(SELECT IDListy FROM ListaZakupów WHERE ListaZakupów.NazwaSklepu=@NazwaSklepu AND ListaZakupów.IDUżytkownika=@IDUżytkownika)
	SET @IDProduktu = (SELECT IDProduktu FROM Produkty WHERE NazwaProduktu = @NazwaProduktu)
	INSERT INTO SkładListyZakupów VALUES
	(@IDListy,@IDProduktu,@IlośćPorcji)
GO
 
CREATE PROCEDURE DodajUżytkownika
(@NazwaUżytkownika VARCHAR(20), @ImięUżytkownika VARCHAR(20), @NazwiskoUżytkownika VARCHAR(20), @NumerTelefonu VARCHAR(9))
AS
INSERT INTO Użytkownicy VALUES
(@NazwaUżytkownika, @ImięUżytkownika, @NazwiskoUżytkownika, @NumerTelefonu)
GO