import csv

# Specify the path to your CSV file
csv_file_path = '/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv/aka_title.csv'

# Open and read the first two lines of the CSV file
with open(csv_file_path, mode='r') as file:
    reader = csv.reader(file)
    first_two_lines = [next(reader) for _ in range(5)]

# Print the first two lines
for line in first_two_lines:
    print(line)
    print('\n')