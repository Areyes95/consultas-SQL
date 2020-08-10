--Pregunta N° 1: ¿Cantidad unidades de personas cuyo cargo sea  Docentes cuyo Salario es mayor a $2.000.000 en donde Fecha comienzo sea mayor a 1990?

-- Con Valores duplicados y menores de edad

SELECT		
			COUNT(per.per_id)		AS CANTIDAD_PERSONA, 
			car.car_nombre			AS CARGO
FROM		
						CONTRATO	AS	con
			INNER JOIN	PERSONA		AS	per 	ON con.persona_per_id	= per.per_id
			INNER JOIN	CARGO		AS	car 	ON con.cargo_car_id		= car.car_id
WHERE		
						car.car_id										=	4		
			AND			con.con_salario									>	2000000 
			AND 		YEAR(con.con_fecha_ingreso) 					>	1990
GROUP BY	
			car.car_nombre;


-- Sin Valores duplicados ni menores de edad

SELECT		
			COUNT(per.per_id)		AS CANTIDAD_PERSONA, 
			car.car_nombre			AS CARGO
FROM		
						CONTRATO	AS	con
			INNER JOIN	PERSONA		AS	per 	ON con.persona_per_id	= per.per_id
			INNER JOIN	CARGO		AS	car 	ON con.cargo_car_id		= car.car_id
WHERE		
						car.car_id										=	4		
			AND			con.con_salario									>	2000000 
			AND 		YEAR(con.con_fecha_ingreso) 					>	1990
			AND			(
							con.cod_id_empleado	NOT IN (
								SELECT		con.cod_id_empleado	AS	Empleado_Unico
								FROM		CONTRATO			AS	con
								INNER JOIN	PERSONA				AS	per
								ON			con.persona_per_id	=	per.per_id
								WHERE		((CONVERT(int,CONVERT(char(8),con.con_fecha_ingreso,112))-CONVERT(char(8),per.per_fecha_nacimiento,112))/10000) < 18
								)
								AND		con.cod_id_empleado NOT IN	(															
									SELECT		cod_id_empleado
									FROM		CONTRATO
									GROUP BY	cod_id_empleado
									HAVING		COUNT(cod_id_empleado) > 1
								)								
						)
GROUP BY	
			car.car_nombre;


	
-- Pregunta N° 2: ¿Cantidad unidades de personas cuyo cargo es Administrativo que se encuentran en la Facultad de Diseño que tengan Salario mayor a 2.500.000 en donde Fecha comienzo es menor igual a 1990?

-- Con Valores duplicados y menores de edad

SELECT 
	COUNT(per.per_id)	AS	CANTIDAD_PERSONA, 
	car.car_nombre		AS	CARGO,
	fac.fac_nombre		AS	FACULTAD
FROM 
				CONTRATO	con
	INNER JOIN	PERSONA		per		ON con.persona_per_id	= per.per_id
	INNER JOIN	CARGO		car		ON con.cargo_car_id		= car.car_id
	INNER JOIN	FACULTAD	fac		ON con.facultad_fac_id	= fac.fac_id
WHERE 
		car.car_id					=	1 
	AND fac.fac_id					=	4 
	AND con.con_salario				>	2500000 
	AND YEAR(con.con_fecha_ingreso) <=	1990

GROUP BY 
	car.car_nombre, 
	fac.fac_nombre;


-- Sin Valores duplicados ni menores de edad

SELECT 
	COUNT(per.per_id)	AS	CANTIDAD_PERSONA, 
	car.car_nombre		AS	CARGO,
	fac.fac_nombre		AS	FACULTAD
FROM 
				CONTRATO	con
	INNER JOIN	PERSONA		per		ON con.persona_per_id	= per.per_id
	INNER JOIN	CARGO		car		ON con.cargo_car_id		= car.car_id
	INNER JOIN	FACULTAD	fac		ON con.facultad_fac_id	= fac.fac_id
WHERE 
		car.car_id					=	1				
	AND fac.fac_id					=	4 
	AND con.con_salario				>	2500000 
	AND YEAR(con.con_fecha_ingreso) <=	1990
	AND			(
							con.cod_id_empleado	NOT IN (
								SELECT		con.cod_id_empleado	AS	Empleado_Unico
								FROM		CONTRATO			AS	con
								INNER JOIN	PERSONA				AS	per
								ON			con.persona_per_id	=	per.per_id
								WHERE		((CONVERT(int,CONVERT(char(8),con.con_fecha_ingreso,112))-CONVERT(char(8),per.per_fecha_nacimiento,112))/10000) < 18
								)
								AND		con.cod_id_empleado NOT IN	(															
									SELECT		cod_id_empleado
									FROM		CONTRATO
									GROUP BY	cod_id_empleado
									HAVING		COUNT(cod_id_empleado) > 1
								)								
				)
GROUP BY 
	car.car_nombre, 
	fac.fac_nombre;



-- Pregunta N° 3 ¿Cantidad unidades de personas cuyo cargo sea Técnicos ubicados en Medellín cuya edad es menor igual 65 años en donde Fch comienzo es mayor a 1980?

-- Con Valores duplicados y menores de edad

SELECT 
	COUNT(per.per_id)														AS CANTIDAD_PERSONAS, 
	car.car_nombre															AS CARGO, 
	sec.sec_nombre															AS SECCIONA,
	CAST(DATEDIFF(DD, per.per_fecha_nacimiento, getdate())/365.25 AS INT)	AS EDAD
