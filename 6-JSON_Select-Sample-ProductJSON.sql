
--SELECT * FROM (
--SELECT  NEWID() productID, 'Pen K346' productName  , 0.7 size,   145200 Price , 'Red' "color.title"  , '#EA1515' "color.Hex"
--UNION ALL 
--SELECT  NEWID() productID, 'Pen K456' productName  , 0.7 size,   145200 Price , 'blue' "color.title" , '#EA1515' "color.Hex"
--UNION ALL 
--SELECT  NEWID() productID, 'Pen A34' productName  ,  0.7 size,  145200 Price , 'Red' "color.title"  ,'#EA1515' "color.Hex"
--UNION ALL 
--SELECT  NEWID() productID, 'Pen K345' productName  ,1.5 size,    146200 Price , 'blue' "color.title" , '#EA1515' "color.Hex"
--UNION ALL 
--SELECT  NEWID() productID, 'Pen B4' productName  ,  0.2 size,     145200 Price , 'blue' "color.title"  ,'#EA1515' "color.Hex"
--UNION ALL 
--SELECT  NEWID() productID, 'Pen HB' productName  ,  1.7 size,    145200 Price , 'Red' "color.title" , '#EA1515' "color.Hex"
--)ProductDetails
--FO.R JSON PATH 




SELECT  NEWID() productID, 'Pen HB' productName  ,  1.7 size,    145200 Price , 'Red' "color.title" , '#EA1515' "color.Hex" 
, JSON_QUERY('{"productID":"86ECB725-C443-48DC-B8E9-0D8BC144C1FF","productName":"Pen HB","size":1.7,"Price":145200,"color":{"title":"Red","Hex":"#EA1515"}}' )NestedJSON
FOR JSON PATH 

