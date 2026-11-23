# Fase 1: Presentacion Oral del EDA -- Guia para Estudiantes

**Estadistica 2026-II** | Pontificia Universidad Javeriana
**Fecha:** Septiembre 11, 2026 (Sesion 04)
**Peso:** 20% de la nota del proyecto

---

## Como funciona la sesion

Cada grupo tiene **3 minutos exactos** para presentar oralmente los hallazgos de su Analisis Exploratorio de Datos (EDA). Despues de cada presentacion, se abren **2 minutos de preguntas** de los demas grupos.

No hay diapositivas obligatorias. Pueden usar pantalla compartida con graficos, un PDF, o lo que prefieran, pero el foco esta en lo que dicen, no en el formato.

---

## Su nota tiene dos partes

| Componente | Peso | Que se evalua |
|---|---|---|
| **Presentacion del grupo** | **70%** | Contenido estadistico, comunicacion, dominio del tema |
| **Participacion como audiencia** | **30%** | Calidad de preguntas que hacen a otros grupos |

Las dos partes suman la nota final de Fase 1. Un grupo que presenta bien pero no participa como audiencia pierde hasta el 30% de su nota.

---

## Sobre la presentacion (70%)

En 3 minutos deben mostrar:

1. **Su pregunta de investigacion** (en una oracion).
2. **Sus hallazgos principales** (minimo 3), con numeros especificos. No digan "encontramos una diferencia"; digan "la brecha es de 12 puntos en ingles entre estrato 1 y estrato 5, condicionando por cuartil de entrada."
3. **Al menos 6 visualizaciones** (8 si son grupo ambicioso de 5 personas). Muestren los graficos mas reveladores, no todos. Cada grafico debe tener titulo, ejes etiquetados y una oracion de interpretacion.
4. **Por que importa.** Conecten sus datos con una decision real. No estan haciendo un ejercicio academico: estan analizando datos reales sobre desigualdad en Colombia.

**Lo que NO es una buena presentacion:**
- Leer el codigo de R linea por linea.
- Describir que funciones usaron ("usamos ggplot con geom_bar y fill").
- Mostrar 15 graficos en 3 minutos sin interpretar ninguno.
- Decir "encontramos cosas interesantes" sin decir cuales.

**Lo que SI es una buena presentacion:**
- "Nuestra pregunta es si el estrato sigue pesando despues de entrar a la universidad. La respuesta corta es si. Dentro del mismo cuartil de Saber 11, un estudiante de estrato 1 saca en promedio 8.3 puntos menos en Saber Pro que uno de estrato 5. Esta brecha es mayor en ingles (12.1 puntos) que en razonamiento cuantitativo (4.7 puntos). Este grafico lo muestra: [muestra boxplot]. La implicacion es que la universidad no esta cerrando la brecha socioeconomica, al menos no en competencias que dependen de exposicion cultural como el ingles."

---

## Sobre la participacion como audiencia (30%)

Cuando otro grupo presenta, ustedes **no son espectadores**. Son tomadores de decision: rectores de universidad, funcionarios del Ministerio de Educacion, senadores, directores de programa. Su trabajo es hacer preguntas que desafien el analisis y conecten los hallazgos con decisiones reales.

### Que tipo de preguntas dan puntos

| Tipo | Ejemplo | Puntaje |
|---|---|---|
| **Critica / de decision** | "Si usted fuera el rector de una IES publica en Choco y viera esos datos, que politica implementaria primero?" | **1.0 punto** |
| **Critica / de decision** | "Esa correlacion podria estar confundida por estrato? Controlaron por eso?" | **1.0 punto** |
| **Critica / de decision** | "Si la brecha se cierra en cuantitativo pero no en ingles, que dice eso sobre la oferta curricular?" | **1.0 punto** |
| **Analitica** | "Por que usaron Spearman y no solo Pearson?" | **0.5 puntos** |
| **Analitica** | "Que pasa si excluyen outliers de su variable dependiente?" | **0.5 puntos** |
| **Basica / superficial** | "Cuantas observaciones tienen?" | **0.0 puntos** |
| **Basica / superficial** | "Que libreria usaron para el grafico?" | **0.0 puntos** |

### Como se traduce a nota

| Puntos acumulados en la sesion | Nota de participacion |
|---|---|
| 2.0 o mas | 5.0 |
| 1.5 | 4.0 |
| 1.0 | 3.0 |
| 0.5 | 2.0 |
| 0 (no participo) | 1.0 |

**En otras palabras:** con dos buenas preguntas criticas durante toda la sesion, su grupo obtiene 5.0 en participacion. Si no preguntan nada, obtienen 1.0.

---

