WITH top_neighbors AS (
    SELECT DISTINCT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1
        ),
        'embedding_info',
        'embedding',
        120
    )
)
SELECT 
    count(tn.id),
    count(ei.Document),
    count(ei.Product)
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
WHERE ei.Document=1 AND ei.Position=1 AND Facility=0
GROUP BY tn.id, ei.Document, ei.Product;