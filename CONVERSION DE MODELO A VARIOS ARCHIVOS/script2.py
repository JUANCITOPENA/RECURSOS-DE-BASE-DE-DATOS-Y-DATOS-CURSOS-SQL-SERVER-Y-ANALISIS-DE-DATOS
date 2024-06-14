import pandas as pd

# Ruta del archivo Excel original
input_file = 'MODELO DE NEGOCIO Y TABLAS.xlsx'

# Cargar todas las hojas del archivo Excel
excel_data = pd.read_excel(input_file, sheet_name=None)

# Guardar cada hoja en archivos separados
for sheet_name, data in excel_data.items():
    # Definir el nombre base para los archivos de salida
    base_name = sheet_name.replace(" ", "_")  # Reemplazar espacios por guiones bajos

    # Guardar como archivo Excel
    excel_output = f'{base_name}.xlsx'
    data.to_excel(excel_output, index=False)

    # Guardar como archivo CSV
    csv_output = f'{base_name}.csv'
    data.to_csv(csv_output, index=False)

    # Guardar como archivo JSON
    json_output = f'{base_name}.json'
    data.to_json(json_output, orient='records')  # Eliminar lines=True

    print(f'Se han guardado los archivos: {excel_output}, {csv_output}, {json_output}')
