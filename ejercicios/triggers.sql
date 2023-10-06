drop database if exists ejTriggers;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ejTriggers
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ejTriggers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ejTriggers` DEFAULT CHARACTER SET utf8 ;
USE `ejTriggers` ;

-- -----------------------------------------------------
-- Table `ejTriggers`.`Libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejTriggers`.`Libro` (
  `idLibro` INT NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `fechaDePublicacion` DATE NULL,
  PRIMARY KEY (`idLibro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejTriggers`.`Biblioteca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejTriggers`.`Biblioteca` (
  `idBiblioteca` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`idBiblioteca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejTriggers`.`Biblioteca_has_Libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejTriggers`.`Biblioteca_has_Libro` (
  `idBiblioteca` INT NOT NULL,
  `idLibro` INT NOT NULL,
  PRIMARY KEY (`idBiblioteca`, `idLibro`),
  INDEX `fk_Biblioteca_has_Libro_Libro1_idx` (`idLibro` ASC) VISIBLE,
  INDEX `fk_Biblioteca_has_Libro_Biblioteca1_idx` (`idBiblioteca` ASC) VISIBLE,
  CONSTRAINT `fk_Biblioteca_has_Libro_Biblioteca1`
    FOREIGN KEY (`idBiblioteca`)
    REFERENCES `ejTriggers`.`Biblioteca` (`idBiblioteca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Biblioteca_has_Libro_Libro1`
    FOREIGN KEY (`idLibro`)
    REFERENCES `ejTriggers`.`Libro` (`idLibro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejTriggers`.`LibrosAudit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ejTriggers`.`LibrosAudit` (
  `idLibrosAudit` INT auto_increment NOT NULL,
  `tipoDeOperacion` VARCHAR(6) NULL,
  `lastDateModified` DATE NULL,
  `Libro_idLibro` INT NOT NULL,
  `tituloLibro` VARCHAR(45) NULL,
  `fechaDePublicacionLibro` DATE NULL,
  PRIMARY KEY (`idLibrosAudit`),
  INDEX `fk_LibrosAudit_Libro1_idx` (`Libro_idLibro` ASC) VISIBLE,
  CONSTRAINT `fk_LibrosAudit_Libro1`
    FOREIGN KEY (`Libro_idLibro`)
    REFERENCES `ejTriggers`.`Libro` (`idLibro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

delimiter //

create trigger registrarInserts
after insert on Libro
for each row
begin
	insert into LibrosAudit values
    ("insert", current_date(), new.idLibro, new.titulo, new.fechaDePublicacion);
end//

create trigger registrarActualizaciones
before update on Libro
for each row
begin
	insert into LibrosAudit values 
    ("update", current_date(), old.idLibro, old.titulo, old.fechaDePublicacion);
end//

create trigger registrarDeletes
before delete on Libro
for each row
begin
	insert into LibrosAudit values 
    ("delete", current_date(), old.idLibro, old.titulo, old.fechaDePublicacion);
end//

delimiter ; 