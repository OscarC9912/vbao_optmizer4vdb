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
position_date_filter AS (
    SELECT 
        ei.Position,
        MIN(ei.Date) AS EarliestDate
    FROM embedding_info ei
    WHERE ei.Position IS NOT NULL
    GROUP BY ei.Position
)
SELECT 
    tn.id AS NeighborID,
    ei2.Document,
    ei.Position,
    pd.EarliestDate,
    COUNT(ei3.id) AS MatchingDocsCount,
    SUM(CASE WHEN ei3.Regulation = 1 THEN 1 ELSE 0 END) AS RegulationMatches
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
JOIN position_date_filter pd ON ei.Position = pd.Position
JOIN embedding_info ei2 ON ei.Document = ei2.Document
JOIN embedding_info ei3 ON ei2.id = ei3.id
GROUP BY tn.id, ei2.Document, ei.Position, pd.EarliestDate
ORDER BY MatchingDocsCount DESC, RegulationMatches DESC;