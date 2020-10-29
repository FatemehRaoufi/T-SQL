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
      "name": "French Mcneil",
	    "phone": "+1 (952) 536-2258",
		"age": 32
    },
    {
      "id": 2,
      "name": "Martin",
	    "phone": "+1 (967) 533-2908",
		"cars": {"firstCar":"206"}

    },
	 {
      "id": 3,
      "name": "Amir",
	    "phone": "+1 (942) 533-2258",
		"cars": {"firstCar":"206","currentCar":"CLS 500"}

    },
	 {
      "id": 4,
      "name": "Ali",
	    "phone": "+1 (953) 533-2278",
		"cars": {"firstCar":"peykan","b":"206"}
		,	"age": 85
		
    },
	 {
      "id": 5,
      "name": "Mona",
	    "phone": "+1 (922) 533-2250",
		"cars": {"firstCar":"206","currentCar":"207"}

    }
  ],
  "favoriteFruit": "adads"
   

}';

--SELECT ISJSON(@JSON)
SELECT
	   info.name,
       info.phone,
       info.Sen,
       info.FirstCar,
       info.currentCar,
	   info.Cars,
       JSON_VALUE(info.Cars,'$.firstCar')+'=>'+ISNULL(JSON_VALUE(info.Cars,'$.currentCar'),'NoCar')
	   FROM 
	    EXEC sys.he
(
SELECT 
*
FROM
    OPENJSON(@JSON, '$.friends')
    WITH
    (
        name NVARCHAR(MAX)
		,phone NVARCHAR(MAX)-- '$.phone'
		,Sen INT '$.age'
        ,FirstCar NVARCHAR(200) '$.cars.firstCar'
		,currentCar NVARCHAR(200) '$.cars.currentCar'
		,Cars  NVARCHAR(max) '$.cars' AS JSON

		)
		)info


