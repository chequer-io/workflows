-- 특정 기간동안 pathname 별로 카운트 뽑기 + pathname에서 locale 제거하여 처리하기 + not_found 제외
SELECT pathname, COUNT(*)
FROM (
         SELECT
             CASE
                 WHEN REPLACE(REPLACE(pathname, '/ko', ''), '/ja', '') = '' THEN '/'
                 ELSE REPLACE(REPLACE(pathname, '/ko', ''), '/ja', '')
                 END AS pathname
         FROM page_view_logs
         WHERE created_at BETWEEN '2025-01-06' AND '2025-01-31' AND not_found = false
     ) A
GROUP BY A.pathname
ORDER BY A.pathname;