DROP TABLE IF EXISTS q4 CASCADE;


CREATE TABLE q4 (
    albumid int NOT NULL
    albumname Char(50) NOT NULL
    numsessions int NOT NULL
    numpeople int NOT NULL
);


DROP VIEW IF EXISTS almost;

CREATE VIEW AS almost
SELECT m.album_id as albumid, count(distinct ms.sessions_id) as numsessions, count(DISTINCT a.member) as numpeople
FROM MusicOn m JOIN Contains c ON m.track_id = c.track_id JOIN Segment s ON 
s.segment_id = c.segment_id JOIN MusicSession ms ON ms.session_id = s.session_id JOIN Artist a ON a.artist_id = ms.artist_id
GROUP BY m.album_id;

INSERT into q4
SELECT al.name as albumname, albumid, numsessions, numpeople
FROM almost a JOIN Album al on al.album_id = a.album_id;
