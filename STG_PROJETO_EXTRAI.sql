
SELECT

	REPLICATE('0',11 -LEN(CPF_DOCENTE)) + CPF_DOCENTE AS CPF_DOCENTE,
	[COMPETICAO],
	[QTD_Selecionado],
	[QTD_PODIUM_1],
	[QTD_PODIUM_2],
	[QTD_PODIUM_3],

	/* REGRA INOVA NACIONAL */
	CASE
		WHEN [COMPETICAO] = 'INOVA NACIONAL'
		THEN
			SUM(QTD_Selecionado) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_Selecionado) * 3
		ELSE
			0

	END +
	CASE
		WHEN COMPETICAO = 'INOVA NACIONAL' AND QTD_PODIUM_1 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 15
		
		WHEN COMPETICAO = 'INOVA NACIONAL' AND QTD_PODIUM_2 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 13
		
		WHEN COMPETICAO = 'INOVA NACIONAL' AND QTD_PODIUM_3 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 10
		ELSE
			0
	END TOTAL_INOVA_NAC,
	
	CASE
		WHEN [COMPETICAO] = 'INOVA ESTADUAL'
		THEN
			SUM(QTD_Selecionado) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_Selecionado)
		ELSE
			0

	END +
	CASE
		WHEN COMPETICAO = 'INOVA ESTADUAL' AND QTD_PODIUM_1 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 05
		
		WHEN COMPETICAO = 'INOVA ESTADUAL' AND QTD_PODIUM_2 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 03
		
		WHEN COMPETICAO = 'INOVA ESTADUAL' AND QTD_PODIUM_3 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 01
		ELSE
			0
	END TOTAL_INOVA_EST,
	
	CASE
		WHEN [COMPETICAO] = 'PROJETO INTEGRADOR'
		THEN
			SUM(QTD_Selecionado) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_Selecionado)
		ELSE
			0

	END +
	CASE
		WHEN COMPETICAO = 'PROJETO INTEGRADOR' AND QTD_PODIUM_1 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 15
		
		WHEN COMPETICAO = 'PROJETO INTEGRADOR' AND QTD_PODIUM_2 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 13
		
		WHEN COMPETICAO = 'PROJETO INTEGRADOR' AND QTD_PODIUM_3 = 'SIM'
		THEN
			COUNT(1) OVER (PARTITION BY COMPETICAO, CPF_DOCENTE, QTD_PODIUM_1) * 10
		ELSE
			0
	END TOTAL_PROJ_INTEGRADOR

FROM [DS].[DBO].[STG_PROJETO]

WHERE CPF_DOCENTE IS NOT NULL