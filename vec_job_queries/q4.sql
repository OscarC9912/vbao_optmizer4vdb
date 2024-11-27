SELECT COUNT(*)
FROM title AS t,
     kind_type AS kt,
     info_type AS it1,
     movie_info AS mi1,
     cast_info AS ci,
     role_type AS rt,
     name AS n,
     movie_keyword AS mk,
     keyword AS k,
     movie_companies AS mc,
     company_type AS ct,
     company_name AS cn,
     vector_k_nearest_neighbor(
         (SELECT vec_keyword FROM keyword ORDER BY id LIMIT 1),
         'keyword',
         'vec_keyword',
         120
     ) AS vknn
WHERE
    t.id = ci.movie_id
    AND t.id = mc.movie_id
    AND t.id = mi1.movie_id
    AND t.id = mk.movie_id
    AND mc.company_type_id = ct.id
    AND mc.company_id = cn.id
    AND k.id = mk.keyword_id
    AND mi1.info_type_id = it1.id
    AND t.kind_id = kt.id
    AND ci.person_id = n.id
    AND ci.role_id = rt.id
    AND vknn.id = k.id -- Match the vector-based nearest neighbors on keywords
    AND (it1.id IN ('2'))
    AND (mi1.info IN ('Black and White','Color'))
    AND (kt.kind IN ('movie','tv movie','tv series'))
    AND (rt.role IN ('actor','composer','miscellaneous crew','producer','production designer'))
    AND (n.gender IN ('m') OR n.gender IS NULL)
    AND (n.name_pcode_cf IN ('A2365','A6252','C52','D1614','E1524','E2163','L1214','L2','P5215','Q5325','R2425','S1452','T5212','V4524','V4626'))
    AND (t.production_year <= 2015)
    AND (t.production_year >= 1990)
    AND (cn.name IN ('ABS-CBN','American Broadcasting Company (ABC)','British Broadcasting Corporation (BBC)'))
    AND (ct.kind IN ('distributors','production companies'));