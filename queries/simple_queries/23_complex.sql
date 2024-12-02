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
    ei.Date,
    ei.Country,
    COUNT(ei2.id) AS MatchingDocsCount,
    SUM(CASE WHEN ei2.Policy = 1 THEN 1 ELSE 0 END) AS PolicyMatches
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
JOIN embedding_info ei2 ON ei.Document = ei2.Document
WHERE ei.Concept = 1 AND ei.Industry = 1
GROUP BY ei.Document, ei.Date, ei.Country
ORDER BY MatchingDocsCount DESC, PolicyMatches DESC;