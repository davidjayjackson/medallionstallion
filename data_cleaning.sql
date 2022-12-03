SELECT  username,count(*)as usercount
FROM elonMentions
GROUP BY username
ORDER BY count(*) desc
LIMIT 25;

SELECT substr(date,1,10) as date
FROM elonMentions

UPDATE elonMentions
SET date = substr(date,1,10);

SELECT date,count(*) as datecount
FROM elonMentions
GROUP BY date;



-- elonTweets
UPDATE elonTweets
SET date = substr(date,1,10);

SELECT date,count(*) as tweetcount
FROM elonTweets
GROUP BY date
ORDER BY count(*) desc ;
