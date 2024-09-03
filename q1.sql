DROP TABLE IF EXISTS q1 CASCADE;


CREATE TABLE q1 (
	manager CHAR(50) NOT NULL,
    id int NOT NULL
    numalbums int NOT NULL
);


DROP VIEW IF EXISTS AlbumsPerStudio CASCADE;

-- The Number of unique albums each studio contributed to
CREATE VIEW AlbumsPerStudio AS 
SELECT ms.studio_id, count(distinct m.album_id) as numalbums
FROM MusicOn m JOIN Contains c ON m.track_id = c.track_id JOIN Segment s ON 
s.segment_id = c.segment_id JOIN MusicSession ms ON ms.session_id = s.session_id
GROUP BY ms.studio_id;


INSERT INTO q1
SELECT p.person_name as manager, m.manager_id as id, numalbums
FROM AlbumsPerStudio a JOIN Manager m ON m.studio_id = a.studio_id JOIN People p ON p.person_id = m.manager_id
WHERE not in (SELECT manager_id FROM manager WHERE startdatetime < m.startdatetime AND m.studio_id = studio_id)
