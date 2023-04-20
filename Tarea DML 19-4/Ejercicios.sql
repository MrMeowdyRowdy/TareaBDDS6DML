----------------------------------------------------------------------------------------
--Tarea DML
--Autores:
--Chasipanta Pablo
--Ocaña Dennis
--Ramos Xavier
--Version 1.0
--Última actualización: 19/04/2023
----------------------------------------------------------------------------------------
USE LabX
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
GO
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--Ejercicio 2
--Indicación: Nombre y apellido de los pacientes (en una sola columna con título "Paciente") 
--y número de exámenes realizado, de quienes se han realizado 3 o más exámenes.

--Versión 1: cantidad TOTAL de examenes
--Se realiza un select de la tabla pacientes y se declara una columna "Paciente"
--la cual contendra el nombre + ' ' + apellido de la persona en una sola celda
-- tambien tendra una columna contador para saber el numero de exámenes que se ha realizado
SELECT (P.nombre+' '+P.apellido) AS 'Paciente', COUNT(idResultado) AS 'Número de exámenes realizados' FROM Paciente P
INNER JOIN Resultado R ON P.idUsuario = R.idUsuario -- Realizamos un inner join a resultado ya que podemos saber asi el numero de examenes en total que se ha realizado el paciente sin importar si son diferentes o no
GROUP BY P.nombre+' '+P.apellido --Se excribe la sentencia para agrupar resultados debido a la operacion count que realizamos
HAVING COUNT(idResultado) >= 3 --Se implementa la condicion para mostrar resultados
GO
----------------------------------------------------------------------------------------
--Version 2: Cantidad de TIPOS de examen
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
GO
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
GO
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------

--Ejercicio 4

--Indicación:Listado de exámenes de aquellos que han sido realizados el mismo día del pedido

--idResultado y la nombramos "Identificador"
--E.nombre la usamos como 'Nombre exámen'
--R.fechaPedido se usa para identificar la 'Fecha de petición'
--R.fechaExamen se usa para identificar la 'Fecha de realización' 
--Paciente.tipoSangre y se nombre "Tipo de sangre"
--'Rango de edad' que es la columna que usamos para poner al paciente en rango en base a su edad

SELECT R.idResultado AS 'Identificador',E.nombre AS 'Nombre exámen',
R.fechaPedido AS 'Fecha de petición',R.fechaExamen AS 'Fecha de realización' 
FROM Resultado R
RIGHT JOIN Examen E ON R.idExamen=E.idExamen --se une las tablas de resultado en el centro y examen a la derecha para poder tener el nombre de examen y las fechas requeridas
WHERE DATEDIFF(DAY, R.fechaPedido, R.fechaExamen)=0 --se compara el día de pedido del examen y el dia de realización para comprobar si se hicieron el mismo día y mostrar los resultados
GO
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--EJERCICIO 5

--Modificación de datos:  Cree una tabla llamada "Laboratorista" 
--basada en los registros de Paciente, que incluya los 5 primeros 
--clientes ordenados de manera descendente por la edad que están 
--registrados en la tabla. Asígneles a los Entrenadores un correo 
--compuesto por primera letra de nombre seguido de apellido@laboratorio.ec

DROP TABLE IF EXISTS Laboratorista -- Verifico si existe la tabla laboratoristas para eliminarla y crear una nueva
--Selecciono los 5 primeros ordenados por fecha de nacimiento de manera descendente y tomo todos los valores dentro de la tabla pacientes 
--para insertarlos dentro de una nueva tabla laboratorista
SELECT TOP 5 idUsuario, cedula, nombre,apellido,CONCAT(LEFT(nombre,1),apellido,'@laboratorio.ec') as mail,telefono,fechaNacimiento,tipoSangre,usuarioRegistro,fechaRegistro --describe que datos obtener
INTO Laboratorista --describe donde ingresar
FROM Paciente
ORDER BY DATEDIFF(DAY,fechaNacimiento, GETDATE()) DESC --ordeno por la diferencia de edad de manera descendiente

SELECT * FROM Laboratorista --muestro tabla laboratorista
GO
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--Ejercicio 6

--Indicación:Genere el script que devuelva el nombre y apellido (en una sola columna) 
--y el tipo de usuario Paciente o Laboratorista de las personas registradas en la base de datos. 
--En el caso que sean Paciente y Laboratorista deberá tener esa especificación.  

--Se realiza en primer lugar la unión de las tablas que se necesita en base al nombre y apellido
--Se usará nombre y apellido para unir en una nueva columna
--se define 'Rol' para determinar si es paciente, laboratorista o ambas

DROP TABLE IF EXISTS #PacientesLaboratoristas -- se verifica si exste ya la tabla para crearla nuevamente

SELECT nombre,apellido INTO   #PacientesLaboratoristas 
FROM   (SELECT P.Nombre, P.Apellido FROM Paciente P 
		UNION  
		SELECT L.Nombre, L.Apellido FROM Laboratorista L) n -- se realiza la unión de las tablas por medio de UNION ya que no tienen una relación directa

SELECT PL.nombre + ' ' + PL.apellido AS 'Nombre completo', -- se crea 'Nombre completo' con nombre y apellido
'Rol'=
CASE 
	WHEN PL.nombre + ' ' + PL.apellido IN (SELECT L.nombre + ' ' + L.apellido FROM Laboratorista L) 
	AND PL.nombre + ' ' + PL.apellido IN(SELECT P.nombre + ' ' + P.apellido FROM Paciente P) THEN 'Paciente y Laboratorista' -- Pirmer caso para verificar si es paciente y laboratorista
	WHEN PL.nombre + ' ' + PL.apellido IN (SELECT L.nombre + ' ' + L.apellido FROM Laboratorista L) THEN 'Laboratorista' --Segundo caso para verificar si es solo laboratorista
	ELSE 'Paciente' --Caso por defecto en caso que sea paciente
END
FROM #PacientesLaboratoristas PL
GO
----------------------------------------------------------------------------------------