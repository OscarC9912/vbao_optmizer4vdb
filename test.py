import psycopg2
import os
import subprocess
import sys
import random
from time import time, sleep
import json
import re
import socket
from ast import literal_eval

q = """SELECT COUNT(*)
FROM title as t,
movie_info as mi1,
kind_type as kt,
info_type as it1,
info_type as it3,
info_type as it4,
movie_info_idx as mii1,
movie_info_idx as mii2,
movie_keyword as mk,
keyword as k,
aka_name as an,
name as n,
info_type as it5,
person_info as pi1,
cast_info as ci,
role_type as rt
WHERE
t.id = mi1.movie_id
AND t.id = ci.movie_id
AND t.id = mii1.movie_id
AND t.id = mii2.movie_id
AND t.id = mk.movie_id
AND mk.keyword_id = k.id
AND mi1.info_type_id = it1.id
AND mii1.info_type_id = it3.id
AND mii2.info_type_id = it4.id
AND t.kind_id = kt.id
AND (kt.kind IN ('tv movie','video movie'))
AND (t.production_year <= 2015)
AND (t.production_year >= 1975)
AND (mi1.info IN ('Biography','Fantasy','OFM:35 mm','OFM:Video','Romance','Sci-Fi','Sport','Thriller'))
AND (it1.id IN ('3','7'))
AND it3.id = '100'
AND it4.id = '101'
AND (mii2.info ~ '^(?:[1-9]\d*|0)?(?:\.\d+)?$' AND mii2.info::float <= 7.0)
AND (mii2.info ~ '^(?:[1-9]\d*|0)?(?:\.\d+)?$' AND 3.0 <= mii2.info::float)
AND (mii1.info ~ '^(?:[1-9]\d*|0)?(?:\.\d+)?$' AND 5000.0 <= mii1.info::float)
AND (mii1.info ~ '^(?:[1-9]\d*|0)?(?:\.\d+)?$' AND mii1.info::float <= 500000.0)
AND n.id = ci.person_id
AND ci.person_id = pi1.person_id
AND it5.id = pi1.info_type_id
AND n.id = pi1.person_id
AND n.id = an.person_id
AND rt.id = ci.role_id
AND (n.gender in ('f') OR n.gender IS NULL)
AND (n.name_pcode_nf in ('C6235') OR n.name_pcode_nf IS NULL)
AND (ci.note in ('(archive footage)') OR ci.note IS NULL)
AND (rt.role in ('actress'))
AND (it5.id in ('34'))
"""

USE_BAO = True
PG_CONNECTION_STR = "dbname=imdb user=zchenhj host=localhost port=5434 password=chen181412"

def query_encode_extraction(query, cache_file="/home/zchenhj/workspace/vBao/tmp/temp_cache.json"):
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


if __name__ == '__main__':
    # query_encode_extraction(q)
    q_time = run_query(q, bao_reward=USE_BAO, bao_select=USE_BAO)