USE `cov`;

DROP TABLE IF EXISTS `cov`.`27_07_TCR_VoC` ;

CREATE TABLE IF NOT EXISTS `cov`.`27_07_TCR_VoC` (
    `ID_27_07_TCR_VoC` INT(11) NOT NULL AUTO_INCREMENT,
    `Gene`            TEXT,
    `RSID`            VARCHAR(25) NOT NULL,
    `Chromosome`      VARCHAR(5) NOT NULL,
    `Chr_Start`       INT NOT NULL,
    `Chr_End`         INT NOT NULL,
    `REF`             TEXT,
    `ALT`             TEXT,
    `Consequence`     TEXT,
    `CADD_PHRED`      TEXT,
    `Case_MAF`        TEXT,
    `Control_MAF`     TEXT,
    `PValue`          TEXT,
    `gnomAD_NFE_AF`   TEXT,
    PRIMARY KEY (`ID_27_07_TCR_VoC`),
    INDEX (`RSID`)
)
ENGINE = MyISAM;

                                                      