FROM 
				CONTRATO	con
	INNER JOIN	PERSONA		per ON con.persona_per_id	=	per.per_id
	INNER JOIN	CARGO		car ON con.cargo_car_id		=	car.car_id
	INNER JOIN	SECCIONAL	sec ON con.seccional_sec_id	=	sec.sec_id
WHERE 
		YEAR(con.con_fecha_ingreso)												>	1980 
	AND CAST(DATEDIFF(DD, per.per_fecha_nacimiento, getdate())/365.25 AS INT)	<=	65
	AND car.car_id = 6
	AND sec.sec_id = 3
GROUP BY  
	per.per_id,
	car.car_nombre, 
	sec.sec_nombre, 
	per.per_fecha_nacimiento
ORDER BY 
	EDAD Desc;

-- Sin Valores duplicados ni menores de edad

SELECT 
	COUNT(per.per_id)														AS CANTIDAD_PERSONAS, 
	car.car_nombre															AS CARGO, 
	sec.sec_nombre															AS SECCIONA,
	CAST(DATEDIFF(DD, per.per_fecha_nacimiento, getdate())/365.25 AS INT)	AS EDAD
FROM 
				CONTRATO	con
	INNER JOIN	PERSONA		per ON con.persona_per_id	=	per.per_id
	INNER JOIN	CARGO		car ON con.cargo_car_id		=	car.car_id
	INNER JOIN	SECCIONAL	sec ON con.seccional_sec_id	=	sec.sec_id
WHERE 
		YEAR(con.con_fecha_ingreso)												>	1980 
	AND CAST(DATEDIFF(DD, per.per_fecha_nacimiento, getdate())/365.25 AS INT)	<=	65
	AND car.car_id = 6
	AND sec.sec_id = 3
	AND		(
				con.cod_id_empleado	NOT IN (
					SELECT		con.cod_id_empleado	AS	Empleado_Unico
					FROM		CONTRATO			AS	con
					INNER JOIN	PERSONA				AS	per
					ON			con.persona_per_id	=	per.per_id
					WHERE		((CONVERT(int,CONVERT(char(8),con.con_fecha_ingreso,112))-CONVERT(char(8),per.per_fecha_nacimiento,112))/10000) < 18
					)
					AND		con.cod_id_empleado NOT IN	(															
						SELECT		cod_id_empleado
						FROM		CONTRATO
						GROUP BY	cod_id_empleado
						HAVING		COUNT(cod_id_empleado) > 1
					)								
			)
GROUP BY  
	per.per_id,
	car.car_nombre, 
	sec.sec_nombre, 
	per.per_fecha_nacimiento
ORDER BY 
	EDAD Desc;


-- ¿Cantidad de unidades de persona cuyo fech nacimiento corresponde entre 1960 y 1970 pertenezcan a la facultad de Administración en donde en la seccional de medellín?

-- Con Valores duplicados y menores de edad

SELECT 
	COUNT(per.per_id)	AS	CANTIDAD_PERSONAS, 
	fac.fac_nombre		AS	FACULTAD, 
	sec.sec_nombre		AS	SECCIONAL
FROM 
				CONTRATO	con
	INNER JOIN	PERSONA		per		ON con.persona_per_id	= per.per_id
	INNER JOIN	FACULTAD	fac		ON con.facultad_fac_id	= fac.fac_id
	INNER JOIN	SECCIONAL	sec		ON con.seccional_sec_id = sec.sec_id
WHERE 
		YEAR(per.per_fecha_nacimiento) BETWEEN 1960 AND 1970 
	AND fac.fac_id						= 1 
	AND sec.sec_id						= 3
GROUP BY 
	fac.fac_nombre, 
	sec.sec_nombre;

-- Sin Valores duplicados ni menores de edad

SELECT 
	COUNT(per.per_id)	AS	CANTIDAD_PERSONAS, 
	fac.fac_nombre		AS	FACULTAD, 
	sec.sec_nombre		AS	SECCIONAL
FROM 
				CONTRATO	con
	INNER JOIN	PERSONA		per		ON con.persona_per_id	= per.per_id
	INNER JOIN	FACULTAD	fac		ON con.facultad_fac_id	= fac.fac_id
	INNER JOIN	SECCIONAL	sec		ON con.seccional_sec_id = sec.sec_id
WHERE 
		YEAR(per.per_fecha_nacimiento) BETWEEN 1960 AND 1970 
	AND fac.fac_id						= 1 
	AND sec.sec_id						= 3
	AND		(
				con.cod_id_empleado	NOT IN (
					SELECT		con.cod_id_empleado	AS	Empleado_Unico
					FROM		CONTRATO			AS	con
					INNER JOIN	PERSONA				AS	per
					ON			con.persona_per_id	=	per.per_id
					WHERE		((CONVERT(int,CONVERT(char(8),con.con_fecha_ingreso,112))-CONVERT(char(8),per.per_fecha_nacimiento,112))/10000) < 18
					)
					AND		con.cod_id_empleado NOT IN	(															
						SELECT		cod_id_empleado
						FROM		CONTRATO
						GROUP BY	cod_id_empleado
						HAVING		COUNT(cod_id_empleado) > 1
					)								
			)
GROUP BY 
	fac.fac_nombre, 
	sec.sec_nombre;



