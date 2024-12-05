#!/bin/bash

CACHE="/home/zchenhj/workspace/vBao/bao_server/bao.db"
if [ -f "$CACHE" ]; then
    rm "$CACHE"
    echo "$CACHE is removeds"
else
    echo "$CACHE does not exist."
fi

data="/home/zchenhj/workspace/vBao/queries/vec_job_queries/*.sql"
results_dir="/home/zchenhj/workspace/vBao/vec_imdb_refined_costmodel2"
mkdir -p "$results_dir"

python /home/zchenhj/workspace/vBao/run_queries.py $data | tee "$results_dir/bao_run.txt"


CACHE="/home/zchenhj/workspace/vBao/bao_server/bao.db"
if [ -f "$CACHE" ]; then
    rm "$CACHE"
    echo "$CACHE is removeds"
else
    echo "$CACHE does not exist."
fi

python /home/zchenhj/workspace/vBao/run_queries_pg.py $data | tee "$results_dir/pg_run.txt"




CACHE="/home/zchenhj/workspace/vBao/bao_server/bao.db"
if [ -f "$CACHE" ]; then
    rm "$CACHE"
    echo "$CACHE is removeds"
else
    echo "$CACHE does not exist."
fi

data="/home/zchenhj/workspace/vBao/queries/vec_job_queries/*.sql"
results_dir="/home/zchenhj/workspace/vBao/vec_imdb_refined_costmodel3"
mkdir -p "$results_dir"


python /home/zchenhj/workspace/vBao/run_queries_pg.py $data | tee "$results_dir/pg_run.txt"


CACHE="/home/zchenhj/workspace/vBao/bao_server/bao.db"
if [ -f "$CACHE" ]; then
    rm "$CACHE"
    echo "$CACHE is removeds"
else
    echo "$CACHE does not exist."
fi

python /home/zchenhj/workspace/vBao/run_queries.py $data | tee "$results_dir/bao_run.txt"