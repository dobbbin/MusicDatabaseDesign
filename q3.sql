DROP TABLE IF EXISTS q3 CASCADE;


CREATE TABLE q3 (
    personid int NOT NULL
    names Char(50) NOT NULL
);

DROP VIEW IF EXISTS SessionLengths

CREATE VIEW SessionLengths AS
SELECT sessions_id, count(lens) as clens
FROM Segment 
GROUP BY sessions_id;

DROP VIEW IF EXISTS MaxSession

CREATE VIEW MaxSession AS
SELECT sessions_id
FROM SessionLengths s 
WHERE IN (SELECT * from sessionLengths where clens < s.clens);

INSERT INTO q3
SELECT p.person_id as personid, p.names as names
FROM MaxSession ma JOIN MusicSession ms ON ma.sessions_id = ms.sessions_id JOIN Artist a ON ms.artist_id = a.artist_id
JOIN People p ON p.person_id = a.member;