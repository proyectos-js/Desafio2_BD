
-- 1. Crear base de datos llamada películas (1 punto)

CREATE DATABASE peliculas;

-- 2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas. (2 puntos)

CREATE TABLE pelicula(
id SERIAL, 
nombre VARCHAR(60), 
año_estreno SMALLINT, 
director VARCHAR(25),  
PRIMARY KEY (id)
);

CREATE TABLE reparto(
idpelicula INT, 
nombreactor VARCHAR(30)
);

-- 3. Cargar ambos archivos a su tabla correspondiente (1 punto)

\copy pelicula FROM '/home/julio/Escritorio/Desafio2_BD/peliculas.csv' CSV HEADER ; 
\copy reparto FROM '/home/julio/Escritorio/Desafio2_BD/reparto.csv' CSV HEADER ;

-- 4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto. (0.5 puntos)

SELECT a.nombre as titulo, año_estreno, director, b.nombreactor  
FROM pelicula a LEFT JOIN reparto b 
ON a.id=b.idpelicula 
WHERE a.nombre = 'Titanic';

-- 5. Listar los titulos de las películas donde actúe Harrison Ford.(0.5 puntos)

SELECT a.nombre as titulos
FROM pelicula a LEFT JOIN reparto b 
ON a.id=b.idpelicula 
WHERE b.nombreactor = 'Harrison Ford';

-- 6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en eltop 100.(1 puntos)

SELECT  director  as Directores FROM pelicula WHERE id < 11;

-- 7. Indicar cuantos actores distintos hay (1 puntos)

SELECT count(distinct(nombreactor)) as CANTIDAD_ACTORES FROM reparto;

-- 8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas portítulo de manera ascendente.(1 punto)

SELECT nombre as peliculas, año_estreno FROM pelicula WHERE año_estreno BETWEEN 1990 AND 1999 ORDER BY nombre ;


-- 9. Listar el reparto de las películas lanzadas el año 2001 (1 punto)

SELECT  b.nombreactor AS Reparto 
FROM pelicula a LEFT JOIN reparto b 
ON a.id=b.idpelicula 
WHERE a.año_estreno = 2001;

-- 10. Listar los actores de la película más nueva (1 punto)

SELECT  b.nombreactor AS Actores 
FROM pelicula a LEFT JOIN reparto b 
ON a.id=b.idpelicula 
WHERE a.año_estreno = SELECT max(año_estreno) FROM pelicula;
