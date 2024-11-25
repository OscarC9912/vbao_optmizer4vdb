SELECT count(id)
FROM vector_k_nearest_neighbor(
    (SELECT embedding 
     FROM embedding_info 
     ORDER BY id LIMIT 1),
    'embedding_info',
    'embedding',
    128
);