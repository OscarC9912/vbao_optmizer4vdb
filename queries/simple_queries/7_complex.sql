WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 301
        ),
        'embedding_info',
        'embedding',
        40
    )
)
SELECT tn.id
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
WHERE Object=0 AND "Legal Document"=1 AND Location=0
ORDER BY tn.id;