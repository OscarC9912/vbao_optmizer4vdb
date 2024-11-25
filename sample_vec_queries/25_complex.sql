WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 36321
        ),
        'embedding_info',
        'embedding',
        784
    )
)
SELECT 
    ei.System,
    ei.Facility,
    COUNT(DISTINCT ei.id) AS TotalNeighbors,
    COUNT(DISTINCT ei2.Product) AS UniqueProducts
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
JOIN embedding_info ei2 ON ei.System = ei2.System
WHERE ei.Infrastructure = 1 AND ei.Facility = 1
GROUP BY ei.System, ei.Facility
ORDER BY TotalNeighbors DESC, UniqueProducts DESC;