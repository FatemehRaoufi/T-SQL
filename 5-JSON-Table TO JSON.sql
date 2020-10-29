DECLARE @JSON NVARCHAR(max)
SET @JSON =(
 

 SELECT * FROM (
SELECT 'Amirreza' [name] , 'Taleb' family , 22 age , 'talebamirreza@gmail.com' Email 
UNION ALL 
SELECT 'Sara' [name] , 'Moradi' family , 19 age , 'sara@gmail.com' Email 
UNION ALL 
SELECT 'Ali' [name] , 'Taleb' family , 47 age , 'talebAli@gmail.com' Email 
UNION ALL 
SELECT 'Kiarash' [name] , 'Taleb' family , 15 age , 'talebKiarash@gmail.com' Email 
UNION ALL 
SELECT 'Siavash' [name] , 'Taleb' family , 22 age , 'talebSiavash@gmail.com' Email 
)Json

FOR JSON PATH -- ,WITHOUT_ARRAY_WRAPPER

)
PRINT @JSON


