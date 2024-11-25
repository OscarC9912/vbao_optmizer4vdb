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
),
document_aggregates AS (
    SELECT 
        ei.Document,
        COUNT(ei.id) AS TotalCount,
        AVG(CAST(ei.Date AS FLOAT)) AS AvgDate
    FROM embedding_info ei
    WHERE ei.Industry = 1 AND ei.Policy = 1
    GROUP BY ei.Document
)
SELECT 
    tn.id AS NeighborID,
    da.Document,
    da.TotalCount,
    da.AvgDate,
    COUNT(ei2.id) AS MatchingNeighbors,
    SUM(CASE WHEN ei2.Disease = 1 THEN 1 ELSE 0 END) AS DiseaseMatches
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
JOIN document_aggregates da ON ei.Document = da.Document
JOIN embedding_info ei2 ON da.Document = ei2.Document
GROUP BY tn.id, da.Document, da.TotalCount, da.AvgDate
ORDER BY MatchingNeighbors DESC, TotalCount DESC;