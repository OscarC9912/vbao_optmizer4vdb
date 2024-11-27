# read all data from the csv file and embedding one of the column
# Finally, I will add this new vector into the csv file

import os
import numpy as np
import pandas as pd
from sentence_transformers import SentenceTransformer

ST_model='sentence-transformers/bert-base-nli-mean-tokens'
embedding_output_path = '/ssddata/zchenhj/bao_data/dataset/imdb_embedding_data/'

def csv_reader(file_path, column_name):
    print(f"Process Table: {file_path.split('/')[-1]} || Column: {column_name}")
    df = pd.read_csv(file_path)
    assert column_name in df.columns, f"Column: {column_name} Not Found"
    column_data = df[column_name]
    return list(column_data)

def load_model(model_name, device='cuda:7'):
    model = SentenceTransformer(model_name, device=device)
    return model

def gen_embedding(model: SentenceTransformer, data: list):
    
    embeddings = model.encode(data, 
        convert_to_numpy=True, 
        show_progress_bar=True, 
        batch_size=256
    )
    
    print(f"Embedding Shape: {embeddings.shape}")
    
    return embeddings



def main(file_path, column_name):
    
    column_data = csv_reader(file_path, column_name)
    
    model = load_model(ST_model)
    
    output_data = gen_embedding(model, column_data)
    
    assert len(column_data) == output_data.shape[0], "Data Length Not Match"
    
    if not os.path.exists(embedding_output_path):
        os.makedirs(embedding_output_path)
    
    file_name = f"{file_path.split('/')[-1].split('.')[0]}_{column_name}.npy"
    output_path = os.path.join(embedding_output_path, file_name)
    
    np.save(output_path, output_data)
    

if __name__ == "__main__":
    # file_path = '/ssddata/zchenhj/bao_data/dataset/imdb_csv/keyword.csv'
    # column_name = 'keyword'
    
    file_path = '/ssddata/zchenhj/bao_data/dataset/imdb_csv/title.csv'
    column_name = 'title'
    main(file_path, column_name)
    
    file_path = '/ssddata/zchenhj/bao_data/dataset/imdb_csv/aka_title.csv'
    column_name = 'title'
    main(file_path, column_name)
    
    file_path = '/ssddata/zchenhj/bao_data/dataset/imdb_csv/char_name.csv'
    column_name = 'name'
    main(file_path, column_name)
    
    file_path = '/ssddata/zchenhj/bao_data/dataset/imdb_csv/company_name.csv'
    column_name = 'name'
    main(file_path, column_name)
    
    file_path = '/ssddata/zchenhj/bao_data/dataset/imdb_csv/person_info.csv'
    column_name = 'info'
    main(file_path, column_name)
