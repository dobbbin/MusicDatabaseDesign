DROP TABLE IF EXISTS q2 CASCADE;


CREATE TABLE q2 (
    id int NOT NULL
    numsessions int NOT NULL
);

--The Person who participated in the most music sessions
INSERT into q2
SELECT  p.person_id as id, count(DISTINCT ms.sessions_id) as numsessions
FROM People p LEFT JOIN Artist a ON p.person_id = a.member JOIN MusicSession ms ON ms.artist_id = a.artist_id
GROUP BY p.person_id;
