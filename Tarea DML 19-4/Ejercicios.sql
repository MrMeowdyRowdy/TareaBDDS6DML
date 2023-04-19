----------------------------------------------------------------------------------------
--Tarea DML
--Autores:
--Chasipanta Pablo
--Oca�a Dennis
--Ramos Xavier
--Version 1.0
--�ltima actualizaci�n: 19/04/2023
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------

--Ejercicio 1

--Indicaci�n:N�mero de resultados realizados por examen de aquellos que no requieren ayuno.
--La consulta deber� devolver tres columnas: "Examen", "D�as de Resultado" y "N�mero de Pr�stamos" 

--Se realiza un select para indicar los datos que queremos extraer
--Se especifica las columnas que deseamos siendo estas:
--Examen.Nombre y la nombramos "Examen"
--Examen.diasResultado y se nombre "D�as de Resultado"
--Resultado.idResultado la cual se hace un conteo de existencias y se nombra "Pr�stamos realizados"
SELECT E.nombre AS 'Ex�men', diasResultado AS 'D�as de Resultado', COUNT(idResultado) AS 'Pr�stamos realizados' FROM Examen E 
INNER JOIN Resultado R ON E.idExamen = R.idExamen	--Se realiza un inner join para unir los examenes con los resultados obtenidos y asi poder contarlos
WHERE E.ayuno = 0 -- Se establece una condici�n para mostrar solo los resultados de aquellos que no requieran ayuno
GROUP BY E.nombre, E.diasResultado --los agrupamos por nombre y los dias resultado debido a la operacion COUNT usada

----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--Ejercicio 2
--Indicaci�n: Nombre y apellido de los pacientes (en una sola columna con t�tulo "Paciente") 
--y n�mero de ex�menes realizado, de quienes se han realizado 3 o m�s ex�menes.

--Versi�n uno: cantidad TOTAL de examenes
--Se realiza un select de la tabla pacientes y se declara una columna "Paciente"
--la cual contendra el nombre + ' ' + apellido de la persona en una sola celda
-- tambien tendra una columna contador para saber el numero de ex�menes que se ha realizado
SELECT (P.nombre+' '+P.apellido) AS 'Paciente', COUNT(idResultado) AS 'N�mero de ex�menes realizados' FROM Paciente P
INNER JOIN Resultado R ON P.idUsuario = R.idUsuario -- Realizamos un inner join a resultado ya que podemos saber asi el numero de examenes en total que se ha realizado el paciente sin importar si son diferentes o no
GROUP BY P.nombre+' '+P.apellido --Se excribe la sentencia para agrupar resultados debido a la operacion count que realizamos
HAVING COUNT(idResultado) >= 3 --Se implementa la condicion para mostrar resultados
----------------------------------------------------------------------------------------
--Version 2 Cantidad de TIPOS de examen
--Se realiza un select de la tabla pacientes y se declara una columna "Paciente"
--la cual contendra el nombre + ' ' + apellido de la persona en una sola celda
-- tambien tendra una columna contador para saber el numero de TIPOS de ex�menes que se ha realizado
SELECT (P.nombre+' '+P.apellido) AS 'Paciente', COUNT(idResultado) AS 'N�mero de ex�menes realizados' FROM Paciente P
INNER JOIN Resultado R ON P.idUsuario = R.idUsuario -- Realizamos un inner join a resultado ya que podemos saber asi el numero de examenes se ha realizado el paciente
GROUP BY P.nombre+' '+P.apellido, r.idExamen 
--Se excribe la sentencia para agrupar resultados debido a la operacion count que realizamos, 
--adem�s permite agrupar por tipo de examen para saber cuantos TIPOS de examen se ha 
--realizado el paciente
HAVING COUNT(idResultado) >= 3--Se implementa la condicion para mostrar resultados
----------------------------------------------------------------------------------------
