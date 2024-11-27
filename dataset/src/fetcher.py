# fetch all tables and data from the database into csv files
import psycopg2
import os

db_settings = {
    "dbname": "imdb", "user": "zchenhj",
    "password": "chen181412", "host": "localhost",
    "port": "5434"
}

output_dir = "/home/zchenhj/workspace/vBao/dataset/imdb_csv"


def _fetch_table_names():
    conn = psycopg2.connect(**db_settings)
    
    cursor = conn.cursor()
    cursor.execute("""
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
    """)
    tables = cursor.fetchall()
    cursor.close()
    
    output = [table[0] for table in tables]
    output.sort()
    return output


def table_to_csv():
    
    table_name = _fetch_table_names()
    
    for table in table_name:
        
        conn = psycopg2.connect(**db_settings)
        cursor = conn.cursor()
        
        curr_csv_path = os.path.join(output_dir, f"{table}.csv")
        with open(curr_csv_path, 'w') as f:
            cursor.copy_expert(f"COPY {table} TO STDOUT WITH CSV HEADER", f)
        
        print(f"Exported {table} to {curr_csv_path}")
        
        
if __name__ == "__main__":
    table_to_csv()