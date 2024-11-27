import psycopg2

db_settings = {
    "dbname": "imdb", "user": "zchenhj",
    "password": "chen181412", "host": "localhost",
    "port": "5434"
}

def extract_create_table_statements(database_config, output_file_path):
    try:
        # Connect to PostgreSQL
        connection = psycopg2.connect(
            dbname=database_config['dbname'],
            user=database_config['user'],
            password=database_config['password'],
            host=database_config['host'],
            port=database_config['port']
        )
        cursor = connection.cursor()

        # Query to get table creation scripts
        query = """
        SELECT table_name, 
               pg_get_tabledef(oid) AS create_statement
        FROM pg_tables 
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema');
        """
        
        cursor.execute(query)
        results = cursor.fetchall()
        
        # Write the CREATE TABLE statements to a file
        with open(output_file_path, 'w') as output_file:
            for table_name, create_statement in results:
                if create_statement:
                    output_file.write(f"-- Table: {table_name}\n")
                    output_file.write(create_statement + "\n\n")
        
        print(f"Extracted {len(results)} CREATE TABLE statements to {output_file_path}")
    
    except Exception as e:
        print("Error:", e)
    
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

# Example usage
database_config = {
    'dbname': 'your_database_name',
    'user': 'your_username',
    'password': 'your_password',
    'host': 'localhost',
    'port': 5432
}
output_file_path = 'extracted_create_tables.sql'
extract_create_table_statements(database_config, output_file_path)