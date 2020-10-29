

DECLARE @time DATETIME2
DECLARE @time1 DATETIME2
SET @time = GETDATE()
SELECT  UserID,
       UserName,
       CityName,
	   NeighbourhoodName,
       Address
--      INTO #temp  
	  FROM dbo.FW_TB_User
INNER JOIN dbo.FW_TB_Address ON AddressID  = UserAddressID
INNER JOIN dbo.FW_TB_City ON FW_TB_City.CityID = FW_TB_Address.CityID
INNER JOIN  dbo.FW_TB_Neighbourhood ON FW_TB_Neighbourhood.NeighbourhoodID = FW_TB_Address.NeighbourhoodID
WHERE UserAddressJSON IS NOT NULL  
SET @time1 = GETDATE()
SELECT DATEDIFF(MICROSECOND ,@time,@time1 )

DECLARE @time DATETIME2
DECLARE @time1 DATETIME2
SET @time = GETDATE()

SELECT UserID , UserName 
, JSON_VALUE(UserAddressJSON , '$.CityName') CityName 
, JSON_VALUE(UserAddressJSON , '$.NeighbourhoodName') NeighbourhoodName
, JSON_VALUE(UserAddressJSON , '$.Address') Address
FROM dbo.FW_TB_User 
WHERE UserAddressJSON IS  NOT NULL

SET @time1 = GETDATE()
SELECT DATEDIFF(MICROSECOND ,@time,@time1 )



7946666