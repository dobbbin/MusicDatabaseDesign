drop schema if exists recording cascade;
create schema recording;
set search_path to recording;


--The table studio holds the information for a given studio
--studio_id is the prymary key unique to each studio in the table
--studio_name is the name of the studio
--studio_address is the address of the studio
CREATE TABLE Studio (
    studio_id SERIAL PRIMARY KEY,
    studio_name VARCHAR(25) NOT NULL,
    studio_address VARCHAR(30) NOT NULL
);

--The table People holds the information for each person the the 
--studio database
--person_id is the unique key which represents a given person
--person_name is the first and last name of a person in the format last, first
--email is the email of the person
--phone is the phone number of the person represented as a string
CREATE TABLE People (
    person_id SERIAL PRIMARY KEY,
    person_name VARCHAR(50) NOT NULL,
    email VARCHAR(25) NOT NULL,
    phone VARCHAR(15) NOT NULL
);


--Artist is a table which holds the information for bands and solo musicians
-- artist_id is a unique id that refers to a band or solo artist
-- member is the name of person that the row of this table refers to
-- bandname is the name of the band, if it is a solo artist it is their "stagename"
-- plays refers to what instruments they play listen with commans seperating them
-- The key of this table is (artist_id, member) as in Bandname/soloartist, name
CREATE TABLE Artist (
    artist_id SERIAL NOT NULL,
    member int REFERENCES People ON DELETE CASCADE NOT NULL,
    bandname VARCHAR(30) NOT NULL,
    --plays VARCHAR(30) NOT NULL,
    PRIMARY KEY (artist_id, member)
);


--Manager is a table which holds the information for all Managers of studios
--manager_id is a subset of person_id and is unique to each manager
--startdatetime is a timestamp which tracks the starting date of this manager_id at this studio_id
--studio_id references the Studio table
CREATE TABLE Manager (
   manager_id SERIAL REFERENCES People ON DELETE CASCADE NOT NULL,
   startdatetime TIMESTAMP NOT NULL,
   studio_id SERIAL REFERENCES Studio ON DELETE CASCADE NOT NULL,
   PRIMARY KEY (manager_id, startdatetime, studio_id)
);

--MusicSession refers to a session that some artist has at a given studio
--sessions_id is a unique id given to each session
--artist_id references Artist and is the id of the artist at the session
--studio_id references studio and is the studio in which the session took place
--startdatetime is a timestamp of the time the session started
--enddatetime is a timestamp of the time the session ended
CREATE TABLE MusicSession (
    sessions_id SERIAL NOT NULL
    artist_id SERIAL REFERENCES Artist ON DELETE CASCADE NOT NULL,
    member SERIAL REFERENCES Artist ON DELETE CASCADE NOT NULL,
    studio_id SERIAL REFERENCES Studio ON DELETE CASCADE NOT NULL,
    startdatetime TIMESTAMP NOT NULL,
    enddatetime TIMESTAMP NOT NULL,
    PRIMARY KEY (sessions_id, artist_id, member)
);

--Employee refers to a table of recording engineers and what sessions they worked on
--eid is the id given from the People table 
--sessions_id is the id of the session that this eid worked on
CREATE TABLE Employee (
    eid SERIAL REFERENCES People ON DELETE CASCADE NOT NULL,
    sessions_id SERIAL REFERENCES MusicSessions ON DELETE CASCADE NOT NULL
    PRIMARY KEY (eid, sessions_id)
);

--Certifications table refers to the certifications that recording engineers have
-- eid is the recording engineer that has a certification
-- certid is the given certification 
CREATE TABLE Certification (
    eid SERIAL REFERENCES Employee ON DELETE CASCADE NOT NULL,
    certid SERIAL NOT NULL
    PRIMARY KEY (eid, certid)
);


--Segment table refers to a segment that has been recored
--segment_id is a unique id for each segment
--s_format is a string which states the format of the segment ex: sound
--sessions_id refers to the id from Sessions and it is the session where the segment was recored
--lens is the length of the given segment given as an int representing seconds 
CREATE TABLE Segment (
    segment_id SERIAL PRIMARY KEY,
    s_format VARCHAR(20) NOT NULL,
    sessions_id SERIAL REFERENCES MusicSessions ON DELETE CASCADE NOT NULL
    lens int not null
);

--Track refers to a track that an artist has recorded
--track_id is a unique id that
--name is the name of a track represented as a string
-- artist_id is the id from the Artist table 
CREATE TABLE Track(
    track_id SERIAL PRIMARY KEY,
    track_name VARCHAR(20),
    artist_id SERIAL REFERENCES Artist ON DELETE CASCADE NOT NULL
);

--Contains is a table that represents the relation of if a segment is on a track
-- segment_id references the table Segment and it is the segment featured on the track
-- track_id references Track and is the track that the segment is on
CREATE TABLE Contains (
    segment_id SERIAL REFERENCES Segment ON DELETE CASCADE NOT NULL
    track_id SERIAL REFERENCES Track ON DELETE CASCADE NOT NULL
    PRIMARY KEY (segment_id, track_id)
);

--Album is a table that contains information of an album
--album_id is a unique id for each album
--name is the name of the album
--relase date is the timestamp of whent he album was released
CREATE TABLE Album (
    album_id SERIAL PRIMARY KEY NOT NULL,
    album_name VARCHAR(20) NOT NULL,
    RelaseDate TIMESTAMP NOT NULL,
); 

-- MusicOn is a table that shows what tracks are on what album
--album_id references Album and is the album the track is on
--track_id is the track that is on the album
Create TABLE MusicOn (
    album_id SERIAL REFERENCES Album ON DELETE CASCADE NOT NULL
    track_id SERIAL REFERENCES Track ON DELETE CASCADE NOT NULL
    PRIMARY KEY (album_id, track_id)
);
