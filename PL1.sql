SET app.ruta_estudiantes = '\Program Files\PostgreSQL\16\data\estudiantes.csv';
--CREATE DATABASE PL1;
CREATE SCHEMA IF NOT EXISTS public;
CREATE TABLE IF NOT EXISTS estudiantes (
    estudiante_id SERIAL PRIMARY KEY,
    nombre TEXT,
    codigo_carrera INT,
    edad INT,
    indice INT
);

DO $$
BEGIN
    EXECUTE format('
COPY estudiantes(nombre, codigo_carrera, edad, indice)
FROM %L
DELIMITER '',''
CSV;
', current_setting('app.ruta_estudiantes'));
END $$;

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

SELECT *
FROM estudiantes
WHERE indice = 500;

SELECT COUNT(*)
FROM estudiantes
WHERE indice = 500;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM estudiantes
WHERE indice = 500;

SHOW shared_buffers;
SELECT pg_size_pretty(pg_total_relation_size('estudiantes'));


SELECT
    relname,
    reltuples AS tuplas_estimadas,
    relpages AS bloques
FROM pg_class
WHERE relname = 'estudiantes';


SELECT
    attname,
    n_distinct,
    most_common_vals
FROM pg_stats
WHERE tablename = 'estudiantes2'
  AND attname = 'indice';


CREATE TABLE estudiantes2 (
    estudiante_id INTEGER,
    nombre TEXT,
    codigo_carrera INTEGER,
    edad INTEGER,
    indice INTEGER
);

INSERT INTO estudiantes2
SELECT
    ROW_NUMBER() OVER (ORDER BY indice),
    nombre,
    codigo_carrera,
    edad,
    indice
FROM estudiantes
ORDER BY indice;

SELECT pg_size_pretty(pg_total_relation_size('estudiantes2'));
SELECT
    relname,
    relpages AS bloques
FROM pg_class
WHERE relname = 'estudiantes2';

DROP TABLE estudiantes2;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM estudiantes2
WHERE indice = 500;

SELECT
    attname,
    n_distinct
FROM pg_stats
WHERE tablename = 'estudiantes2'
  AND attname = 'indice';

--Cuestión 7--

DELETE FROM estudiantes
WHERE estudiante_id IN (
    SELECT estudiante_id
    FROM estudiantes
    ORDER BY random()
    LIMIT 5000000
);

SELECT pg_size_pretty(pg_total_relation_size('estudiantes'));
