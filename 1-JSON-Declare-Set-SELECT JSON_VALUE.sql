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
  "email": "logankeller@artiq.com",
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
}';


--SELECT ISJSON( @JSON)





SELECT JSON_VALUE(@JSON, '$._id') ID,
       JSON_VALUE(@JSON, '$.name') [Name],
       JSON_VALUE(@JSON, '$.age')Age,
       JSON_VALUE(@JSON, '$.company')Company,
       JSON_VALUE(@JSON, '$.phone')Phone