WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 42
        ),
        'embedding_info',
        'embedding',
        784
    )
)
SELECT 
    ei.Country,
    COUNT(ei.id) AS TotalNeighbors,
    SUM(CASE WHEN ei.Infrastructure = 1 THEN 1 ELSE 0 END) AS InfrastructureCount,
    AVG(CAST(ei.Date AS FLOAT)) AS AvgDate
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
GROUP BY ei.Country
ORDER BY TotalNeighbors DESC, InfrastructureCount DESC;