data="/home/zchenhj/workspace/BaoForPostgreSQL/sample_vec_queries/*.sql"
python /home/zchenhj/workspace/BaoForPostgreSQL/run_queries.py $data | tee /home/zchenhj/workspace/BaoForPostgreSQL/results/arm5_500data_50/bao_run.txt
python /home/zchenhj/workspace/BaoForPostgreSQL/run_queries_pg.py $data | tee /home/zchenhj/workspace/BaoForPostgreSQL/results/arm5_500data_50/pg_run.txt