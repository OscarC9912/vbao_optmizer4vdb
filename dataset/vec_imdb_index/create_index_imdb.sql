-- Index name: aka_name_pkey on table: aka_name
CREATE UNIQUE INDEX aka_name_pkey ON public.aka_name USING btree (id);

-- Index name: person_id_aka_name on table: aka_name
CREATE INDEX person_id_aka_name ON public.aka_name USING btree (person_id);

-- Index name: complete_cast_pkey on table: complete_cast
CREATE UNIQUE INDEX complete_cast_pkey ON public.complete_cast USING btree (id);

-- Index name: movie_id_complete_cast on table: complete_cast
CREATE INDEX movie_id_complete_cast ON public.complete_cast USING btree (movie_id);

-- Index name: aka_title_pkey on table: aka_title
CREATE UNIQUE INDEX aka_title_pkey ON public.aka_title USING btree (id);

-- Index name: kind_id_aka_title on table: aka_title
CREATE INDEX kind_id_aka_title ON public.aka_title USING btree (kind_id);

-- Index name: movie_id_aka_title on table: aka_title
CREATE INDEX movie_id_aka_title ON public.aka_title USING btree (movie_id);

-- Index name: cast_info_pkey on table: cast_info
CREATE UNIQUE INDEX cast_info_pkey ON public.cast_info USING btree (id);

-- Index name: movie_id_cast_info on table: cast_info
CREATE INDEX movie_id_cast_info ON public.cast_info USING btree (movie_id);

-- Index name: person_id_cast_info on table: cast_info
CREATE INDEX person_id_cast_info ON public.cast_info USING btree (person_id);

-- Index name: person_role_id_cast_info on table: cast_info
CREATE INDEX person_role_id_cast_info ON public.cast_info USING btree (person_role_id);

-- Index name: role_id_cast_info on table: cast_info
CREATE INDEX role_id_cast_info ON public.cast_info USING btree (role_id);

-- Index name: info_type_pkey on table: info_type
CREATE UNIQUE INDEX info_type_pkey ON public.info_type USING btree (id);

-- Index name: char_name_pkey on table: char_name
CREATE UNIQUE INDEX char_name_pkey ON public.char_name USING btree (id);

-- Index name: comp_cast_type_pkey on table: comp_cast_type
CREATE UNIQUE INDEX comp_cast_type_pkey ON public.comp_cast_type USING btree (id);

-- Index name: company_name_pkey on table: company_name
CREATE UNIQUE INDEX company_name_pkey ON public.company_name USING btree (id);

-- Index name: company_type_pkey on table: company_type
CREATE UNIQUE INDEX company_type_pkey ON public.company_type USING btree (id);

-- Index name: keyword_pkey on table: keyword
CREATE UNIQUE INDEX keyword_pkey ON public.keyword USING btree (id);

-- Index name: kind_type_pkey on table: kind_type
CREATE UNIQUE INDEX kind_type_pkey ON public.kind_type USING btree (id);

-- Index name: link_type_pkey on table: link_type
CREATE UNIQUE INDEX link_type_pkey ON public.link_type USING btree (id);

-- Index name: movie_companies_pkey on table: movie_companies
CREATE UNIQUE INDEX movie_companies_pkey ON public.movie_companies USING btree (id);

-- Index name: company_id_movie_companies on table: movie_companies
CREATE INDEX company_id_movie_companies ON public.movie_companies USING btree (company_id);

-- Index name: company_type_id_movie_companies on table: movie_companies
CREATE INDEX company_type_id_movie_companies ON public.movie_companies USING btree (company_type_id);

-- Index name: movie_id_movie_companies on table: movie_companies
CREATE INDEX movie_id_movie_companies ON public.movie_companies USING btree (movie_id);

-- Index name: movie_info_pkey on table: movie_info
CREATE UNIQUE INDEX movie_info_pkey ON public.movie_info USING btree (id);

-- Index name: info_type_id_movie_info on table: movie_info
CREATE INDEX info_type_id_movie_info ON public.movie_info USING btree (info_type_id);

-- Index name: movie_id_movie_info on table: movie_info
CREATE INDEX movie_id_movie_info ON public.movie_info USING btree (movie_id);

-- Index name: movie_keyword_pkey on table: movie_keyword
CREATE UNIQUE INDEX movie_keyword_pkey ON public.movie_keyword USING btree (id);

-- Index name: keyword_id_movie_keyword on table: movie_keyword
CREATE INDEX keyword_id_movie_keyword ON public.movie_keyword USING btree (keyword_id);

-- Index name: movie_id_movie_keyword on table: movie_keyword
CREATE INDEX movie_id_movie_keyword ON public.movie_keyword USING btree (movie_id);

-- Index name: movie_info_idx_pkey on table: movie_info_idx
CREATE UNIQUE INDEX movie_info_idx_pkey ON public.movie_info_idx USING btree (id);

-- Index name: info_type_id_movie_info_idx on table: movie_info_idx
CREATE INDEX info_type_id_movie_info_idx ON public.movie_info_idx USING btree (info_type_id);

-- Index name: movie_id_movie_info_idx on table: movie_info_idx
CREATE INDEX movie_id_movie_info_idx ON public.movie_info_idx USING btree (movie_id);

-- Index name: movie_link_pkey on table: movie_link
CREATE UNIQUE INDEX movie_link_pkey ON public.movie_link USING btree (id);

-- Index name: link_type_id_movie_link on table: movie_link
CREATE INDEX link_type_id_movie_link ON public.movie_link USING btree (link_type_id);

-- Index name: linked_movie_id_movie_link on table: movie_link
CREATE INDEX linked_movie_id_movie_link ON public.movie_link USING btree (linked_movie_id);

-- Index name: movie_id_movie_link on table: movie_link
CREATE INDEX movie_id_movie_link ON public.movie_link USING btree (movie_id);

-- Index name: name_pkey on table: name
CREATE UNIQUE INDEX name_pkey ON public.name USING btree (id);

-- Index name: person_info_pkey on table: person_info
CREATE UNIQUE INDEX person_info_pkey ON public.person_info USING btree (id);

-- Index name: info_type_id_person_info on table: person_info
CREATE INDEX info_type_id_person_info ON public.person_info USING btree (info_type_id);

-- Index name: person_id_person_info on table: person_info
CREATE INDEX person_id_person_info ON public.person_info USING btree (person_id);

-- Index name: role_type_pkey on table: role_type
CREATE UNIQUE INDEX role_type_pkey ON public.role_type USING btree (id);

-- Index name: title_pkey on table: title
CREATE UNIQUE INDEX title_pkey ON public.title USING btree (id);

-- Index name: kind_id_title on table: title
CREATE INDEX kind_id_title ON public.title USING btree (kind_id);

