USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[udfGetCharacters]    Script Date: 05/20/2015 02:59:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create FUNCTION [dbo].[udfGetCharacters](@inputString VARCHAR(MAX), @validChars VARCHAR(100))  

 RETURNS VARCHAR(500) AS 

 BEGIN 

     WHILE @inputString like '%[^' + @validChars + ']%' 

         SELECT @inputString = REPLACE(@inputString,SUBSTRING(@inputString,PATINDEX('%[^' + @validChars + ']%',@inputString),1),' ')  
         
 SELECT @inputString = (SELECT LTRIM(RTRIM(
            REPLACE(REPLACE(REPLACE(@inputString,'  ',' ||*9*9||'),'||*9*9|| ',''),'||*9*9||','')
        )))
        
     RETURN @inputString  

 END

GO

If you need only characters between a-z 

SELECT MASTER.dbo.udfGetCharacters('HELLO..@123','A-Z /')

If you need characters between a-z and numbers as well

SELECT MASTER.dbo.udfGetCharacters('HELLO..@123','A-Z0-9 /')

If you need only numbers

SELECT MASTER.dbo.udfGetCharacters('HELLO..@123','0-9 /')

go

select * FROM [SSIS].[dbo].[Product_Staging]
select Phone_Num, MASTER.dbo.udfGetCharacters(Phone_Num,'0-9 /') FROM [SSIS].[dbo].[Product_Staging]

update [Product_Staging]
set first_name = MASTER.dbo.udfGetCharacters(first_name,'A-Z /')
where first_name != MASTER.dbo.udfGetCharacters(first_name,'A-Z /')
go
update [Product_Staging]
set Phone_Num =  MASTER.dbo.udfGetCharacters(Phone_Num,'0-9 /')
where Phone_Num !=  MASTER.dbo.udfGetCharacters(Phone_Num,'0-9 /')

begin tran
commit