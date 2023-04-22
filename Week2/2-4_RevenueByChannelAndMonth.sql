%%sql

SELECT LEFT(ts,7) as ym,channel,
COUNT(DISTINCT userid) AS uniqueUsers,
COUNT(DISTINCT CASE WHEN amount>0 THEN userid END) AS paidUsers,
(paidUsers::float/NULLIF(uniqueUsers,0)::float) AS conversionRate,
SUM(str.amount) as grossRevenue,
SUM(CASE WHEN str.refunded is FALSE THEN amount END) AS netGrossRevenue
FROM raw_data.user_session_channel usc 
JOIN raw_data.session_transaction str ON usc.sessionid = str.sessionid
JOIN raw_data.session_timestamp st ON usc.sessionid = st.sessionid
GROUP BY CHANNEL, ym
ORDER BY YM, channel;