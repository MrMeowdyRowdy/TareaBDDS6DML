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

--Versión uno: cantidad TOTAL de examenes
--Se realiza un select de la tabla pacientes y se declara una columna "Paciente"
--la cual contendra el nombre + ' ' + apellido de la persona en una sola celda
-- tambien tendra una columna contador para saber el numero de exámenes que se ha realizado
SELECT (P.nombre+' '+P.apellido) AS 'Paciente', COUNT(idResultado) AS 'Número de exámenes realizados' FROM Paciente P
INNER JOIN Resultado R ON P.idUsuario = R.idUsuario -- Realizamos un inner join a resultado ya que podemos saber asi el numero de examenes en total que se ha realizado el paciente sin importar si son diferentes o no
GROUP BY P.nombre+' '+P.apellido --Se excribe la sentencia para agrupar resultados debido a la operacion count que realizamos
HAVING COUNT(idResultado) >= 3 --Se implementa la condicion para mostrar resultados
----------------------------------------------------------------------------------------
--Version 2 Cantidad de TIPOS de examen
--Se realiza un select de la tabla pacientes y se declara una columna "Paciente"
--la cual contendra el nombre + ' ' + apellido de la persona en una sola celda
-- tambien tendra una columna contador para saber el numero de TIPOS de exámenes que se ha realizado
SELECT (P.nombre+' '+P.apellido) AS 'Paciente', COUNT(idResultado) AS 'Número de exámenes realizados' FROM Paciente P
INNER JOIN Resultado R ON P.idUsuario = R.idUsuario -- Realizamos un inner join a resultado ya que podemos saber asi el numero de examenes se ha realizado el paciente
GROUP BY P.nombre+' '+P.apellido, r.idExamen 
--Se excribe la sentencia para agrupar resultados debido a la operacion count que realizamos, 
--además permite agrupar por tipo de examen para saber cuantos TIPOS de examen se ha 
--realizado el paciente
HAVING COUNT(idResultado) >= 3--Se implementa la condicion para mostrar resultados
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------

--Ejercicio 3

--Indicación:Listado de Pacientes con su edad y el tipo de sangre. 
--Deberá presentarse en el resultado de la consulta las columnas: "Paciente", "Edad", "Tipo de sangre" "Rango de edad" 
--(cuando esté entre 0 y 3 años deberá presentarse en la columna Rango de edad la frase: Bebé; 
--mayor a 3 hasta 11 años: "Niño"; 
--entre 12 y 18 años: "Adolescente"; 
--mayor a 18: "Mayor de edad" )

--Se realiza un select para indicar los datos que queremos extraer
--Se especifica las columnas que deseamos siendo estas:
--Paciente.nombre y la nombramos "Paciente"
--'Edad' que es la columna que creamos para mostrar la edad de la persona
--Paciente.tipoSangre y se nombre "Tipo de sangre"
--'Rango de edad' que es la columna que usamos para poner al paciente en rango en base a su edad

SELECT nombre AS 'Paciente',-- Se muestra el nombre como paciente
'Edad'=--Se crea un columna llamada 'Edad' la cual se va a usar para mostrar la edad del paciente
CASE 
	WHEN CONVERT (date, GETDATE())<= fechaNacimiento THEN DATEDIFF(YEAR, fechaNacimiento, GETDATE()) -- El primer caso es para verificar si la fecha de cumpleaños ya paso entonces se le asigna la edad normalmente
	ELSE DATEDIFF(YEAR, fechaNacimiento, GETDATE())-1 -- El segundo caso es en caso que la fecha de cumpleaños no haya pasado se resta un año debido a que el paciente no ha cumplico aún años
END,
tipoSangre AS 'Tipo de sangre',--Se muestra el tipo de sangre
'Rango de edad'=--Se crea la columna rango de edad en el ual se pondrá al paciente en un rango específico
CASE 
	WHEN DATEDIFF(YEAR, fechaNacimiento, GETDATE()) BETWEEN 0 AND 3 THEN 'Bebé'--primer caso de 0 a 3 años se asigna 'Bebé'
	WHEN DATEDIFF(YEAR, fechaNacimiento, GETDATE()) BETWEEN 3 AND 11 THEN 'Niño'--segundo caso de 3 a 11 años se asigna 'Niño'
	WHEN DATEDIFF(YEAR, fechaNacimiento, GETDATE()) BETWEEN 12 AND 18 THEN 'Adolescente'-- tercer caso de 12 a 18 años se asigna 'Adolescente'
	ELSE 'Mayor de edad'-- caso por defecto se asigna 'Mayor de edad'
END
FROM Paciente
----------------------------------------------------------------------------------------
