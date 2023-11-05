-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`college_id`),
  UNIQUE INDEX `college_name_UNIQUE` (`college_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(50) NOT NULL,
  `department_code` VARCHAR(10) NOT NULL,
  `college_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `department_name_UNIQUE` (`department_name` ASC) VISIBLE,
  UNIQUE INDEX `department_code_UNIQUE` (`department_code` ASC) VISIBLE,
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NOT NULL,
  `course_code` VARCHAR(45) NOT NULL,
  `credit` INT(1) NOT NULL,
  `department_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_name` VARCHAR(6) NOT NULL,
  `term_year` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_num` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  `course_id` INT UNSIGNED NOT NULL,
  `term_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`person` ;

CREATE TABLE IF NOT EXISTS `university`.`person` (
  `person_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` CHAR(2) NULL,
  `birthdate` DATE NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `section_id` INT UNSIGNED NOT NULL,
  `person_id` INT UNSIGNED NOT NULL,
  `person_type` VARCHAR(45) NOT NULL,
  `department_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`section_id`, `person_id`),
  INDEX `fk_section_person_person1_idx` (`person_id` ASC) VISIBLE,
  INDEX `fk_section_person_section_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_enrollment_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_person_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_person_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `university`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use university;


-- College table
INSERT INTO college (college_name)
VALUES
		('College of Physical Science and Engineering'),
		('College of Business and Communication'),
		('College of Language and Letters');

-- Department table
INSERT INTO department (department_name, department_code, college_id)
VALUES
		('Computer Information Technology', 'CIT', 1),
		('Economics', 'ECON', 2),
		('Humanities and Philosophy', 'HUM', 3);


-- Course table
INSERT INTO course (course_name, course_code, credit, department_id)
VALUES
		('Intro to Databases', '111', 3, 1),
		('Micro Economics', '150', 3, 2),
		('Econometrics', '388', 4, 2),
		('Classical Heritage', '376', 2, 3);

-- Term table
INSERT INTO term (term_id, term_name, term_year)
VALUES
		(1, 'Fall', '2024'),
		(2, 'Winter', '2025');
        
-- Section table
INSERT INTO section (section_id, section_num, capacity, course_id, term_id)
VALUES
		(1, 1, 30, 1, 1),
        (2, 1, 50, 2, 1),
        (3, 2, 50, 2, 1),
        (4, 1, 35, 2, 1),
        (5, 1, 30, 3, 1),
        (6, 2, 30, 1, 2),
        (7, 3, 35, 1, 2),
        (8, 1, 50, 2, 2),
        (9, 2, 50, 2, 2),
        (10, 1, 30, 3, 2);

-- Enrollment table
INSERT INTO enrollment (section_id, person_id, person_type, department_id)
VALUES  
		(1, 1, 'student', 1),
		(2, 2, 'student', 2),
		(3, 3, 'student', 1),
		(4, 4, 'student', 2),
		(5, 5, 'student', 3),
		(6, 6, 'student', 1),
		(7, 7, 'student', 2),
		(8, 8, 'student', 1),
		(9, 9, 'student', 2),
		(10, 10, 'student', 3);

-- Person table
INSERT INTO person (first_name, last_name, gender, city, state, birthdate)
VALUES 
		-- Instructors
	   (1, 'Marty', 'Morring', NULL, NULL, NULL, NULL),
       (2, 'Nate', 'Norris', NULL, NULL, NULL, NULL),
       (3, 'Ben', 'Barrus', NULL, NULL, NULL, NULL),
       (4, 'John', 'Jensen', NULL, NULL, NULL, NULL),
       (5, 'Bill', 'Barney', NULL, NULL, NULL, NULL),
       -- Students
       (6, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
       (7, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
       (8, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
       (9, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
       (10, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
       (11, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
       (12, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
       (13, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09'),
       -- TAs
       (14, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
       (15, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22');
       

SELECT * FROM college;
SELECT * FROM department;
SELECT * FROM course;
SELECT * FROM term;
SELECT * FROM section;
SELECT * FROM enrollment;
SELECT * FROM person;





use university;

-- Query 1
SELECT p.first_name, p.last_name, DATE_FORMAT(p.Birthdate, '%M %e, %Y') AS 'Sept Birthdays'
FROM person p
WHERE MONTH(p.Birthdate) = 9
ORDER BY p.last_name;


-- Query 2
SELECT p.last_name, p.first_name, 
       FLOOR(DATEDIFF('2017-01-05', p.Birthdate) / 365) AS Years, 
       DATEDIFF('2017-01-05', p.Birthdate) % 365 AS Days,
       CONCAT(FLOOR(DATEDIFF('2017-01-05', p.Birthdate) / 365), '-Yrs, ', DATEDIFF('2017-01-05', p.Birthdate) % 365, '-Days') AS 'Years and Days'
FROM person p
ORDER BY Years DESC, Days DESC;

-- Query 3
SELECT p.first_name, p.last_name
FROM person p
JOIN enrollment e ON p.Person_id = e.Person_id
JOIN course c ON e.Section_id = c.Course_id
WHERE c.Course_name = 'Classical Heritage'
ORDER BY p.last_name;

-- Query 4
SELECT p.first_name, p.last_name, 'TA' AS person_type, c.Course_name
FROM person p
JOIN enrollment e ON p.Person_id = e.Person_id
JOIN course c ON e.Section_id = c.Course_id
WHERE e.Person_type = 'TA';

-- Query 5
SELECT p.first_name, p.last_name
FROM person p
JOIN enrollment e ON p.Person_id = e.Person_id
JOIN section s ON e.Section_id = s.Section_id
JOIN term t ON s.Term_id = t.Term_id
JOIN course c ON s.Course_id = c.Course_id
WHERE c.Course_name = 'Econometrics' AND t.Term_name = 'Fall' AND t.Term_year = '2024'
ORDER BY p.last_name;

-- Query 6
SELECT c.Course_name
FROM person p
JOIN enrollment e ON p.Person_id = e.Person_id
JOIN section s ON e.Section_id = s.Section_id
JOIN term t ON s.Term_id = t.Term_id
JOIN course c ON s.Course_id = c.Course_id
WHERE p.first_name = 'Bryce' AND p.last_name = 'Carlson' AND t.Term_name = 'Winter'
ORDER BY c.Course_name;

-- Query 7
SELECT t.Term_name, t.Term_year, COUNT(DISTINCT e.Person_id) AS 'Number of students enrolled for Fall 2024'
FROM enrollment e
JOIN section s ON e.Section_id = s.Section_id
JOIN term t ON s.Term_id = t.Term_id
WHERE t.Term_name = 'Fall' AND t.Term_year = '2024';

-- Query 8
SELECT c.College_name, COUNT(DISTINCT co.Course_id) AS 'Courses'
FROM college c
JOIN department d ON c.College_id = d.College_id
JOIN course co ON d.Department_id = co.Department_id
GROUP BY c.College_id
ORDER BY c.College_name;

-- Query 9
SELECT p.first_name, p.last_name, SUM(s.Capacity) AS 'TeachingCapacity'
FROM person p
JOIN enrollment e ON p.Person_id = e.Person_id
JOIN section s ON e.Section_id = s.Section_id
JOIN term t ON s.Term_id = t.Term_id
WHERE t.Term_name = 'Winter' AND t.Term_year = '2025'
GROUP BY p.Person_id
ORDER BY SUM(s.Capacity);

-- Query 10
SELECT p.first_name, p.last_name, SUM(c.Credit) AS 'Credits'
FROM person p
JOIN enrollment e ON p.Person_id = e.Person_id
JOIN section s ON e.Section_id = s.Section_id
JOIN term t ON s.Term_id = t.Term_id
JOIN course c ON s.Course_id = c.Course_id
WHERE t.Term_name = 'Fall' AND t.Term_year = '2024'
GROUP BY p.Person_id
HAVING SUM(c.Credit) > 3
ORDER BY SUM(c.Credit) DESC;
