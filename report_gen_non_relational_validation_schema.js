db.createCollection("articleContent", {
    validator: {
      $jsonSchema: {
		required: [ 'link' ],
        properties: {
		  _id: {
            bsonType: 'binData',
            description: '\'_id\' must be binary data in uuid format and is required'
          },
          link: {
            bsonType: 'string',
            description: '\'link\' must be a string and is required'
          },
          name: {
            bsonType: ['string', 'null'],
            description: '\'name\' must be a string (can be null)'
          },
		  date: {
            bsonType: ['date', 'null'],
            description: '\'date\' must be a date (can be null)'
          },
          description: {
            bsonType: ['string', 'null'],
            description: '\'description\' must be a string (can be null)'
          }
        }
      }
    }
  });
  
db.getCollection("articleContent").createIndex({
	_id: 1
});

db.getCollection("articleContent").createIndex({
	link: 1
});

db.createCollection("ml_model");