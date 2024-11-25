WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 1002
        ),
        'embedding_info',
        'embedding',
        17
    )
)
SELECT 
    tn.id, Activity AS AC, Facility AS FC, Government AS GVN
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
ORDER BY tn.id;