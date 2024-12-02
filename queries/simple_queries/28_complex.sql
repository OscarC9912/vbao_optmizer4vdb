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
        60
    )
),
legal_document_analysis AS (
    SELECT 
        ei."Legal Document",
        COUNT(ei.id) AS TotalLegalDocs,
        MAX(CAST(ei.Date AS FLOAT)) AS LatestDate
    FROM embedding_info ei
    WHERE ei."Legal Document" = 1
    GROUP BY ei."Legal Document"
)
SELECT 
    tn.id AS NeighborID,
    lda."Legal Document",
    lda.TotalLegalDocs,
    lda.LatestDate,
    ei.Document,
    COUNT(ei2.id) AS DocumentMatches,
    SUM(CASE WHEN ei3.Industry = 1 THEN 1 ELSE 0 END) AS IndustryMatches
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
JOIN legal_document_analysis lda ON ei."Legal Document" = lda."Legal Document"
JOIN embedding_info ei2 ON ei.Document = ei2.Document
JOIN embedding_info ei3 ON ei.Country = ei3.Country
GROUP BY tn.id, lda."Legal Document", lda.TotalLegalDocs, lda.LatestDate, ei.Document
ORDER BY DocumentMatches DESC, IndustryMatches DESC;