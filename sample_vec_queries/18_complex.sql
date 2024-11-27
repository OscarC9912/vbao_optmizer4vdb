WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 34451
        ),
        'embedding_info',
        'embedding',
        53
    )
)
SELECT tn.id
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
JOIN embedding_info ei2 ON ei.Document = ei2.Document
ORDER BY tn.id;