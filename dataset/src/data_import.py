import os
import psycopg2
from tqdm import tqdm

# Database connection parameters
DB_PARAMS = {
    'dbname': 'vec_imdb_cust_cost',
    'user': 'zchenhj',
    'password': 'chen181412',
    'host': 'localhost',
    'port': 5434,
}

# Folder containing the CSV files
csv_folder = '/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv'

# Connect to the PostgreSQL database
conn = psycopg2.connect(**DB_PARAMS)
cursor = conn.cursor()

# Iterate through all CSV files in the folder
for file_name in tqdm(os.listdir(csv_folder)):
    if file_name.endswith('.csv'):
        table_name = file_name.split('.')[0]  # Extract table name from file name
        file_path = os.path.join(csv_folder, file_name)
        
        # Copy data from CSV into the corresponding table
        with open(file_path, 'r') as f:
            try:
                print(f"Importing {file_name} into table {table_name}...")
                cursor.copy_expert(
                    f"COPY {table_name} FROM STDIN WITH CSV HEADER DELIMITER ','",
                    f
                )
                conn.commit()
                print(f"Successfully imported {file_name}!")
            except Exception as e:
                conn.rollback()
                print(f"Error importing {file_name}: {e}")

# Close the database connection
cursor.close()
conn.close()