/* Employee Database Table Creation Script, Platform - Oracle SQL Server/Developer

-- Begin db connection and clear workspace
-- Also suppresses error messages if tables do not exist

-- Create user cam
CONNECT system/Oracle11g;
prompt>Dropping users
DROP USER cam CASCADE;

prompt>Creating users
CREATE USER cam IDENTIFIED BY cam DEFAULT TABLESPACE users;

prompt>Granting privileges
GRANT ALL PRIVILEGES TO cam;

--Connect as user cam
CONNECT cam/cam;

BEGIN
EXECUTE IMMEDIATE 'DROP VIEW Employee_Labs_vw';

EXECUTE IMMEDIATE 'DROP SEQUENCE EmployeeID_seq';
EXECUTE IMMEDIATE 'DROP SEQUENCE LabID_seq';
EXECUTE IMMEDIATE 'DROP SEQUENCE WorkID_seq';

EXECUTE IMMEDIATE 'DROP TABLE tblEmployeeSchedule';
EXECUTE IMMEDIATE 'DROP TABLE tblLab';
EXECUTE IMMEDIATE 'DROP TABLE tblShift';
EXECUTE IMMEDIATE 'DROP TABLE tblEmployee';
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('');
END;
/
-- Begin db create tables

CREATE TABLE tblEmployee
(
EmployeeID                INTEGER             NOT NULL,
EmpFName                 VARCHAR2 (25)    NOT NULL,
EmpLName                 VARCHAR2 (25)   NOT NULL,
EmpSSN                     VARCHAR2 (12)    NOT NULL,
JobTitle                 VARCHAR2 (25),
CONSTRAINT tblEmployee_pk
PRIMARY KEY (EmployeeID)
);

CREATE TABLE tblLab
(
LabID                     INTEGER            NOT NULL,
LabDescr                 VARCHAR2(50),
CONSTRAINT tblLab_pk
PRIMARY KEY (LabID)
);

CREATE TABLE tblShift
(
ShiftID                 INTEGER            NOT NULL,
DayofWeek                 CHARACTER(3),
StartTime                 VARCHAR2 (5),
EndTime                 VARCHAR2 (5),
CONSTRAINT tblShift_pk
PRIMARY KEY (ShiftID)
);

CREATE TABLE tblWorksOn
(
WorkID                    INTEGER        NOT NULL,
EmployeeID                INTEGER        NOT NULL,
LabID                    INTEGER     NOT NULL,
CONSTRAINT tblWorksOn_pk
PRIMARY KEY (WorkID),
CONSTRAINT tblWorksOnEmpID_fk
FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID),
CONSTRAINT tblWorksOnLab_fk
FOREIGN KEY (LabID)    REFERENCES tblLab(LabID)
);

CREATE TABLE tblEmployeeSchedule
(
AssignmentID             INTEGER        NOT NULL,
EmployeeID                 INTEGER        NOT NULL,
LabID                     INTEGER        NOT NULL,
ShiftID                    INTEGER        NOT NULL,
WorkID                    INTEGER        NOT NULL,
CONSTRAINT tblEmployeeSchedule_pk
PRIMARY KEY (AssignmentID),
CONSTRAINT tblEmployeeScheduleEmp_fk
FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID),
CONSTRAINT tblEmployeeScheduleLab_fk
FOREIGN KEY (LabID) REFERENCES tblLab(LabID),
CONSTRAINT tblEmployeeScheduleShift_fk
FOREIGN KEY (ShiftID) REFERENCES tblShift(ShiftID),
CONSTRAINTS tblWorksOn_fk
FOREIGN KEY (WorkID) REFERENCES tblWorksOn(WorkID)
);

-- Sequence
CREATE SEQUENCE EmployeeID_seq
START WITH 125
INCREMENT BY 5;
CREATE SEQUENCE LabID_seq
START WITH 225
INCREMENT BY 5;
CREATE SEQUENCE WorkID_seq
START WITH 335
INCREMENT BY 5;

-- Insert employees into db

INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL,'Cameron', 'Anglin', '123-45-6789', 'Chief Executive Officer');
INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL,'Jimi', 'Hendrix', '124-78-9923', 'Scientist');
INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL, 'Linus', 'Torvalds', '332-05-6512', 'Software Engineer');
INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL, 'Bill', 'Gates', '909-76-3467', 'Software Engineer');
INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL, 'Clarke', 'Kent', '250-77-9843', 'Experimental Genetics');
INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL, 'Tony','Stark', '221-32-3234', 'Electrical Engineer');
INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL, 'Doc', 'Brown', '676-56-8892','Scientist');
INSERT INTO tblEmployee
(EmployeeID, EmpFName, EmpLName, EmpSSN, JobTitle)
VALUES (EmployeeID_seq.NEXTVAL, 'John','Grishsam', '120-45-2156', 'Accountant');

-- Insert employee Labs into db

INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Engineering');
INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Particle Physics');
INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Experimental Genetics');
INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Extraterrestrial Relations ');
INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Cryptology');
INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Human Resources');
INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Finance');
INSERT INTO tblLab
(LabID, LabDescr)
VALUES (LabID_seq.NEXTVAL, 'Board');

-- Insert shift types into db

INSERT INTO tblShift
(ShiftID, DayofWeek, StartTime, EndTime)
VALUES (1,'Mon', '07:00', '3:30');
INSERT INTO tblShift
(ShiftID, DayofWeek, StartTime, EndTime)
VALUES (2,'Tue', '07:30', '3:30');
INSERT INTO tblShift
(ShiftID, DayofWeek, StartTime, EndTime)
VALUES (3,'Wed', '07:30', '3:30');
INSERT INTO tblShift
(ShiftID, DayofWeek, StartTime, EndTime)
VALUES (4,'Thu', '07:30', '3:30');
INSERT INTO tblShift
(ShiftID, DayofWeek, StartTime, EndTime)
VALUES (5,'Fri', '07:30', '3:30');

-- Insert into tblWorksOn

INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,125, 260);
INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,130, 235);
INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,135, 225);
INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,140, 225);
INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,145, 235);
INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,150, 225);
INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,155, 230);
INSERT INTO tblWorksOn
(WorkID, EmployeeID, LabID)
VALUES (WorkID_seq.NEXTVAL,160, 255);

-- Create view

CREATE OR REPLACE FORCE VIEW "EMPLOYEE_LABS_VW" ("EMPFNAME", "EMPLNAME", "LABORATORY") AS
SELECT
e.EmpFName,
e.EmpLName,
l.LabDescr AS Laboratory
FROM
tblEmployee e,
tblWorksOn w,
tblLab l
WHERE
e.EmployeeID = w.EmployeeID AND
l.LabID = w.LabID
ORDER BY e.EmpLName;

COMMIT;
