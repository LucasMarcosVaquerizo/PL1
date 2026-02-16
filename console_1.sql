CREATE TABLE estudiantes (
    estudiante_id SERIAL PRIMARY KEY,
    nombre TEXT,
    codigo_carrera INT,
    edad INT,
    indice INT
);

COPY estudiantes(nombre, codigo_carrera, edad, indice)
FROM '\Program Files\PostgreSQL\16\data\estudiantes.csv'
DELIMITER ','
CSV;

SELECT COUNT(*) FROM estudiantes;

SELECT oid, relname
FROM pg_class
WHERE relname = 'estudiantes';

SELECT oid FROM pg_database WHERE datname = 'pl1';

SELECT pg_size_pretty(pg_total_relation_size('estudiantes'));

SELECT
    pg_database.datname,
    pg_database_size(pg_database.datname) / 8192 AS bloques_usados
FROM pg_database
WHERE datname = current_database();


SHOW data_directory;

SELECT * from estudiantes;