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
    tn.id,
    ei.Document,
    ei.Product,
    ei.Country,
    ei.Service,
    ei.Person
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
WHERE ei.Document=1 AND ei.Position=1 AND Facility=0
ORDER BY ei.Document;