WITH top_neighbors AS (
    SELECT * 
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 100
        ),
        'embedding_info',
        'embedding',
        100
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
JOIN embedding_info ei2 ON ei.Document = ei2.Document
WHERE ei2.Product=1 AND ei2.Website=0 AND ei2.Project=1;