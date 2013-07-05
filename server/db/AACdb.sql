SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `aacdb`.`members`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `aacdb`.`members` (
  `idmembers` INT NOT NULL ,
  `familyname` VARCHAR(120) NULL ,
  `firstname` VARCHAR(200) NULL ,
  PRIMARY KEY (`idmembers`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`swipercards`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `aacdb`.`swipercards` (
  `idswipercards` INT NOT NULL AUTO_INCREMENT ,
  `serial` CHAR NULL ,
  PRIMARY KEY (`idswipercards`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`possess`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `aacdb`.`possess` (
  `idpossess` INT NOT NULL AUTO_INCREMENT ,
  `member` INT NULL ,
  `swipercards` INT NULL ,
  `validityBegin` DATE NULL ,
  `validityEnd` DATE NULL ,
  PRIMARY KEY (`idpossess`) ,
  INDEX `fk_possess_1` (`member` ASC) ,
  INDEX `fk_possess_2` (`swipercards` ASC) ,
  CONSTRAINT `fk_possess_1`
    FOREIGN KEY (`member` )
    REFERENCES `aacdb`.`members` (`idmembers` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_possess_2`
    FOREIGN KEY (`swipercards` )
    REFERENCES `aacdb`.`swipercards` (`idswipercards` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`sensors`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `aacdb`.`sensors` (
  `idsensors` INT NOT NULL AUTO_INCREMENT ,
  `ipaddress` VARCHAR(15) NULL ,
  `location` VARCHAR(200) NULL ,
  PRIMARY KEY (`idsensors`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`rules`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `aacdb`.`rules` (
  `idrules` INT NOT NULL AUTO_INCREMENT ,
  `dtstart` DATETIME NULL ,
  `dtend` DATETIME NULL ,
  PRIMARY KEY (`idrules`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aacdb`.`permissions`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `aacdb`.`permissions` (
  `idpermissions` INT NOT NULL AUTO_INCREMENT ,
  `possess` INT NULL ,
  `sensors` INT NULL ,
  `rules` INT NULL ,
  PRIMARY KEY (`idpermissions`) ,
  INDEX `fk_permissions_1` (`possess` ASC) ,
  INDEX `fk_permissions_2` (`rules` ASC) ,
  INDEX `fk_permissions_3` (`sensors` ASC) ,
  CONSTRAINT `fk_permissions_1`
    FOREIGN KEY (`possess` )
    REFERENCES `aacdb`.`possess` (`idpossess` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissions_2`
    FOREIGN KEY (`rules` )
    REFERENCES `aacdb`.`rules` (`idrules` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissions_3`
    FOREIGN KEY (`sensors` )
    REFERENCES `aacdb`.`sensors` (`idsensors` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
