SELECT to_char(st.ts, 'YYYY-MM') AS date, COUNT(DISTINCT usc.userid) AS MAU
FROM raw_data.session_timestamp AS st JOIN raw_data.user_session_channel AS usc
ON st.sessionid = usc.sessionid
GROUP BY date
ORDER BY date;
--https://lslagi.tistory.com/18
