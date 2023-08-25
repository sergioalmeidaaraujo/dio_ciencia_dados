-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE `oficina` ;

-- -----------------------------------------------------
-- Table `oficina`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `cpf_cnpj` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(255) NULL,
  `endereco` VARCHAR(255) NULL,
  PRIMARY KEY (`idClientes`),
  UNIQUE INDEX `cpf_cnpj_UNIQUE` (`cpf_cnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`veiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`veiculos` (
  `idveiculos` INT NOT NULL,
  `marca` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  `placa` VARCHAR(8) NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idveiculos`),
  INDEX `fk_veiculos_Clientes_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_veiculos_Clientes`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `oficina`.`Clientes` (`idClientes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`ordemServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`ordemServico` (
  `idordemServico` INT NOT NULL,
  `veiculos_idveiculos` INT NOT NULL,
  `data_chegada` DATETIME NULL,
  `kmchegada` INT NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idordemServico`),
  INDEX `fk_ordemServico_veiculos1_idx` (`veiculos_idveiculos` ASC) VISIBLE,
  INDEX `fk_ordemServico_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_ordemServico_veiculos1`
    FOREIGN KEY (`veiculos_idveiculos`)
    REFERENCES `oficina`.`veiculos` (`idveiculos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordemServico_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `oficina`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`itensOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`itensOS` (
  `iditensOS` INT NOT NULL,
  `ordemServico_idordemServico` INT NOT NULL,
  `tipoItem` ENUM('PEÇA', 'SERVIÇO') NOT NULL,
  `descricaoItem` VARCHAR(45) NULL,
  `valorUnitario` FLOAT NULL,
  `quantidade` INT NULL,
  PRIMARY KEY (`iditensOS`),
  INDEX `fk_itensOS_ordemServico1_idx` (`ordemServico_idordemServico` ASC) VISIBLE,
  CONSTRAINT `fk_itensOS_ordemServico1`
    FOREIGN KEY (`ordemServico_idordemServico`)
    REFERENCES `oficina`.`ordemServico` (`idordemServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
