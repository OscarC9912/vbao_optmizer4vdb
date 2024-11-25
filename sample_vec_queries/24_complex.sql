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
    ei.Position,
    COUNT(ei.id) AS NeighborCount,
    AVG(CAST(ei.Time AS FLOAT)) AS AvgTime,
    SUM(CASE WHEN ei.Service = 1 THEN 1 ELSE 0 END) AS ServiceCount
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
WHERE ei.Industry = 0 AND ei.Concept = 0 AND ei."Legal Document" = 0
GROUP BY ei.Position
ORDER BY NeighborCount DESC, AvgTime ASC;