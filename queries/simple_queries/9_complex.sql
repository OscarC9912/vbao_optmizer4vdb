WITH top_neighbors AS (
    SELECT id
    FROM vector_k_nearest_neighbor(
        (
            SELECT embedding 
            FROM embedding_info 
            ORDER BY id 
            LIMIT 1 OFFSET 129
        ),
        'embedding_info',
        'embedding',
        109
    )
)
SELECT 
    tn.id, Concept AS cpt, Industry AS ids
FROM top_neighbors tn
JOIN embedding_info ei ON tn.id = ei.id
WHERE Organization=1 AND Document=0 AND "Legal Document"=1;