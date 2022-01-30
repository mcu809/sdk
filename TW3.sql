CREATE TABLE ACTOR
(
    ACTID INT ,
    ACTNAME VARCHAR(20),
    GENDER VARCHAR(20),
    PRIMARY KEY(ACTID)
);

INSERT INTO ACTOR VALUES(1, 'MARK', 'M');
INSERT INTO ACTOR VALUES(2, 'LEO', 'M');
INSERT INTO ACTOR VALUES(3, 'ALYSON', 'F');
INSERT INTO ACTOR VALUES(4, 'JAMIE', 'F');

CREATE TABLE DIRECTOR
(
    DIRID INT ,
    DIRNAME VARCHAR(20),
    DIRPHONE INT ,
    PRIMARY KEY(DIRID)
);
INSERT INTO DIRECTOR VALUES(1, 'JON', 7894561231);
INSERT INTO DIRECTOR VALUES(2, 'HICKCOCK', 7894561232);
INSERT INTO DIRECTOR VALUES(3, 'STEVEN SPIELBERG', 7894561233);
INSERT INTO DIRECTOR VALUES(4, 'JOHN', 7894561234);

CREATE TABLE MOVIES
(
    MOVID INT ,
    MOVTITLE VARCHAR(20),
    MOVYEAR INT,
    MOVLANG VARCHAR(20),
    DIRID INT,
    PRIMARY KEY(MOVID),
    FOREIGN KEY(DIRID) REFERENCES DIRECTOR (DIRID)
);

INSERT INTO MOVIES VALUES(1, 'IRONMAN', 2014, 'ENGLISH', 1);
INSERT INTO MOVIES VALUES(2, 'THE BIRDS', 2015, 'GERMAN', 1);
INSERT INTO MOVIES VALUES(3, 'INDIANA', 2016, 'ENGLISH', 2);
INSERT INTO MOVIES VALUES(4, 'THE PERIST', 2017, 'GERMAN', 2);
INSERT INTO MOVIES VALUES(5, 'HULK', 1999, 'GERMAN', 3);

CREATE TABLE MOVIECAST
(
    ACTID INT ,
    MOVID INT ,
    ROLE VARCHAR(20),
    PRIMARY KEY(ACTID, MOVID),
    FOREIGN KEY(ACTID) REFERENCES ACTOR (ACTID),
    FOREIGN KEY(MOVID) REFERENCES MOVIES (MOVID)
);

INSERT INTO MOVIECAST VALUES(1, 1, 'HERO');
INSERT INTO MOVIECAST VALUES(2, 2, 'HERO');
INSERT INTO MOVIECAST VALUES(3, 3, 'HERO');
INSERT INTO MOVIECAST VALUES(4, 4, 'HERO');
INSERT INTO MOVIECAST VALUES(1, 5, 'SIDE ACTOR');
INSERT INTO MOVIECAST VALUES(1, 4, 'SIDE ACTOR');
INSERT INTO MOVIECAST VALUES(1, 2, 'SIDE ACTOR');

CREATE TABLE RATING
(
    MOVID INT ,
    REV_STARS INT,
    FOREIGN KEY(MOVID) REFERENCES MOVIES (MOVID)
);

INSERT INTO RATING VALUES (3, 3);
INSERT INTO RATING VALUES (4, 4);
INSERT INTO RATING VALUES (5, 5);
INSERT INTO RATING VALUES (1, 4);
INSERT INTO RATING VALUES (2, 5);

-- Q1
SELECT MOVTITLE
FROM DIRECTOR D, MOVIES M
WHERE D.DIRID = M.DIRID 
AND D.DIRNAME = 'HICKCOCK';

-- Q2
SELECT M.MOVID, M.MOVTITLE, MC.ACTID
FROM MOVIES M, MOVIECAST MC
WHERE M.MOVID=MC.MOVID 
AND MC.ACTID IN (
    SELECT ACTID
    FROM MOVIECAST MC
    GROUP BY ACTID
    HAVING COUNT(*) > 2
);

-- Q3
SELECT ACTNAME
FROM ACTOR A
JOIN MOVIECAST C
ON A.ACTID=C.ACTID
JOIN MOVIES M
ON C.MOVID=M.MOVID
WHERE M.MOVYEAR NOT BETWEEN 2000 AND 2015;

-- Q4
SELECT MOVTITLE, MAX (REV_STARS), SUM(REV_STARS)
FROM MOVIES M, RATING R
WHERE M.MOVID =R.MOVID
GROUP BY MOVTITLE 
HAVING MAX (REV_STARS)>0 
ORDER BY MOVTITLE;

-- Q5
UPDATE RATING 
SET REV_STARS=5 
WHERE MOVID IN (
    SELECT MOVID 
    FROM MOVIES M, DIRECTOR D
    WHERE M.DIRID=D.DIRID 
    AND D.DIRNAME =  'HICKCOCK'
);