/*NORMALISATION*/
create database normalisationing;
use normalisationing;

create table student(
rollno int ,
name  varchar(30),
subject varchar(30)
);

insert into student(rollno,name,subject)values
(1,"karan","C++/SQL"),
(2,"nishant","C++"),
(3,"Sham","SQL");

insert into student(rollno,name,subject)values
(1,"nishant","C++"),
(1,"karan","SQL"),
(2,"RAM","C++"),
(3,"Sham","SQL");


/*
Second Normal Form (2NF)
*/

CREATE TABLE student (
    rollno INT,
    name VARCHAR(30),
    subject VARCHAR(30),
    PRIMARY KEY (rollno, subject)  
);

INSERT INTO student (rollno, name, subject) VALUES
(1, 'karan', 'C++'),
(1, 'nishant', 'SQL'),
(2, 'RAM', 'C++'),
(3, 'Sham', 'SQL');


CREATE TABLE emp (
    empid INT PRIMARY KEY,
    empname VARCHAR(50),
    deptid INT,
    deptname VARCHAR(50),
    managerid INT,
    managername VARCHAR(50)
);

CREATE TABLE employee (
    empid INT PRIMARY KEY,
    empname VARCHAR(50),
    deptid INT,
    managerid INT,
    FOREIGN KEY (deptid) REFERENCES dept(deptid),
    FOREIGN KEY (managerid) REFERENCES manager(managerid)
);
CREATE TABLE dept (
    deptid INT PRIMARY KEY,
    deptname VARCHAR(50)
);
CREATE TABLE manager (
    managerid INT PRIMARY KEY,
    managername VARCHAR(50)
);

CREATE TABLE student_subject_professor (
    stuid INT,
    subject VARCHAR(50),
    professor VARCHAR(50),
    PRIMARY KEY (stuid, subject)
);

INSERT INTO student_subject_professor (stuid, subject, professor) VALUES
(101, 'java', 'pj'),
(101, 'c++', 'pc'),
(102, 'java', 'pj2'),
(103, 'c', 'pc');

CREATE TABLE student_subject (
    stuid INT,
    pid INT,
    PRIMARY KEY (stuid, pid)
);

CREATE TABLE professor_subject (
    pid INT,
    professor VARCHAR(50),
    subject VARCHAR(50),
    PRIMARY KEY (pid)
);
INSERT INTO professor_subject (pid, professor, subject) VALUES
(1, 'pj', 'java'),
(2, 'pc', 'c++'),
(3, 'pj2', 'java'),
(4, 'pc', 'c');

INSERT INTO student_subject (stuid, pid) VALUES
(101, 1),
(101, 2),
(102, 3),
(103, 2);

CREATE TABLE name_project_hobby (
    name VARCHAR(50),
    project VARCHAR(50),
    hobby VARCHAR(50)
);

INSERT INTO name_project_hobby (name, project, hobby) VALUES
('TIM', 'MS', 'READ'),
('TIM', 'ORACLE', 'DANCE'),
('TIM', 'MS', 'DANCE'),
('TIM', 'ORACLE', 'READ');

CREATE TABLE name_project (
    name VARCHAR(50),
    project VARCHAR(50),
    PRIMARY KEY (name, project)
);

CREATE TABLE name_hobby (
    name VARCHAR(50),
    hobby VARCHAR(50),
    PRIMARY KEY (name, hobby)
);

INSERT INTO name_project (name, project) VALUES
('TIM', 'MS'),
('TIM', 'ORACLE');

INSERT INTO name_hobby (name, hobby) VALUES
('TIM', 'READ'),
('TIM', 'DANCE');