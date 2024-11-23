#!/bin/bash
mongoimport --db="${MONGO_INITDB_DATABASE}" --collection='ml_model' --file='/docker-entrypoint-initdb.d/ml_model.json'