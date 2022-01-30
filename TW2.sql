CREATE TABLE SALESMAN
(
    SID INT ,
    SNAME VARCHAR(20),
    CITY VARCHAR(20),
    COMMISSION INT,
    PRIMARY KEY(SID)
);

INSERT INTO SALESMAN VALUES(1, 'MIKE', 'BANG', 100);
INSERT INTO SALESMAN VALUES(2, 'LEO', 'ND', 100);
INSERT INTO SALESMAN VALUES(3, 'MARK', 'HUB', 100);
INSERT INTO SALESMAN VALUES(4, 'AYLSON', 'DHW', 100);


CREATE TABLE CUSTOMER
(
    CID INT,
    CNAME VARCHAR(20),
    CITY VARCHAR(20),
    GRADE INT,
    SID INT,
    PRIMARY KEY(CID),
    FOREIGN KEY(SID) REFERENCES SALESMAN(SID)
);

INSERT INTO CUSTOMER VALUES(1, 'MARKUS', 'BANG', 2, 1);
INSERT INTO CUSTOMER VALUES(2, 'LUKE', 'ND', 3, 2);
INSERT INTO CUSTOMER VALUES(3, 'LAMO', 'HUB', 4, 3);
INSERT INTO CUSTOMER VALUES(4, 'ALEX', 'DHW', 5, 4);
INSERT INTO CUSTOMER VALUES(5, 'ALEXIS', 'BANG', 3, 2);


CREATE TABLE ORDERS
(
    ONO INT,
    PAMT INT,
    ODATE DATE,
    CID INT,
    SID INT,
    PRIMARY KEY(ONO),
    FOREIGN KEY(SID) REFERENCES SALESMAN(SID),
    FOREIGN KEY(CID) REFERENCES CUSTOMER(CID)
);

INSERT INTO ORDERS VALUES(1, 4000, DATE '2017-01-01', 1, 1);
INSERT INTO ORDERS VALUES(2, 5000, DATE '2017-02-01', 2, 2);
INSERT INTO ORDERS VALUES(3, 6000, DATE '2017-03-01', 2, 2);
INSERT INTO ORDERS VALUES(4, 7000, DATE '2017-04-01', 3, 1);
INSERT INTO ORDERS VALUES(5, 7000, DATE '2017-05-01', 3, 1);

-- Q1
SELECT COUNT(CID)
FROM CUSTOMER
WHERE GRADE > (SELECT AVG(GRADE) FROM  CUSTOMER WHERE CITY = 'Banglore')

-- Q2
SELECT SID, SNAME 
FROM SALESMAN 
WHERE SID IN (
    SELECT SID 
    FROM CUSTOMER
    GROUP BY SID
    HAVING COUNT(*) > 1
);
-- Q3
    SELECT S.SID, S.CITY AS SCITY, CNAME
    FROM SALESMAN S, CUSTOMER C
    WHERE C.SID=S.SID AND C.CITY=S.CITY
UNION
    SELECT S.SID, S.CITY AS SCITY, 'NOMATCH'
    FROM SALESMAN S, CUSTOMER C
    WHERE C.SID=S.SID AND C.CITY<>S.CITY; 

--Q4
SELECT O.SID, S.SNAME 
FROM ORDERS O, SALESMAN S
WHERE S.SID = O.SID AND 
PAMT = (SELECT MAX(PAMT) FROM ORDERS WHERE ODATE = DATE '2017-04-01');

-- Q5
-- DELETE FROM SALESMAN WHERE SID = 1000;