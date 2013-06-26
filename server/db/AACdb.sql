SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`membres`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`membres` (
  `idmembres` INT NOT NULL ,
  `FamilyName` VARCHAR(120) NULL ,
  `FirstName` VARCHAR(200) NULL ,
  PRIMARY KEY (`idmembres`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`swipercards`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`swipercards` (
  `idswipercards` INT NOT NULL ,
  `serial` INT NULL ,
  PRIMARY KEY (`idswipercards`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`possess`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`possess` (
  `idpossess` INT NOT NULL ,
  `member` INT NULL ,
  `swipercards` INT NULL ,
  `validityBegin` DATE NULL ,
  `validityEnd` DATE NULL ,
  PRIMARY KEY (`idpossess`) ,
  INDEX `fk_possess_1` (`member` ASC) ,
  INDEX `fk_possess_2` (`swipercards` ASC) ,
  CONSTRAINT `fk_possess_1`
    FOREIGN KEY (`member` )
    REFERENCES `mydb`.`membres` (`idmembres` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_possess_2`
    FOREIGN KEY (`swipercards` )
    REFERENCES `mydb`.`swipercards` (`idswipercards` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
