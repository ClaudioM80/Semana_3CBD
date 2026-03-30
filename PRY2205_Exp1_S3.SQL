-- ============================================
-- ACTIVIDAD SUMATIVA S3 - PRY2205
-- SCRIPT FINAL
-- ============================================


-- ============================================
-- CASO 1: ANÁLISIS DE PROPIEDADES
-- ============================================

SELECT 
    p.id_propiedad AS "ID_PROPIEDAD",
    p.valor_arriendo AS "VALOR_ARRIENDO",
    p.gasto_comun AS "GASTO_COMUN",
    
    -- Ajuste 10%
    ROUND(p.gasto_comun * 1.10) AS "GASTO_COMUN_AJUSTADO",
    
    p.cantidad_dormitorios AS "DORMITORIOS",
    c.cod_comuna AS "COD_COMUNA"

FROM PROPIEDAD p
JOIN COMUNA c ON p.cod_comuna = c.cod_comuna

WHERE 
    p.valor_arriendo < &VALOR_MAXIMO
    AND p.cantidad_dormitorios IS NOT NULL
    AND c.cod_comuna IN (82, 84, 87)

ORDER BY 
    p.gasto_comun ASC NULLS LAST,
    p.valor_arriendo DESC;


-- ============================================
-- CASO 2: ANÁLISIS DE ANTIGÜEDAD
-- ============================================

SELECT 
    p.id_propiedad AS "ID_PROPIEDAD",
    
    a.fecha_inicio AS "FECHA_INICIO",
    
    NVL(
        TO_CHAR(a.fecha_termino, 'DD-MM-YYYY'),
        'PROPIEDAD ACTUALMENTE ARRENDADA'
    ) AS "FECHA_TERMINO",
    
    ROUND(
        NVL(a.fecha_termino, SYSDATE) - a.fecha_inicio
    ) AS "DIAS_ARRIENDO",
    
    ROUND(
        (NVL(a.fecha_termino, SYSDATE) - a.fecha_inicio)/365
    ) AS "ANIOS_ARRIENDO",
    
    CASE 
        WHEN ((NVL(a.fecha_termino, SYSDATE) - a.fecha_inicio)/365) >= 10 
            THEN 'COMPROMISO DE VENTA'
        WHEN ((NVL(a.fecha_termino, SYSDATE) - a.fecha_inicio)/365) BETWEEN 5 AND 9 
            THEN 'CLIENTE ANTIGUO'
        ELSE 'CLIENTE NUEVO'
    END AS "CLASIFICACION"

FROM ARRIENDO_PROPIEDAD a
JOIN PROPIEDAD p ON a.id_propiedad = p.id_propiedad

WHERE 
    (NVL(a.fecha_termino, SYSDATE) - a.fecha_inicio) > &DIAS_MIN

ORDER BY 
    "DIAS_ARRIENDO" DESC;


-- ============================================
-- CASO 3: PROMEDIOS POR TIPO
-- ============================================

SELECT 
    p.tipo_propiedad AS "TIPO_PROPIEDAD",
    
    ROUND(AVG(p.gasto_comun)) AS "PROM_GASTO_COMUN",
    ROUND(AVG(p.valor_arriendo)) AS "PROM_ARRIENDO",
    
    COUNT(*) AS "TOTAL_PROPIEDADES"

FROM PROPIEDAD p

GROUP BY p.tipo_propiedad

HAVING 
    ROUND(AVG(p.valor_arriendo)) >= &PROM_MIN

ORDER BY 
    p.tipo_propiedad ASC,
    "PROM_ARRIENDO" DESC;
    
    DESC PROPIEDAD;
    
    DESC COMUNA;
    
    DESC ARRIENDO_PROPIEDAD;
    
    
    -- ============================================
-- ACTIVIDAD SUMATIVA S3 - SCRIPT FINAL CORREGIDO
-- ============================================


-- ============================================
-- CASO 1: ANÁLISIS DE PROPIEDADES
-- ============================================

SELECT 
    p.NRO_PROPIEDAD AS "ID_PROPIEDAD",
    p.VALOR_ARRIENDO AS "VALOR_ARRIENDO",
    p.VALOR_GASTO_COMUN AS "GASTO_COMUN",

    -- Ajuste 10%
    ROUND(p.VALOR_GASTO_COMUN * 1.10) AS "GASTO_COMUN_AJUSTADO",

    p.NRO_DORMITORIOS AS "DORMITORIOS",
    c.ID_COMUNA AS "COD_COMUNA"

FROM PROPIEDAD p
JOIN COMUNA c ON p.ID_COMUNA = c.ID_COMUNA

WHERE 
    p.VALOR_ARRIENDO < &VALOR_MAXIMO
    AND p.NRO_DORMITORIOS IS NOT NULL
    AND c.ID_COMUNA IN (82, 84, 87)

ORDER BY 
    p.VALOR_GASTO_COMUN ASC NULLS LAST,
    p.VALOR_ARRIENDO DESC;


-- ============================================
-- CASO 2: ANÁLISIS DE ANTIGÜEDAD
-- ============================================

SELECT 
    p.NRO_PROPIEDAD AS "ID_PROPIEDAD",

    a.FECINI_ARRIENDO AS "FECHA_INICIO",

    NVL(
        TO_CHAR(a.FECTER_ARRIENDO, 'DD-MM-YYYY'),
        'PROPIEDAD ACTUALMENTE ARRENDADA'
    ) AS "FECHA_TERMINO",

    ROUND(
        NVL(a.FECTER_ARRIENDO, SYSDATE) - a.FECINI_ARRIENDO
    ) AS "DIAS_ARRIENDO",

    ROUND(
        (NVL(a.FECTER_ARRIENDO, SYSDATE) - a.FECINI_ARRIENDO)/365
    ) AS "ANIOS_ARRIENDO",

    CASE 
        WHEN ((NVL(a.FECTER_ARRIENDO, SYSDATE) - a.FECINI_ARRIENDO)/365) >= 10 
            THEN 'COMPROMISO DE VENTA'
        WHEN ((NVL(a.FECTER_ARRIENDO, SYSDATE) - a.FECINI_ARRIENDO)/365) BETWEEN 5 AND 9 
            THEN 'CLIENTE ANTIGUO'
        ELSE 'CLIENTE NUEVO'
    END AS "CLASIFICACION"

FROM ARRIENDO_PROPIEDAD a
JOIN PROPIEDAD p ON a.NRO_PROPIEDAD = p.NRO_PROPIEDAD

WHERE 
    (NVL(a.FECTER_ARRIENDO, SYSDATE) - a.FECINI_ARRIENDO) > &DIAS_MIN

ORDER BY 
    "DIAS_ARRIENDO" DESC;


-- ============================================
-- CASO 3: PROMEDIOS POR TIPO
-- ============================================

SELECT 
    p.ID_TIPO_PROPIEDAD AS "TIPO_PROPIEDAD",

    ROUND(AVG(p.VALOR_GASTO_COMUN)) AS "PROM_GASTO_COMUN",
    ROUND(AVG(p.VALOR_ARRIENDO)) AS "PROM_ARRIENDO",

    COUNT(*) AS "TOTAL_PROPIEDADES"

FROM PROPIEDAD p

GROUP BY p.ID_TIPO_PROPIEDAD

HAVING 
    ROUND(AVG(p.VALOR_ARRIENDO)) >= &PROM_MIN

ORDER BY 
    p.ID_TIPO_PROPIEDAD ASC,
    "PROM_ARRIENDO" DESC;