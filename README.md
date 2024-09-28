# 📊 DIPLOMADO DE POWER BI - CAES ACADEMY

¡Bienvenidos al repositorio oficial del **Diplomado de Power BI - CAES**! 🎉 

Este espacio ha sido diseñado para proporcionar todos los recursos necesarios que te ayudarán a dominar Power BI, desde los conceptos fundamentales hasta las técnicas más avanzadas. Ya sea que seas un principiante o un analista de datos experimentado, encontrarás valor en cada sección de este curso.

## 📋 Tabla de Contenidos

- [Descripción del Diplomado](#-descripción-del-diplomado)
- [Contenido del Repositorio](#-contenido-del-repositorio)
- [Instrucciones de Uso](#-instrucciones-de-uso)
- [Requisitos Previos](#️-requisitos-previos)
- [Estructura del Curso](#-estructura-del-curso)
- [Recursos Adicionales](#-recursos-adicionales)
- [Cómo Contribuir](#-cómo-contribuir)
- [Soporte y Contacto](#-soporte-y-contacto)
- [Licencia](#-licencia)

## 🎓 Descripción del Diplomado

El Diplomado de Power BI - CAES es un programa completo diseñado para capacitar a profesionales en el uso efectivo de Microsoft Power BI para el análisis de datos y la creación de informes interactivos. A lo largo del curso, los participantes adquirirán habilidades prácticas en:

- Importación y transformación de datos
- Modelado de datos y relaciones
- Creación de medidas y columnas calculadas con DAX
- Diseño de visualizaciones impactantes
- Publicación y compartición de informes
- Implementación de buenas prácticas en BI

## 📂 Contenido del Repositorio

Este repositorio está organizado en las siguientes carpetas principales:

1. **📚 Manuales y Guías de Estudio**: 
   - Documentos PDF con teoría y conceptos clave
   - Presentaciones PowerPoint para cada módulo
   - Glosario de términos de Power BI

2. **📊 Archivos de Ejemplo**: 
   - Conjuntos de datos en diversos formatos (.csv, .xlsx, .json)
   - Proyectos de Power BI (.pbix) para demostraciones
   - Bases de datos de muestra

3. **📝 Ejercicios y Tareas**: 
   - Hojas de trabajo para práctica individual
   - Proyectos guiados paso a paso
   - Desafíos de análisis de datos

4. **🎥 Material Complementario**: 
   - Enlaces a tutoriales en video
   - Artículos y blogs recomendados
   - Recursos de la comunidad Power BI

5. **📑 Evaluaciones**: 
   - Cuestionarios de autoevaluación
   - Rúbricas para proyectos finales
   - Guías para presentaciones de casos de estudio

## 📌 Instrucciones de Uso

1. **Clona el repositorio** en tu máquina local:
   ```bash
   git clone https://github.com/CAES-ORG/DIPLOMADO-DE-POWER-BI-CAES.git
   ```

2. **Navega por las carpetas** según el módulo o tema que estés estudiando.

3. **Descarga los archivos necesarios** para cada lección o ejercicio.

4. **Sigue las instrucciones detalladas** en los archivos README.md dentro de cada carpeta de módulo.

5. **Completa los ejercicios y proyectos**, utilizando los recursos proporcionados.

6. **Participa en los foros de discusión** para aclarar dudas y compartir ideas con tus compañeros.

## 🛠️ Requisitos Previos

Para aprovechar al máximo este diplomado, asegúrate de contar con:

- **Power BI Desktop** instalado en tu computadora. [Descárgalo aquí](https://powerbi.microsoft.com/desktop/)
- Conocimientos básicos de Excel y manejo de datos
- Familiaridad con conceptos de análisis de negocios
- Una cuenta de Microsoft para acceder a Power BI Service
- (Opcional) Visual Studio Code para edición de scripts avanzados

## 📚 Estructura del Curso

El diplomado está dividido en los siguientes módulos:

1. **Introducción a Power BI y Fundamentos de Análisis de Datos**
2. **Importación y Transformación de Datos con Power Query**
3. **Modelado de Datos y Relaciones**
4. **Fundamentos de DAX (Data Analysis Expressions)**
5. **Creación de Visualizaciones Efectivas**
6. **Diseño de Dashboards Interactivos**
7. **Power BI Service y Colaboración**
8. **Seguridad y Administración en Power BI**
9. **Integración con Otras Herramientas de Microsoft**
10. **Proyecto Final y Mejores Prácticas**

Cada módulo incluye teoría, demostraciones, ejercicios prácticos y un mini-proyecto para reforzar el aprendizaje.

# 📊 KPIs e Insights para Tabla Pedidos ETL 📈

📉 Este documento proporciona una lista de KPIs (Indicadores Clave de Rendimiento), insights y métricas en DAX (Data Analysis Expressions) para evaluar el rendimiento de ventas, el comportamiento del cliente y otros aspectos importantes utilizando la tabla Pedidos ETL en Power BI. 📊

## 🔑 KPIs 🔑

1. **Total de Ventas**
   ```
   Total_Ventas = SUM('Pedidos ETL'[Monto])
   ```

2. **Número de Pedidos**
   ```
   Numero_Pedidos = COUNT('Pedidos ETL'[ID_PEDIDO])
   ```

3. **Venta Promedio por Pedido**
   ```
   Venta_Promedio_por_Pedido = DIVIDE([Total_Ventas], [Numero_Pedidos], 0)
   ```

4. **Ventas por Vendedor**
   ```
   Ventas_por_Vendedor = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[VENDEDOR]))
   ```

5. **Número de Clientes Únicos**
   ```
   Numero_Clientes_Uni = DISTINCTCOUNT('Pedidos ETL'[CLIENTE])
   ```

6. **Promedio de Venta por Cliente**
   ```
   Promedio_Venta_por_Cliente = DIVIDE([Total_Ventas], [Numero_Clientes_Uni], 0)
   ```

7. **Ventas por Ciudad**
   ```
   Ventas_por_Ciudad = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[CIUDAD]))
   ```

## 💡 Insights y Métricas 💡

1. **Ventas Mensuales**
   ```
   Ventas_Mensuales = CALCULATE([Total_Ventas], MONTH('Pedidos ETL'[FECHA_HORA]) = MONTH(TODAY()))
   ```

2. **Ventas Anuales**
   ```
   Ventas_Anuales = CALCULATE([Total_Ventas], YEAR('Pedidos ETL'[FECHA_HORA]) = YEAR(TODAY()))
   ```

3. **Ventas por Tipo de Compra**
   ```
   Ventas_por_Tipo_Compra = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[TIPO_COMPRA]))
   ```

4. **Ventas por Condición de Pago**
   ```
   Ventas_por_Condicion_Pago = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[CONDICION PAGO]))
   ```

5. **Top Productos por Ventas**
   ```
   Top_Productos_Ventas = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[Producto]))
   ```

6. **Top Vendedores por Ventas**
   ```
   Top_Vendedores_Ventas = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[VENDEDOR]))
   ```

7. **Promedio de Precio por Producto**
   ```
   Promedio_Precio_por_Producto = AVERAGE('Pedidos ETL'[Precio])
   ```

8. **Total de Cantidad Vendida**
   ```
   Total_Cantidad_Vendida = SUM('Pedidos ETL'[Cantidad])
   ```

9. **Venta Total por Categoría**
   ```
   Venta_Total_por_Categoria = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[Categoría]))
   ```

10. **Ventas por Condición de Pago**
    ```
    Ventas_por_Condicion_Pago = CALCULATE([Total_Ventas], ALLEXCEPT('Pedidos ETL', 'Pedidos ETL'[CONDICION PAGO]))
    ```

## 📝 Notas Adicionales 📝

- 🔍 **Filtrado y Segmentación**: Puedes aplicar filtros adicionales según el periodo de tiempo, ciudad, vendedor, etc., para obtener insights más específicos. 🔎

- 📊 **Visualizaciones**: Utiliza gráficos de líneas para ventas mensuales, gráficos de barras para ventas por vendedor o ciudad, y tablas para mostrar productos o vendedores con mayor rendimiento. 📈

🚀 Estos KPIs e insights te ayudarán a realizar un análisis detallado de tus datos de pedidos y a tomar decisiones informadas basadas en el rendimiento de ventas. 💼


## 🌟 Recursos Adicionales
- [Videos del Profesor de Power BI](https://www.youtube.com/watch?v=Xg7LF4TpY-c&feature=youtu.be)
- [Documentación Oficial de Power BI](https://docs.microsoft.com/power-bi/)
- [Foro de la Comunidad Power BI](https://community.powerbi.com/)
- [Canal de YouTube de Guy in a Cube](https://www.youtube.com/channel/UCFp1vaKzpfvoGai0vE5VJ0w)
- [Blog de SQLBI](https://www.sqlbi.com/articles/)
- [Power BI Cheat Sheet](https://github.com/CAES-ORG/DIPLOMADO-DE-POWER-BI-CAES/blob/main/Recursos/PowerBI_CheatSheet.pdf)

## 📝 Cómo Contribuir

Valoramos y alentamos las contribuciones de nuestra comunidad de estudiantes y profesionales. Si deseas contribuir:

1. Haz un Fork del repositorio
2. Crea una nueva rama (`git checkout -b feature/AmazingFeature`)
3. Realiza tus cambios y haz commit (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

También puedes contribuir reportando errores, sugiriendo mejoras o compartiendo tus propios proyectos y casos de estudio.

## 📞 Soporte y Contacto

Si tienes preguntas, sugerencias o necesitas ayuda:

- Abre un Issue en este repositorio
- Envía un correo a soporte@caes-powerbi.com
- Únete a nuestro canal de Slack: [CAES Power BI Community](https://caes-powerbi.slack.com)

Horario de atención: Lunes a Viernes, 9:00 AM - 6:00 PM (Hora Central)

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE.md](LICENSE.md) para más detalles.

---

¡Esperamos que disfrutes el Diplomado de Power BI - CAES y que este repositorio sea una valiosa herramienta en tu viaje de aprendizaje! 🚀📊
