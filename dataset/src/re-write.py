import csv

def remove_leading_comma_from_csv(file_path):
    print(f"Removing leading comma from {file_path}...")
    # Read the file and modify the header row
    with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
        rows = list(csv.reader(csvfile))
    
    # Remove leading comma in the first row (header)
    if rows and rows[0][0] == '':
        rows[0] = rows[0][1:]
    
    # Write the modified data back to the same file
    with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(rows)

# Example usage
# file_path = "/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv/aka_title.csv"  # Replace with your file path
# remove_leading_comma_from_csv(file_path)

file_path = "/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv/char_name.csv"  # Replace with your file path
remove_leading_comma_from_csv(file_path)

file_path = "/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv/company_name.csv"  # Replace with your file path
remove_leading_comma_from_csv(file_path)

file_path = "/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv/keyword.csv"  # Replace with your file path
remove_leading_comma_from_csv(file_path)

file_path = "/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv/title.csv"  # Replace with your file path
remove_leading_comma_from_csv(file_path)

file_path = "/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv/person_info.csv"  # Replace with your file path
remove_leading_comma_from_csv(file_path)