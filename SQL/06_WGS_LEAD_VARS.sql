USE `cov`;

DROP TABLE IF EXISTS `cov`.`21_06_LEAD_VARS` ;

CREATE TABLE IF NOT EXISTS `cov`.`21_06_LEAD_VARS` (
    `ID_21_06_LEAD_VARS` INT(11) NOT NULL AUTO_INCREMENT,
    `Chromosome` VARCHAR(5) NOT NULL,
    `Chr_start`  INT(25) NOT NULL,
    `Chr_end`    INT(25) NOT NULL,
    `RSID`       VARCHAR(25) NOT NULL,
    `RiskAllele` TEXT NOT NULL,
    `REF`        TEXT NOT NULL,
    `ALT`        TEXT NOT NULL,
    `RAF`        FLOAT(25),
    `OddsR`      FLOAT(10),
    PRIMARY KEY (`ID_21_06_LEAD_VARS`),
    INDEX (`RSID`)
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`22_06_PATIENT_VARIANT`;

CREATE TABLE IF NOT EXISTS `cov`.`22_06_PATIENT_VARIANT` (
    `ID_22_06_PATIENT_VARIANT` INT NOT NULL AUTO_INCREMENT,
    `Sample`     VARCHAR(25) NOT NULL,
    `RSID`       VARCHAR(25) NOT NULL,
    `Chromosome` VARCHAR(5) NOT NULL,
    `Chr_start`  INT NOT NULL,
    `Chr_end`    INT NOT NULL,
    `RiskAllele` TEXT NOT NULL,
    `RAF`        FLOAT(25),
    `OddsR`      FLOAT(10),
    `REF`        TEXT,
    `ALT`        TEXT,
    `ZYG`        TEXT,
    `Allele1`    TEXT,
    `Allele2`    TEXT,
    `RiskAlleleCount` INT NOT NULL,
    PRIMARY KEY (`ID_22_06_PATIENT_VARIANT`),
INDEX(Chromosome,Sample,RSID,RiskAlleleCount)
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`23_06_PATIENT_RAF`;
CREATE TABLE IF NOT EXISTS `cov`.`23_06_PATIENT_RAF` (
    `ID_23_06_PATIENT_RAF` INT NOT NULL AUTO_INCREMENT,
    `RSID`       VARCHAR(25) NOT NULL,
    `Chromosome` VARCHAR(5) NOT NULL,
    `Chr_start`  INT NOT NULL,
    `Chr_end`    INT NOT NULL,
    `RiskAllele` TEXT NOT NULL,
    `RAF`        FLOAT(25),
    `OddsR`      FLOAT(10),
    `Patient_RAF` FLOAT(25),
    PRIMARY KEY (`ID_23_06_PATIENT_RAF`),
INDEX(Chromosome,RSID)
)
ENGINE = MyISAM; 




