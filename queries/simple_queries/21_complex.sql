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
    ei.Document AS Doc,
    COUNT(DISTINCT ei.Date) AS DistinctDates,
    COUNT(DISTINCT ei2.id) AS NeighborCount
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
JOIN embedding_info ei2 ON ei.Document = ei2.Document
WHERE ei.Concept = 1 AND ei.Industry = 0
GROUP BY ei.Document
ORDER BY NeighborCount DESC, DistinctDates DESC;