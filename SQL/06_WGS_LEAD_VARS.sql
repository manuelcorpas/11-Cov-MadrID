USE `cov`;

DROP TABLE IF EXISTS `cov`.`21_06_LEAD_VARS` ;

CREATE TABLE IF NOT EXISTS `cov`.`21_06_LEAD_VARS` (
    `ID_21_06_LEAD_VARS` INT(11) NOT NULL AUTO_INCREMENT,
    `Chromosome` VARCHAR(5) NOT NULL,
    `Position`   INT(25) NOT NULL,
    `RSID`       VARCHAR(25) NOT NULL,
    `RiskAllele` TEXT NOT NULL,
    `RAF`        FLOAT(25),
    `OddsR`         FLOAT(10),
    PRIMARY KEY (`ID_21_06_LEAD_VARS`),
    INDEX (`Chromosome`,`Position`)
)
ENGINE = MyISAM;

                                                      
