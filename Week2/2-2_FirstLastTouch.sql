SELECT 
  firstTable.userid,
  firstTable.channel as firstTouch,
  lastTable.channel as lastTouch
  
FROM 
(SELECT a.userid, a.channel, a.firstseq
FROM(
    SELECT usc.userid,usc.sessionid,usc.channel, st.ts,
    ROW_NUMBER() OVER(partition by userid order by ts ASC) firstseq
    FROM raw_data.user_session_channel usc JOIN raw_data.session_timestamp st
    ON usc.sessionid=st.sessionid
    order by st.ts
) a
where firstseq<=1) firstTable

JOIN

(SELECT b.userid, b.channel, b.lastseq
FROM(
    SELECT usc.userid,usc.sessionid,usc.channel, st.ts,
    ROW_NUMBER() OVER(partition by userid order by ts desc) lastseq
    FROM raw_data.user_session_channel usc JOIN raw_data.session_timestamp st
    ON usc.sessionid=st.sessionid
    order by st.ts
) b
where lastseq<=1) lastTable

ON firstTable.userid = lastTable.userid
ORDER BY userid
