
DECLARE @JSON NVARCHAR(MAX);
SET @JSON
    = N'{
  "_id": "5973782bdb9a930533b05cb2",
  "isActive": true,
  "balance": "$1,446.35",
  "age": 32,
  "eyeColor": "green",
  "name": "Logan Keller",
  "gender": "male",
  "company": "ARTIQ",
  "email": ["logankeller@artiq.com","logan@gmail.com"],
  "phone": "+1 (952) 533-2258",
  "friends": [
    {
      "id": 0,
      "name": "Colon Salazar"
    },
    {
      "id": 1,
      "name": "French Mcneil"
    },
    {
      "id": 2,
      "name": "Martin"
    }
  ],
  "favoriteFruit": "banana"
}'

SET @JSON =( JSON_MODIFY(JSON_MODIFY( JSON_MODIFY(@json , '$.age' , 21 ) , '$.company' , 'RPK') , '$.name' , 'Amirreza Taleb'))
----SET @JSON =( JSON_MODIFY(@json , '$.company' , 'RPK'))
----SET @JSON =( JSON_MODIFY(@json , '$.age' , 21 ))
----SET @JSON =( JSON_MODIFY(@json , '$.email' , 'talebamirreza@gmail.com'))
SET @JSON =( JSON_MODIFY(@json , ' append $.email' , 'talebamirreza@gmail.com'))
SET @JSON =( JSON_MODIFY(@json , '$.friends[0].name' , 'Amirreza Taleb' ))
SET @JSON =( JSON_MODIFY(@json , '$.phone' , '' ))
SET @JSON =( JSON_MODIFY(@json , '$.eyeColor' , null ))
SET @JSON =( JSON_MODIFY(@json , '$.city' , 'Tehran' ))
SET @JSON =( JSON_MODIFY(@json , '$.friends[0].favoriteFood' , 'Ghorme Sabzi' ))
SET @JSON =( JSON_MODIFY(JSON_MODIFY(@json , 'append $.cars' , 'Toyota GT' ) , 'append $.cars' , '206' ))
--SET @JSON =( JSON_MODIFY(@json , 'append $.cars' , 'Toyota GT' ))
SET @JSON =( JSON_MODIFY(@json , '$.Details' , JSON_QUERY('[{"hight":"184","weight":"79"},{"hight":"157","weight":"62"},{"hight":"195","weight":"98"}]' )))




PRINT @JSON