## Requisitos minimos del EDA (entrega de codigo)

Ademas de la presentacion oral, cada grupo debe entregar su script de R (`fase1_grupoX.R`) con:

- Carga de datos desde el cruce Saber 11 - Saber Pro.
- Estadistica descriptiva completa: medidas de tendencia central, dispersion, forma y posicion para las variables relevantes de su proyecto.
- Correlaciones (Pearson y Spearman) donde aplique.
- Minimo 6 visualizaciones (8 para grupos ambiciosos).
- Minimo 3 hallazgos sustantivos (4 para grupos ambiciosos).
- Codigo reproducible: que corra de principio a fin sin errores.

---

## Proyectos por grupo

Todos los grupos usan el cruce Saber 11 - Saber Pro: la trayectoria completa del mismo estudiante desde el colegio hasta la universidad.

### Grupo 1 (4 personas) -- Meritocracia y origen territorial
**Perdigon, Paez, Rodriguez, Ramirez**

Pregunta central: Los mejores estudiantes de colegios publicos rurales de departamentos perifericos (Cauca, Choco, Narino), superan en Saber Pro a los peores estudiantes de colegios privados de Bogota? El esfuerzo individual compensa la desventaja estructural?

- Comparar el percentil 90 de Saber 11 en colegios publicos rurales vs. el percentil 10 de colegios privados de Bogota: que pasa con sus puntajes en Saber Pro?
- La ventaja de Bogota se mantiene, se reduce o se invierte despues de la universidad?
- Variables Y: PUNT_GLOBAL (Saber Pro), MOD_RAZONA_CUANTITAT_PUNT
- Variables clave: COLE_DEPTO_UBICACION, COLE_NATURALEZA, COLE_AREA_UBICACION, FAMI_ESTRATOVIVIENDA, PUNT_GLOBAL (SB11)

---

### Grupo 2 (5 personas, alcance ambicioso) -- La trampa del estrato: el origen socioeconomico determina el destino academico?
**Carreno, Gaitan, Herrera, Garavito, Bonilla**

Pregunta central: Un estudiante de estrato 1 que obtiene un puntaje alto en Saber 11 logra el mismo resultado en Saber Pro que un estudiante de estrato 5 con el mismo puntaje de entrada? El estrato sigue pesando despues de entrar a la universidad?

- Condicionar por cuartil de Saber 11: dentro de cada cuartil, persiste la brecha por estrato en Saber Pro?
- La brecha es mayor en modulos especificos (ingles vs. razonamiento cuantitativo)?
- Que papel juega el tipo de IES (publica vs. privada) como mediador?
- Desagregar por region: la trampa del estrato es peor en la periferia que en Bogota?
- Comparar carreras afines a economia/administracion vs. otras: el estrato pesa igual?
- Variables Y: PUNT_GLOBAL (SBPro), MOD_INGLES_PUNT, MOD_RAZONA_CUANTITAT_PUNT
- Variables clave: FAMI_ESTRATOVIVIENDA, PUNT_GLOBAL (SB11), INST_ORIGEN, ESTU_DEPTO_RESIDE, ESTU_PRGM_ACADEMICO, FAMI_EDUCACIONMADRE
- Alcance adicional: minimo 8 visualizaciones en Fase 1

---

### Grupo 3 (4 personas) -- Brecha digital: el acceso a internet cierra o abre distancias?
**Castillo, Olaya, Novoa, Garcia**

Pregunta central: Los estudiantes sin internet ni computador en el hogar que logran llegar a la universidad cierran la brecha con sus pares conectados, o la mantienen en Saber Pro?

- Calcular el salto (diferencia estandarizada SBPro - SB11): es mayor para quienes no tenian internet?
- La brecha digital pesa mas en lectura critica o en razonamiento cuantitativo?
- Variables Y: PUNT_GLOBAL (SBPro), MOD_LECTURA_CRITICA_PUNT
- Variables clave: FAMI_TIENEINTERNET, FAMI_TIENECOMPUTADOR, FAMI_ESTRATOVIVIENDA, ESTU_ZONA_RESIDE, PUNT_GLOBAL (SB11)

---

### Grupo 4 (5 personas, alcance ambicioso) -- Genero y carreras de economia: la universidad iguala o amplifica?
**Carrisosa, Hernandez, Gutierrez, Martinez, Perez**

Pregunta central: Las mujeres que estudian carreras afines a economia y administracion parten con desventaja en Saber 11 pero convergen en Saber Pro, o la brecha persiste?

