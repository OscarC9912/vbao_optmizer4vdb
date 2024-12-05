import os
import json
import psycopg2
from tqdm import tqdm
from time import time, sleep

PG_CONNECTION_STR = "dbname=imdb user=zchenhj host=localhost port=5434 password=chen181412"


def hint_generate():
    hint0 = """SET enable_hashjoin = on;
                SET enable_indexscan = on;
                SET enable_mergejoin = on;
                SET enable_nestloop = on;
                SET enable_seqscan = on;
                SET enable_indexonlyscan = on;"""
                        
                        
    hint1 = """SET enable_hashjoin = on;
            SET enable_indexscan = on;
            SET enable_mergejoin = on;
            SET enable_nestloop = off;
            SET enable_seqscan = on;
            SET enable_indexonlyscan = on;"""
                
                
    hint2 = """SET enable_hashjoin = on;
            SET enable_indexscan = off;
            SET enable_mergejoin = off;
            SET enable_nestloop = on;
            SET enable_seqscan = on;
            SET enable_indexonlyscan = on;"""                
            
            
    hint3 = """SET enable_hashjoin = on;
            SET enable_indexscan = off;
            SET enable_mergejoin = off;
            SET enable_nestloop = off;
            SET enable_seqscan = on;
            SET enable_indexonlyscan = on;"""
            
                    
    hint4 = """SET enable_hashjoin = on;
            SET enable_indexscan = on;
            SET enable_mergejoin = off;
            SET enable_nestloop = on;
            SET enable_seqscan = on;
            SET enable_indexonlyscan = on;"""
                    
                    
    reset = """SET enable_hashjoin = off;
            SET enable_indexscan = off;
            SET enable_mergejoin = off;
            SET enable_nestloop = off;
            SET enable_seqscan = off;
            SET enable_indexonlyscan = off;"""
            
    return [hint0, hint1, hint2, hint3, hint4], reset


def run_query(sql, reset_cmd, hint_cmd):
    
    conn = psycopg2.connect(PG_CONNECTION_STR)
    cur = conn.cursor()
    
    cur.execute(reset_cmd)
    cur.execute(hint_cmd)
    
    start = time()
    cur.execute(sql)
    stop = time()
    
    conn.close()
    
    return stop - start


def run_all_hints(query_path):
    def _read_sql_file(query_path):
        with open(query_path, 'r') as file:
            sql_query = file.read()
        return sql_query
    
    query = _read_sql_file(query_path)
    all_hints, reset = hint_generate()
    
    times = []
    for i, hint in enumerate(all_hints):
        curr_time = run_query(query, reset, hint)
        temp = (f"Hint: {i} | {str(format(curr_time, '.3f'))}")
        times.append(temp)
        
    print(f"Query: {query_path} | Times: {times}")
    
    return times
    
    

def main(queries_dir, output_dir):
    files = os.listdir(queries_dir)
    all_data = dict()
    for file in files:
        path = os.path.join(queries_dir, file)
        curr_rt = run_all_hints(path)
        all_data[file] = curr_rt
        
    with open(output_dir, 'w') as fdata:
        json.dump(all_data, fdata, indent=4)
    
        
if __name__ == '__main__':
    
    queries = '/home/zchenhj/workspace/vBao/queries/sample_queries'
    output_dir = '/home/zchenhj/workspace/vBao/statistics/benchmark_imdb.json'
    main(queries, output_dir)
        
        
    