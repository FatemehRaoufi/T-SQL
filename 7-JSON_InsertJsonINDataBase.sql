'{"UserID": 0,"UserName":"","CityName":"","NeighbourhoodName":"","Address":""}'


--SELECT * FROM dbo.FW_TB_City
--SELECT * FROM dbo.FW_TB_User
--SELECT * FROM dbo.FW_TB_Neighbourhood
--SELECT * FROM dbo.FW_TB_Address

--SELECT * FROM dbo.FW_TB_User

--SELECT ISJSON('{"UserID": 0,"UserName":"","CityName":"","NeighbourhoodName":"","Address":""}')

--UPDATE dbo.FW_TB_User SET UserAddressJSON = '{"UserID": 0,"UserName":"","CityName":"","NeighbourhoodName":"","Address":""}'
--SELECT * FROM dbo.FW_TB_User


DROP TABLE #temp
SELECT * INTO #temp FROM (
SELECT  TOP 10 
Data.UserID,
(SELECT 
UserID,
UserName,
CityName,
NeighbourhoodName,
Address
FROM dbo.FW_TB_User
INNER JOIN dbo.FW_TB_Address ON AddressID = UserAddressID
INNER JOIN dbo.FW_TB_City ON  FW_TB_City.CityID = FW_TB_Address.CityID
INNER JOIN dbo.FW_TB_Neighbourhood ON FW_TB_Neighbourhood.NeighbourhoodID = FW_TB_Address.NeighbourhoodID 
WHERE  Data.UserID = UserID
FOR JSON PATH,WITHOUT_ARRAY_WRAPPER
)Jsonn
FROM (
SELECT 
UserID,
UserName,
CityName,
NeighbourhoodName,
Address
FROM dbo.FW_TB_User
INNER JOIN dbo.FW_TB_Address ON AddressID = UserAddressID
INNER JOIN dbo.FW_TB_City ON  FW_TB_City.CityID = FW_TB_Address.CityID
INNER JOIN dbo.FW_TB_Neighbourhood ON FW_TB_Neighbourhood.NeighbourhoodID = FW_TB_Address.NeighbourhoodID
)Data
)ForUpDate

SELECT * FROM  #temp




WHILE (SELECT COUNT(*) FROM #temp )>0
BEGIN
SELECT TOP 1 * INTO #temp2 FROM #temp
UPDATE dbo.FW_TB_User SET UserAddressJSON = (SELECT  Jsonn FROM #temp2)
WHERE FW_TB_User.UserID = (SELECT UserID FROM #temp2)
DELETE #temp WHERE UserID = (SELECT UserID FROM #temp2)
DROP TABLE  #temp2
END

SELECT * FROM dbo.FW_TB_User WHERE  UserID IN (19507
,20142
,19645
,19943
,20949
,7057
,21173
,20962
,20700
,20933)