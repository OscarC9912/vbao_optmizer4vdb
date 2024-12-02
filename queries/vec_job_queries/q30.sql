SELECT MIN(mi.info) AS movie_budget, MIN(mi_idx.info) AS movie_votes, MIN(t.title) AS movie_title 
FROM 
vector_k_nearest_neighbor(
    (SELECT vec_title FROM aka_title ORDER BY id LIMIT 1 OFFSET 9111),
    'aka_title',
    'vec_title',
    1003130
) AS vknn,
cast_info AS ci, info_type AS it1, info_type AS it2, movie_info AS mi, movie_info_idx AS mi_idx, name AS n, title AS t 
WHERE vknn.id = t.id AND ci.note  in ('(writer)', '(head writer)', '(written by)', '(story)', '(story editor)') AND it1.info  = 'genres' AND it2.info  = 'votes' AND mi.info  in ('Horror', 'Action', 'Sci-Fi', 'Thriller', 'Crime', 'War') AND n.gender  = 'm' AND t.id = mi.movie_id AND t.id = mi_idx.movie_id AND t.id = ci.movie_id AND ci.movie_id = mi.movie_id AND ci.movie_id = mi_idx.movie_id AND mi.movie_id = mi_idx.movie_id AND n.id = ci.person_id AND it1.id = mi.info_type_id AND it2.id = mi_idx.info_type_id;
