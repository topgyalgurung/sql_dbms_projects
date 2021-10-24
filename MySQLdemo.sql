
-- storage engines are mysql components that handle sql operations for diff table types
-- innoDB is default and most general purpose storage engine
-- CREATE TABLE creates InnoDB by default
-- innodb has commit, rollback, crash recovery capabilities to protect user data
-- innodb stores user data in CLUSTERED index to reduce i/o for common queries based on primary keys
SHOW ENGINES;
USE bank;
CREATE TABLE student(

	student_id INT PRIMARY KEY AUTO_INCREMENT, 
	name varchar(20) NOT NULL,
	major varchar(20) DEFAULT 'undecided'
);
-- Use the smallest integer data type for the AUTO_INCREMENT column that is large enough to hold the maximum sequence value you need
-- SIGNED TINYINT(127), UNSIGNED LIMIT TINYINT(255), SMALLINT(65535)

-- CREATE TABLE animals(
-- 	id MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
-- 	name char(3) NOT NULL
-- );
-- INSERT INTO animals(name) VALUES 
-- 	('dog'),('cat'),('penguin');
    
-- DROP TABLE student;
DESC student;
ALTER TABLE student ADD gpa DECIMAL(3,2);
-- ALTER TABLE student DROP COLUMN gpa;
-- ALTER TABLE student ADD email VARCHAR(32) UNIQUE NOT NULL;

DESC student; -- or DESCRIBE

INSERT INTO student VALUES(1,'Topgyal','Computer Science',3.2);
SELECT * FROM student;
INSERT INTO student(name,major,gpa) VALUES ('Kate','Sociology',3.9);
INSERT INTO student(name,gpa) VALUES ('jack',2.7);
INSERT INTO student(name,major,gpa) VALUES ('Sam','Physics',3.12);
INSERT INTO student VALUES (NULL,'Top','Chem',3.4); -- NULL reset to 6 since auto_increment
SELECT LAST_INSERT_ID();

UPDATE student
SET major='Compsci'
WHERE major='Computer Science';
-- ERROR 1175 safe update mode
SET SQL_SAFE_UPDATES = 0; -- 1 to turn on
-- rerun update 

DELETE FROM student
WHERE student_id=5;

    