- Comparar la brecha de genero en Saber 11 vs. Saber Pro para carreras de economia/administracion.
- La brecha difiere entre modulos (ingles, razonamiento cuantitativo, competencias ciudadanas)?
- El tipo de IES (publica vs. privada) modera la brecha de genero?
- Heterogeneidad regional: la brecha de genero es mayor en departamentos perifericos?
- Como se compara la brecha de genero en economia/administracion vs. otras carreras (ingenieria, salud, derecho)?
- Variables Y: MOD_RAZONA_CUANTITAT_PUNT, MOD_INGLES_PUNT, MOD_COMPETEN_CIUDADA_PUNT, PUNT_GLOBAL (SBPro)
- Variables clave: ESTU_GENERO, ESTU_PRGM_ACADEMICO, INST_ORIGEN, ESTU_DEPTO_RESIDE, FAMI_ESTRATOVIVIENDA, PUNT_GLOBAL (SB11)
- Alcance adicional: minimo 8 visualizaciones en Fase 1

---

### Grupo 5 (3 personas) -- Universidad publica vs. privada: quien agrega mas valor?
**Reyes, Santamaria, Bermudez**

Pregunta central: Las IES oficiales agregan mas valor (diferencia SBPro - SB11 estandarizada) que las privadas, controlando por el perfil de entrada del estudiante?

- Variables Y: PUNT_GLOBAL (SBPro) y la variable construida Delta = SBPro_z - SB11_z
- Variables clave: INST_ORIGEN, INST_CARACTER_ACADEMICO, PUNT_GLOBAL (SB11), FAMI_ESTRATOVIVIENDA

---

### Grupo 6 (5 personas, alcance ambicioso) -- Educacion de los padres y movilidad: el capital cultural es destino?
**Duque, Flechas, Medrano, Salcedo, Amaya**

Pregunta central: Los hijos de padres sin educacion superior que logran llegar a la universidad obtienen resultados comparables en Saber Pro? O el capital cultural familiar sigue determinando el resultado final?

- Condicionar por cuartil de Saber 11: dentro de cada cuartil, los hijos de padres sin educacion superior rinden igual?
- La educacion de la madre pesa mas que la del padre?
- El efecto del capital cultural es mayor en ingles (exposicion cultural) que en razonamiento cuantitativo?
- Heterogeneidad regional: el capital cultural importa mas en la periferia?
- Para carreras de economia/administracion: los estudiantes primera generacion universitaria logran cerrar la brecha?
- Variables Y: PUNT_GLOBAL (SBPro), MOD_INGLES_PUNT, MOD_RAZONA_CUANTITAT_PUNT, MOD_LECTURA_CRITICA_PUNT
- Variables clave: FAMI_EDUCACIONMADRE, FAMI_EDUCACIONPADRE, FAMI_ESTRATOVIVIENDA, ESTU_DEPTO_RESIDE, ESTU_PRGM_ACADEMICO, PUNT_GLOBAL (SB11)
- Alcance adicional: minimo 8 visualizaciones en Fase 1

---

### Grupo 7 (3 personas) -- Centro vs. periferia: la universidad cierra la brecha geografica?
**Maez, Luzz, Silva**

Pregunta central: Estudiantes de departamentos perifericos (Choco, Guainia, Vaupes, Amazonas) que llegan a la universidad cierran la brecha con Bogota/Antioquia en Saber Pro, o la distancia se mantiene?

- Variables Y: PUNT_GLOBAL (SBPro) y la variable construida Delta = SBPro_z - SB11_z
- Variables clave: ESTU_DEPTO_RESIDE, COLE_DEPTO_UBICACION, PUNT_GLOBAL (SB11), INST_ORIGEN, FAMI_ESTRATOVIVIENDA

---

## Logistica

- **Tiempo por grupo:** 3 minutos de presentacion + 2 minutos de preguntas = 5 minutos por grupo.
- **Tiempo total estimado:** 35 minutos para los 7 grupos.
- **Orden de presentacion:** se definira al inicio de la clase.
- **Todos los integrantes del grupo deben estar presentes.** Si un integrante falta sin justificacion, su nota individual de presentacion es 1.0.
- **El cronometro es estricto.** A los 3 minutos se corta la presentacion. Practiquen antes.

---

## Resumen

No se trata de mostrar que saben usar R. Se trata de mostrar que entienden que dicen los datos sobre Colombia. Los datos de Saber 11 y Saber Pro cuentan historias sobre desigualdad, sobre acceso, sobre que significa nacer en un lugar y no en otro. Su trabajo es contar esa historia con evidencia.

Los demas grupos no son companeros pasivos. Son los tomadores de decision que necesitan entender sus hallazgos para actuar. Haganles preguntas como si las decisiones dependieran de sus respuestas, porque en el mundo real, asi es.
