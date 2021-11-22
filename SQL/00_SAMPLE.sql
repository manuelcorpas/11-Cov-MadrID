
USE `cov`;

DROP TABLE IF EXISTS `cov`.`00_SAMPLE` ;

CREATE TABLE IF NOT EXISTS `cov`.`00_SAMPLE` (
    `ID_Sample` VARCHAR(15) NOT NULL,
    `Patient`   INT NOT NULL,
    `ICU`       INT NOT NULL,
    `Country`   VARCHAR(25) NOT NULL,
    `Code`      VARCHAR(5) NOT NULL,
    `Continent` VARCHAR(5) NOT NULL,
    PRIMARY KEY (`ID_Sample`),
    INDEX(Patient,Country,Code,Continent)
)
ENGINE = MyISAM;


