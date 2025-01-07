SELECT pathname, COUNT(*)
FROM (
         SELECT
             CASE
                 WHEN REPLACE(REPLACE(pathname, '/ko', ''), '/ja', '') = '' THEN '/'
                 ELSE REPLACE(REPLACE(pathname, '/ko', ''), '/ja', '')
                 END AS pathname
         FROM page_view_logs
         WHERE created_at BETWEEN '2025-01-06' AND '2025-01-31' AND not_found = true
     ) A
GROUP BY A.pathname
ORDER BY A.pathname;
