# merge the vectorized embedding with the original csv dataset
# keep the original dataset if not modified

import os
import pandas as pd
import numpy as np
import shutil

# mapping of table and column
vectorized_tables = {'title': 'title',
                     'person_info': 'info'}

original_csv = '/home/zchenhj/workspace/vBao/dataset/imdb_csv'
vector_data_path = '/home/zchenhj/workspace/vBao/dataset/imdb_embedding_data'
output_path = '/home/zchenhj/workspace/vBao/dataset/vectorized_imdb_csv'


def main():
    
    for table in vectorized_tables:
        
        csv_path = os.path.join(original_csv, table + '.csv')
        csv_data = pd.read_csv(csv_path, low_memory=False)
        
        file_name = f"{table}-{vectorized_tables[table]}.npy"
        embedding_path = os.path.join(vector_data_path, file_name)
        embedding = np.load(embedding_path).tolist()
        
        assert type(embedding) == list
        assert len(csv_data) == len(embedding)
        
        vec_column_name = f"vec_{vectorized_tables[table]}"
        
        csv_data[vec_column_name] = embedding
        
        if not os.path.exists(output_path):
            os.makedirs(output_path)
    
        updated_csv_path = os.path.join(output_path, f"{table}.csv")
        print(f"Table: {table} | New Column: {vec_column_name} | Updated CSV: {updated_csv_path}")
        csv_data.to_csv(updated_csv_path, index=False)
        print("Write Success!")
        
    
    # for file in os.listdir(original_csv):
    #     if file.split('.')[0] not in vectorized_tables:
    #         shutil.copy(os.path.join(original_csv, file), output_path)
    #         print(f"Table: {file} | No vectorized column | Copying to output path")
        

if __name__ == '__main__':
    main()
    
            
        
        
            