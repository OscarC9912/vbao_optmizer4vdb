SELECT MIN(an.name) AS cool_actor_pseudonym, MIN(t.title) AS series_named_after_char 
FROM aka_name AS an, 
     cast_info AS ci,
     vector_k_nearest_neighbor(
         (SELECT vec_name FROM char_name ORDER BY id LIMIT 1 OFFSET 899),
         'char_name',
         'vec_name',
         300
     ) AS vknn,
     company_name AS cn, 
     keyword AS k, 
     movie_companies AS mc, 
     movie_keyword AS mk, 
     name AS n, 
     title AS t 
WHERE cn.country_code ='[us]' AND k.keyword ='character-name-in-title' AND an.person_id = n.id AND n.id = ci.person_id AND ci.movie_id = t.id AND t.id = mk.movie_id AND mk.keyword_id = k.id AND t.id = mc.movie_id AND mc.company_id = cn.id AND an.person_id = ci.person_id AND ci.movie_id = mc.movie_id AND ci.movie_id = mk.movie_id AND mc.movie_id = mk.movie_id AND vknn.id = an.id;
