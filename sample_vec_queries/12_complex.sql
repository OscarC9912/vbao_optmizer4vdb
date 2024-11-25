WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 19
        ),
        'embedding_info',
        'embedding',
        4
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
JOIN embedding_info ei2 ON ei.Document = ei2.Document
ORDER BY tn.id;