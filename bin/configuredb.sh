#!/usr/bin/env bash

export PGPASSWORD='Gj5ZQ8P7$!L*qy9!~AMT#E8J6q<(@d'

database="spruceBarbershopDB"

echo "Configuring database: $database"

dropdb -U spruce_admin spruceBarbershopDB
createdb -U spruce_admin spruceBarbershopDB

psql -U spruce_admin spruceBarbershopDB < ./bin/sql/spruceBarbershopDB.sql

echo "$database configured"
