DROP DATABASE IF EXISTS UserDB;
CREATE DATABASE IF NOT EXISTS UserDB;
USE UserDB;




CREATE TABLE IF NOT EXISTS USER (
    USERID     VARCHAR(200),
    VORNAME    VARCHAR(100),
    NACHNAME   VARCHAR(100),
    MAIL       VARCHAR(300),
    STARTDATE  DATE,
    ENDDATE    DATE,
    PRIMARY KEY (USERID)
);

CREATE TABLE IF NOT EXISTS ABTEILUNG(
    ABTEILUNGSID     INTEGER NOT NULL,
    ABTEILUNG        VARCHAR(100),
    ABTEILUNGKUERZEL  VARCHAR(10),
    PRIMARY KEY (ABTEILUNGSID)
);

CREATE TABLE IF NOT EXISTS USERSTATEN(
    STATUSID        INTEGER NOT NULL,
    STATUSNAME      VARCHAR(50),
    PRIMARY KEY (STATUSID)
);

CREATE TABLE IF NOT EXISTS USERLISTE(
    USERID          VARCHAR(200)
    STATUSID        INTEGER NOT NULL,
    FOREIGN KEY (USERID) REFERENCES USER (USERID),
    FOREIGN KEY (STATUSID) REFERENCES USERSTATEN (STATUSID)
);

CREATE TABLE IF NOT EXISTS USERABTELIUNG(
    USERID          VARCHAR(200)
    ABTEILUNGSID        INTEGER NOT NULL,
    FOREIGN KEY (USERID) REFERENCES USER (USERID),
    FOREIGN KEY (ABTEILUNGSID) REFERENCES ABTEILUNG (ABTEILUNGSID)
);  COLLATE




USE USERDB;
/***Insert User***/
INSERT INTO USER (USERID, VORNAME, NACHNAME, MAIL, STARTDATE, ENDDATE) VALUES ('HansPeter', 'Hans', 'Peter', 'HansPeter@mail.com', '2021-01-01', '2021-01-31');
INSERT INTO USER (USERID, VORNAME, NACHNAME, MAIL, STARTDATE, ENDDATE) VALUES ('KlausJuergen', 'Klaus', 'Juergen', 'KlausJuergen@mail.com', '2021-12-01', '2021-12-31');

/***Insert Abteilungen***/
INSERT INTO ABTEILUNG (ABTEILUNGSID, ABTEILUNG, ABTEILUNGKUERZEL) VALUES (1, 'Einkauf', 'EK');
INSERT INTO ABTEILUNG (ABTEILUNGSID, ABTEILUNG, ABTEILUNGKUERZEL) VALUES (2, 'Verkauf', 'VK');
INSERT INTO ABTEILUNG (ABTEILUNGSID, ABTEILUNG, ABTEILUNGKUERZEL) VALUES (3, 'Personal', 'HR');
INSERT INTO ABTEILUNG (ABTEILUNGSID, ABTEILUNG, ABTEILUNGKUERZEL) VALUES (4, 'InterneIT', 'IT');

/***Insert Status***/
INSERT INTO USERSTATEN (STATUSID, STATUSNAME) VALUES (1, 'Aktiv');
INSERT INTO USERSTATEN (STATUSID, STATUSNAME) VALUES (2, 'Inaktiv');

/***Insert User (Userliste + Status)***/
INSERT INTO USERLISTE (USERID, STATUSID) VALUES ('HansPeter', 1);
INSERT INTO USERLISTE (USERID, STATUSID) VALUES ('KlausJuergen', 2);

/***Insert Userabteilung (User + Abteilung)***/
INSERT INTO USERABTELIUNG (USERID, ABTEILUNGSID) VALUES ('HansPeter', 1);
INSERT INTO USERABTELIUNG (USERID, ABTEILUNGSID) VALUES ('KlausJuergen', 2);



COMMIT WORK;