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
        100
    )
)
SELECT 
    tn.id AS ID, ei.Policy AS Policy, ei.Regulation AS Reg,
    (SELECT embedding FROM embedding_info ORDER BY id LIMIT 1)::vector <-> ei.embedding::vector AS distance
FROM top_neighbors AS tn
JOIN embedding_info AS ei ON tn.id = ei.id
WHERE Organization=1 AND Industry=0 AND Country=1;