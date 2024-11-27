#!/bin/bash

data="/home/zchenhj/workspace/vBao/sample_queries/*.sql"
results_dir="/home/zchenhj/workspace/vBao/imdb_result"
mkdir -p "$results_dir"

python /home/zchenhj/workspace/vBao/run_queries.py $data | tee "$results_dir/bao_run.txt"
python /home/zchenhj/workspace/vBao/run_queries_pg.py $data | tee "$results_dir/pg_run.txt"