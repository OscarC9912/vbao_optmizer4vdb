import psycopg2
import os
import subprocess
import sys
import random
from time import time, sleep
import json
import re
import socket

USE_BAO = True
PG_CONNECTION_STR = "dbname=hk_data user=zchenhj host=localhost port=5434 password=chen181412"

# https://stackoverflow.com/questions/312443/
def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


def run_query(sql, bao_select=False, bao_reward=False):
    start = time()
    while True:
        try:
            conn = psycopg2.connect(PG_CONNECTION_STR)
            cur = conn.cursor()
            cur.execute(f"SET enable_bao TO {bao_select or bao_reward}")
            cur.execute(f"SET enable_bao_selection TO {bao_select}")
            cur.execute(f"SET enable_bao_rewards TO {bao_reward}")
            cur.execute("SET bao_num_arms TO 5")
            cur.execute("SET statement_timeout TO 300000")
            cur.execute(q)
            cur.fetchall()
            conn.close()
            break
        except:
            sleep(1)
            continue
    stop = time()
    return stop - start



def query_encode_extraction(query, cache_file="/home/zchenhj/workspace/BaoForPostgreSQL/tmp/temp_cache.json"):
    output = dict()
    if "vector_k_nearest_neighbor" in query:
        pattern = r"vector_k_nearest_neighbor\(\s*\(\s*SELECT.*?\),.*?,.*?,\s*(\d+)\s*\)"
        match = re.search(pattern, query, re.DOTALL)
        if match:
            topk = int(match.group(1))
            output['topk'] = f"{topk}"
        else:
            output['topk'] = "0"
    else:
        output['topk'] = "0"
        
    # Save output to a cache file
    if os.path.exists(cache_file):
        os.remove(cache_file)
        
    with open(cache_file, "w") as f:
        json.dump(output, f)

def query_info_transfer(data):
    server_address = ('localhost', 9381)
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.connect(server_address)
            sock.sendall(json.dumps(data).encode('utf-8') + b'\n')
    except Exception as e:
        print(f"Error communicating with server: {e}")
        

     
query_paths = sys.argv[1:]
queries = []
for fp in query_paths:
    with open(fp) as f:
        query = f.read()
    queries.append((fp, query))
print("Read", len(queries), "queries.")
print("Using Bao:", USE_BAO)

random.seed(42)
query_sequence = random.choices(queries, k=500)
pg_chunks, *bao_chunks = list(chunks(query_sequence, 50))

print("Executing queries using PG optimizer for initial training")

for fp, q in pg_chunks:
    query_encode_extraction(q)
    pg_time = run_query(q, bao_reward=True)
    print("x", "x", time(), fp, pg_time, "PG", flush=True)

for c_idx, chunk in enumerate(bao_chunks):
    if USE_BAO:
        result = subprocess.run(["python", "baoctl.py", "--retrain"], cwd="bao_server")
        result_sync = subprocess.run("sync", shell=True)
    for q_idx, (fp, q) in enumerate(chunk):
        query_encode_extraction(q)
        q_time = run_query(q, bao_reward=USE_BAO, bao_select=USE_BAO)
        print(c_idx, q_idx, time(), fp, q_time, flush=True)
