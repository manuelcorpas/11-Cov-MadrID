
USE `cov`;

DROP TABLE IF EXISTS `cov`.`16_05_FILTERED_ALL_VAR_CONSEQ` ;

CREATE TABLE IF NOT EXISTS `cov`.`16_05_FILTERED_ALL_VAR_CONSEQ` (
    `ID_16_05_FILTERED_ALL_VAR_CONSEQ` INT(11) NOT NULL AUTO_INCREMENT,
    `Uploaded_variation` TEXT,
    `Chromosome` VARCHAR(5) NOT NULL,
    `Chr_Start`  INT(25) NOT NULL,
    `Chr_End`    INT(25) NOT NULL,
    `Allele`          TEXT,
    `Consequence`     TEXT,
    `IMPACT`          VARCHAR(25) NOT NULL,
    `SYMBOL`          TEXT,
    `Gene`            TEXT,
    `Feature_type`    TEXT,   
    `Feature`         TEXT,
    `BIOTYPE`         TEXT,
    `EXON`            TEXT,
    `INTRON`          TEXT,
    `HGVSc`           TEXT,
    `HGVSp`           TEXT,
    `cDNA_position`   TEXT,   
    `CDS_position`    TEXT,
    `Protein_position` TEXT,
    `Amino_acids`     TEXT,
    `Codons`          TEXT,
    `Existing_variation` TEXT,
    `DISTANCE`        TEXT,
    `STRAND`          TEXT,
    `FLAGS`           TEXT,
    `SYMBOL_SOURCE`   TEXT,   
    `HGNC_ID`         TEXT, 
    `SIFT`            TEXT,
    `PolyPhen`        TEXT,
    `AF`              TEXT,
    `gnomAD_AF`       TEXT,   
    `gnomAD_AFR_AF`   TEXT, 
    `gnomAD_AMR_AF`   TEXT,
    `gnomAD_ASJ_AF`   TEXT,
    `gnomAD_EAS_AF`   TEXT,
    `gnomAD_FIN_AF`   TEXT,
    `gnomAD_NFE_AF`   TEXT, 
    `gnomAD_OTH_AF`   TEXT,
    `gnomAD_SAS_AF`   TEXT,
    `CLIN_SIG`        TEXT,
    `SOMATIC`         TEXT,
    `PHENO`           TEXT,
    `MOTIF_NAME`      TEXT,
    `MOTIF_POS`       TEXT,
    `HIGH_INF_POS`    TEXT,
    `MOTIF_SCORE_CHANGE`  TEXT,
    `TRANSCRIPTION_FACTORS`   TEXT,
    `Condel`          TEXT,
    `MPC`             TEXT,
    `CADD_PHRED`      TEXT,
    `CADD_RAW`        TEXT,
    `LoFtool`         TEXT,
    PRIMARY KEY (`ID_16_05_FILTERED_ALL_VAR_CONSEQ`),
    INDEX (`Chromosome`,`Chr_Start`,`Chr_End`,`IMPACT`)
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`16_05_UPLOAD_ERR` ;

CREATE TABLE IF NOT EXISTS `cov`.`16_05_UPLOAD_ERR` (
	`ID_16_05_UPLOAD_ERR` INT(11) NOT NULL AUTO_INCREMENT,
 	`ID_Sample` VARCHAR(25) NOT NULL,
    `String` TEXT,
	PRIMARY KEY (`ID_16_05_UPLOAD_ERR`)
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`17_05_PATIENT_VARIANT`;

CREATE TABLE IF NOT EXISTS `cov`.`17_05_PATIENT_VARIANT` (
    `ID_17_05_PATIENT_VARIANT` INT NOT NULL AUTO_INCREMENT,
    `Chromosome` VARCHAR(5) NOT NULL,
    `Chr_Position` INT NOT NULL,
    `ID_Sample` VARCHAR(25) NOT NULL,
    `REF` TEXT,
    `ALT` TEXT,
    `ZYG` TEXT,
    `GT_Bases` TEXT NOT NULL,
    PRIMARY KEY (`ID_17_05_PATIENT_VARIANT`),
    INDEX(Chromosome,Chr_Position,ID_Sample)
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`18_05_HIGH_IMPACT_VARIANT`;
CREATE TABLE IF NOT EXISTS `cov`.`18_05_HIGH_IMPACT_VARIANT` (
    `ID_18_05_HIGH_IMPACT_VARIANT` INT NOT NULL AUTO_INCREMENT,
    `ID_Sample` VARCHAR(25) NOT NULL,
    `Patient`    INT NOT NULL,
    `Code`       VARCHAR(5) NOT NULL,
    `Chromosome` VARCHAR(5) NOT NULL,
    `Chr_Start`    INT NOT NULL,
    `Chr_End`      INT NOT NULL,
    `REF` TEXT, 
    `ALT` TEXT,
    `ZYG` TEXT,
    `Consequence`     TEXT,
    `IMPACT`          VARCHAR(25) NOT NULL,
    `SYMBOL`          TEXT,
    `AF`              TEXT,                                                                                                                                  
    `gnomAD_AF`       TEXT, 
    PRIMARY KEY (`ID_18_05_HIGH_IMPACT_VARIANT`),
    INDEX(Chromosome,Chr_Start,IMPACT)
)
ENGINE = MyISAM;

-- chrY    3720516 HG01612 1/1

DROP TABLE IF EXISTS `cov`.`19_05_PATIENTS_PER_GENE`;

CREATE TABLE IF NOT EXISTS `cov`.`19_05_PATIENTS_PER_GENE` (  
    `ID_19_05_PATIENTS_PER_GENE` INT NOT NULL AUTO_INCREMENT,
    `SYMBOL`    VARCHAR(100) NOT NULL,
    `Case_cnt`  INT NOT NULL,
    `Control_cnt` INT NOT NULL,
    PRIMARY KEY (`ID_19_05_PATIENTS_PER_GENE`) 
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`20_05_PATIENTS_PER_GENE_AF_FILTER`;

CREATE TABLE IF NOT EXISTS `cov`.`20_05_PATIENTS_PER_GENE_AF_FILTER` ( 
    `ID_20_05_PATIENTS_PER_GENE_AF_FILTER` INT NOT NULL AUTO_INCREMENT,
    `SYMBOL`    VARCHAR(100) NOT NULL,  
    `Case_cnt`  INT NOT NULL,  
    `Control_cnt` INT NOT NULL,
    PRIMARY KEY (`ID_20_05_PATIENTS_PER_GENE_AF_FILTER`) 
)
ENGINE = MyISAM;

