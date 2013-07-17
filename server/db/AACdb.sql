SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `aacdb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `aacdb` ;

-- -----------------------------------------------------
-- Table `aacdb`.`members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aacdb`.`members` ;

CREATE  TABLE IF NOT EXISTS `aacdb`.`members` (
  `idmembers` INT NOT NULL ,
  `familyname` VARCHAR(120) NULL ,
  `firstname` VARCHAR(200) NULL ,
  PRIMARY KEY (`idmembers`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`swipercards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aacdb`.`swipercards` ;

CREATE  TABLE IF NOT EXISTS `aacdb`.`swipercards` (
  `idswipercards` INT NOT NULL AUTO_INCREMENT ,
  `serial` VARCHAR(15) NULL ,
  PRIMARY KEY (`idswipercards`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`possess`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aacdb`.`possess` ;

CREATE  TABLE IF NOT EXISTS `aacdb`.`possess` (
  `idpossess` INT NOT NULL AUTO_INCREMENT ,
  `member` INT NULL ,
  `swipercard` INT NULL ,
  `validityBegin` DATE NULL ,
  `validityEnd` DATE NULL ,
  PRIMARY KEY (`idpossess`) ,
  INDEX `fk_possess_1` (`member` ASC) ,
  INDEX `fk_possess_2` (`swipercard` ASC) ,
  CONSTRAINT `fk_possess_1`
    FOREIGN KEY (`member` )
    REFERENCES `aacdb`.`members` (`idmembers` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_possess_2`
    FOREIGN KEY (`swipercard` )
    REFERENCES `aacdb`.`swipercards` (`idswipercards` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`sensors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aacdb`.`sensors` ;

CREATE  TABLE IF NOT EXISTS `aacdb`.`sensors` (
  `idsensors` INT NOT NULL AUTO_INCREMENT ,
  `ipaddress` VARCHAR(15) NULL ,
  `location` VARCHAR(200) NULL ,
  PRIMARY KEY (`idsensors`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`rules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aacdb`.`rules` ;

CREATE  TABLE IF NOT EXISTS `aacdb`.`rules` (
  `idrules` INT NOT NULL AUTO_INCREMENT ,
  `dtstart` DATETIME NULL ,
  `dtend` DATETIME NULL ,
  PRIMARY KEY (`idrules`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aacdb`.`permissions` ;

CREATE  TABLE IF NOT EXISTS `aacdb`.`permissions` (
  `idpermissions` INT NOT NULL AUTO_INCREMENT ,
  `possess` INT NULL ,
  `sensor` INT NULL ,
  `rule` INT NULL ,
  PRIMARY KEY (`idpermissions`) ,
  INDEX `fk_permissions_1` (`possess` ASC) ,
  INDEX `fk_permissions_2` (`rule` ASC) ,
  INDEX `fk_permissions_3` (`sensor` ASC) ,
  CONSTRAINT `fk_permissions_1`
    FOREIGN KEY (`possess` )
    REFERENCES `aacdb`.`possess` (`idpossess` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissions_2`
    FOREIGN KEY (`rule` )
    REFERENCES `aacdb`.`rules` (`idrules` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissions_3`
    FOREIGN KEY (`sensor` )
    REFERENCES `aacdb`.`sensors` (`idsensors` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Placeholder table for view `aacdb`.`active_members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aacdb`.`active_members` (`idpossess` INT, `firstname` INT, `familyname` INT, `serial` INT, `validityBegin` INT, `validityEnd` INT);

-- -----------------------------------------------------
-- Placeholder table for view `aacdb`.`active_rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aacdb`.`active_rules` (`firstname` INT, `familyname` INT, `serial` INT, `ipaddress` INT, `location` INT, `dtstart` INT, `dtend` INT);

-- -----------------------------------------------------
-- View `aacdb`.`active_members`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `aacdb`.`active_members` ;
DROP TABLE IF EXISTS `aacdb`.`active_members`;
USE `aacdb`;
CREATE  OR REPLACE VIEW `aacdb`.`active_members` AS
    SELECT idpossess, firstname, familyname, serial, validityBegin, validityEnd 
    FROM members, possess, swipercards
    WHERE members.idmembers=possess.member 
        AND swipercards.idswipercards=possess.swipercard
        AND validityBegin<=NOW()
        AND validityEnd>=NOW();

-- -----------------------------------------------------
-- View `aacdb`.`active_rules`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `aacdb`.`active_rules` ;
DROP TABLE IF EXISTS `aacdb`.`active_rules`;
USE `aacdb`;
CREATE  OR REPLACE VIEW `aacdb`.`active_rules` AS
SELECT firstname, familyname, serial, ipaddress, location, dtstart, dtend 
    FROM active_members, permissions, sensors, rules
    WHERE active_members.idpossess=permissions.possess
        AND sensors.idsensors=permissions.sensor
        AND rules.idrules=permissions.rule;

CREATE USER `aac` IDENTIFIED BY '###epitech###';

grant ALL on TABLE `aacdb`.`members` to aac;
grant ALL on TABLE `aacdb`.`permissions` to aac;
grant ALL on TABLE `aacdb`.`possess` to aac;
grant ALL on TABLE `aacdb`.`rules` to aac;
grant ALL on TABLE `aacdb`.`sensors` to aac;
grant ALL on TABLE `aacdb`.`swipercards` to aac;
grant ALL on TABLE `aacdb`.`active_members` to aac;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
