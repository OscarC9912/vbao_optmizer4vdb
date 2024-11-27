WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (SELECT embedding 
         FROM embedding_info 
         ORDER BY id LIMIT 1),
        'embedding_info',
        'embedding',
        20
    )
)
SELECT tn.id
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id;