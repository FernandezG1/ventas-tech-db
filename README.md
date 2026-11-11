# 📊 Pre-entrega 6: Transformación y Modelado ETL en Power Query

## 📋 Descripción del Proyecto
Este proyecto simula la ingesta, limpieza y preparación de un reporte de ventas desorganizado (`VENTAS_EXPORT`) utilizando un flujo **ETL (Extract, Transform, Load)** en Power Query dentro de Power BI Desktop[cite: 2].

---

## 🛠️ Pasos Aplicados en Power Query
A continuación se evidencia el flujo registrado en el panel de **Pasos aplicados** de Power Query, cumpliendo con los estándares de calidad de datos[cite: 2]:

![Pasos Aplicados en Power Query](Pasos%20Aplicados.png)

1. **Origen y Navegación:** Conexión inicial al archivo de origen en Excel y selección de la tabla de ventas[cite: 2].
2. **Promoción de Encabezados:** Asignación correcta de la primera fila como nombres de columnas[cite: 2].
3. **Tipado de Datos:** Ajuste de formatos (textos, fechas, enteros y decimales) para garantizar la correcta lectura de los campos[cite: 2].
4. **Renombrado y Selección:** Estandarización de nombres de columnas utilizando la nomenclatura `snake_case` y filtrado de columnas clave[cite: 2].
5. **Limpieza de Datos:** 
   - Eliminación de registros duplicados[cite: 2].
   - Supresión de filas en blanco o nulas[cite: 2].
   - Reemplazo de valores en campos específicos para normalizar estados[cite: 2].

---

## 💡 Justificación Técnica y Modelado
- **Integridad del Modelo:** La correcta aplicación de estos pasos permitió dejar preparadas las tablas para la separación en el modelo de estrella (`Dim_Clientes` y `Fact_Ventas`), evitando redundancias y optimizando el rendimiento de las futuras medidas DAX.
