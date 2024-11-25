#!/bin/bash

echo "Stop the PostgreSQL service"
sudo pg_ctlcluster 12 main stop

cd /home/zchenhj/workspace/BaoForPostgreSQL/pg_extension
make clean
sudo make USE_PGXS=1 install

echo "Start the PostgreSQL service"
sudo pg_ctlcluster 12 main restart

echo "Remove the Cache file if it exists"
if [ -f /home/zchenhj/workspace/BaoForPostgreSQL/bao_server/bao.db ]; then
    rm /home/zchenhj/workspace/BaoForPostgreSQL/bao_server/bao.db
    echo "Cache file removed."
else
    echo "Cache file does not exist."
fi