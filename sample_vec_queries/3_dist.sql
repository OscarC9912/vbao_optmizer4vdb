SELECT 
    (SELECT embedding FROM embedding_info WHERE id = 1)::vector 
    <-> 
    (SELECT embedding FROM embedding_info WHERE id = 200)::vector 
AS distance;