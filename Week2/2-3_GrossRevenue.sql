%%sql

SELECT userid,sum(amount) as GrossRevenue
FROM
    (SELECT a.sessionid, a.userid, str.amount
    FROM 
        (SELECT st.sessionid, usc.userid
        FROM raw_data.user_session_channel usc JOIN raw_data.session_timestamp st
        ON usc.sessionid=st.sessionid) a
        JOIN
        raw_data.session_transaction str
        ON a.sessionid = str.sessionid
    limit 10)
GROUP BY userid
ORDER BY GrossRevenue DESC
limit 10;

/* 개선
SELECT userid,sum(amount) as GrossRevenue
FROM raw_data.user_session_channel usc 
JOIN raw_data.session_transaction str ON usc.sessionid = str.sessionid
GROUP BY userid
ORDER BY GrossRevenue DESC
limit 10;
*/
