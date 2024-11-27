# fetch all indexes from the database into sql file

import psycopg2
import os

db_settings = {
    "dbname": "imdb", "user": "zchenhj",
    "password": "chen181412", "host": "localhost",
    "port": "5434"
}

path_save_index = "/home/zchenhj/workspace/vBao/dataset/imdb_index/create_index_imdb.sql"

try:
    conn = psycopg2.connect(**db_settings)
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT
            tablename AS table_name,
            indexname AS index_name,
            indexdef AS index_definition
        FROM
            pg_indexes
        WHERE
            schemaname = 'public'; -- Replace 'public' with your schema if needed
    """)
    indexes = cursor.fetchall()
    
    with open(path_save_index, "w") as f:
        for table_name, index_name, index_def in indexes:
            f.write(f"-- Index name: {index_name} on table: {table_name}\n")
            f.write(f"{index_def};\n\n")
    
    print(f"Index creation commands saved to {path_save_index}")
    
except Exception as e:
    print(f"Error: {e}")
    
    