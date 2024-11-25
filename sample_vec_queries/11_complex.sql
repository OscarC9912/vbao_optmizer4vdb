WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info
            ORDER BY id 
            LIMIT 1
        ),
        'embedding_info',
        'embedding',
        10
    )
)
SELECT 
    tn.id,
    (SELECT embedding FROM embedding_info ORDER BY id LIMIT 1)::vector <-> ei.embedding::vector AS distance,
    ei.Document,
    ei.Product,
    ei.Country,
    ei.Service,
    ei.Person
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
WHERE ei.id > 100 AND ei.Document=1 AND ei.Product=1 AND ei.Country=1 AND ei.Service=1 AND ei.Person=1
ORDER BY distance;