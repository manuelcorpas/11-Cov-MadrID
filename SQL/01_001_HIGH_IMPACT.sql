
CREATE SCHEMA IF NOT EXISTS `cov` DEFAULT CHARACTER SET utf8 ;
USE `cov`;

DROP TABLE IF EXISTS `cov`.`01_001_HIGH_IMPACT` ;

CREATE TABLE IF NOT EXISTS `cov`.`01_001_HIGH_IMPACT` (
    `ID_01_001_HIGH_IMPACT` INT(11) NOT NULL AUTO_INCREMENT,
    `ID_Sample` VARCHAR(255) NOT NULL,
    `Patient`  INT(1) NOT NULL,
    `Uploaded_variation` TEXT,
    `Location`        TEXT,   
    `Allele`          TEXT,
    `Consequence`     TEXT,
    `IMPACT`          TEXT,
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
    `FREQS`           TEXT,
    `CLIN_SIG`        TEXT,
    `SOMATIC`         TEXT,
    `PHENO`           TEXT,
    `MOTIF_NAME`      TEXT,
    `MOTIF_POS`       TEXT,
    `HIGH_INF_POS`    TEXT,
    `MOTIF_SCORE_CHANGE`  TEXT,
    `TRANSCRIPTION_FACTORS`   TEXT,
    `CADD_PHRED`      TEXT,
    `CADD_RAW`        TEXT,
    `Condel`          TEXT,
    `MPC`             TEXT,
    `LoFtool`         TEXT,
    PRIMARY KEY (`ID_01_001_HIGH_IMPACT`)
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`01_001_UPLOAD_ERR` ;

CREATE TABLE IF NOT EXISTS `cov`.`01_001_UPLOAD_ERR` (
	`ID_01_001_UPLOAD_ERR` INT(11) NOT NULL AUTO_INCREMENT,
 	`ID_Sample` VARCHAR(255) NOT NULL,
    `Patient`  INT(1) NOT NULL,
 	`String` TEXT,
	PRIMARY KEY (`ID_01_001_UPLOAD_ERR`)
)
ENGINE = MyISAM;

DROP TABLE IF EXISTS `cov`.`01_001_PATIENTS_PER_GENE`;

CREATE TABLE IF NOT EXISTS `cov`.`01_001_PATIENTS_PER_GENE` (
    `ID_01_001_PATIENTS_PER_GENE` INT(11) NOT NULL AUTO_INCREMENT,
    `gene_name` VARCHAR(255) NOT NULL,
    `patient_count` INT(11) NOT NULL,
    `control_count` INT(11) NOT NULL,
    PRIMARY KEY (`ID_01_001_PATIENTS_PER_GENE`)
)                                                                                                                                                           
 ENGINE = MyISAM;


