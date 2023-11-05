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
  `person-type` VARCHAR(45) NOT NULL,
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
	
-- Section table
INSERT INTO section (section_num, capacity, course_id, term_id)
VALUES
		(1, 30, 'CIT 111', 'Fall')
        (1, 50, 'ECON 150', 'Fall')
        (2, 50, 'ECON 150', 'Fall')
        (1, 35, 'ECON 388', 'Fall')
        (1, 30, 'HUM 376', 'Fall')
        (2, 30, 'CIT 111', 'Winter')
        (3, 35, 'CIT 111', 'Winter')
        (1, 50, 'ECON 150', 'Winter')
        (2, 50, 'ECON 150', 'Winter')
        (1, 30, 'JUM 376', 'Winter')
        

-- Term table
INSERT INTO term (term_name, term_year)
VALUES

-- Enrollment table
INSERT INTO enrollment (section_id, person_id, department_id, person_type)
VALUES  
-- 24 values

-- Person table
INSERT INTO person (first_name, last_name, gender, city, state, birthdate)
VALUES 
		-- Instructors
	   ('Marty', 'Morring'),
       ('Nate', 'Norris'),
       ('Ben', 'Barrus'),
       ('John', 'Jensen'),
       ('Bill', 'Barney'),
       -- Students
       ('Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
       ('Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
       ('Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
       ('Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
       ('Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
       ('Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
       ('Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
       ('Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09'),
       -- TAs
       ('Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
       ('Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22');
       
       

SELECT * FROM college;
SELECT * FROM department;
SELECT * FROM course;
SELECT * FROM section;
SELECT * FROM enrollment;