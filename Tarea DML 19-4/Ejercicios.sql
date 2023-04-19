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
--Indicaci�n


----------------------------------------------------------------------------------------
