import re

def extract_create_table_commands(sql_file_path, output_file_path):
    # Read the SQL file
    with open(sql_file_path, 'r') as file:
        sql_content = file.read()
        
    print("Stoped Reading ...")
    
    # Regex to match CREATE TABLE commands
    create_table_pattern = re.compile(
        r"(CREATE\s+TABLE.*?\(.*?\);)",  # Matches CREATE TABLE and its definition
        re.DOTALL | re.IGNORECASE       # DOTALL for multiline, IGNORECASE for case insensitivity
    )
    
    # Find all CREATE TABLE commands
    create_table_commands = create_table_pattern.findall(sql_content)
    
    # Write the extracted commands to an output file
    with open(output_file_path, 'w') as output_file:
        for command in create_table_commands:
            output_file.write(command + "\n\n")
    
    print(f"Extracted {len(create_table_commands)} CREATE TABLE commands to {output_file_path}")

# Example usage
sql_file_path = '/home/zchenhj/workspace/dataset/imdb.sql'
output_file_path = '/home/zchenhj/workspace/vBao/dataset/imdb_index/create_tables.sql'
extract_create_table_commands(sql_file_path, output_file_path)