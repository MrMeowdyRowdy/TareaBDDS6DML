----------------------------------------------------------------------------------------
--Tarea DML
--Autores:
--Chasipanta Pablo
--Ocaña Dennis
--Ramos Xavier
--Version 1.0
--Última actualización: 19/04/2023
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------

--Ejercicio 1

--Indicación:Número de resultados realizados por examen de aquellos que no requieren ayuno.
--La consulta deberá devolver tres columnas: "Examen", "Días de Resultado" y "Número de Préstamos" 

--Se realiza un select para indicar los datos que queremos extraer
--Se especifica las columnas que deseamos siendo estas:
--Examen.Nombre y la nombramos "Examen"
--Examen.diasResultado y se nombre "Días de Resultado"
--Resultado.idResultado la cual se hace un conteo de existencias y se nombra "Préstamos realizados"
SELECT E.nombre AS 'Exámen', diasResultado AS 'Días de Resultado', COUNT(idResultado) AS 'Préstamos realizados' FROM Examen E 
INNER JOIN Resultado R ON E.idExamen = R.idExamen	--Se realiza un inner join para unir los examenes con los resultados obtenidos y asi poder contarlos
WHERE E.ayuno = 0 -- Se establece una condición para mostrar solo los resultados de aquellos que no requieran ayuno
GROUP BY E.nombre, E.diasResultado --los agrupamos por nombre y los dias resultado debido a la operacion COUNT usada

----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--Ejercicio 2
--Indicación: Nombre y apellido de los pacientes (en una sola columna con título "Paciente") 
--y número de exámenes realizado, de quienes se han realizado 3 o más exámenes.

--Se realiza un select de la tabla pacientes y se declara una columna "Paciente"
--la cual contendra el nombre + ' ' + apellido de la persona en una sola celda
-- tambien tendra una columna contador para saber el numero de examenes que se ha realizado
SELECT (P.nombre+' '+P.apellido) AS 'Paciente', COUNT(idResultado) AS 'Número de exámenes realizados' FROM Paciente P
INNER JOIN Resultado R ON P.idUsuario = R.idUsuario
GROUP BY P.nombre+' '+P.apellido
HAVING COUNT(idResultado) >= 3

----------------------------------------------------------------------------------------
