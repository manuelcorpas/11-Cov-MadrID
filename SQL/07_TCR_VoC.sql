USE `cov`;

DROP TABLE IF EXISTS `cov`.`27_07_TCR_VoC` ;

CREATE TABLE IF NOT EXISTS `cov`.`27_07_TCR_VoC` (
    `ID_27_07_TCR_VoC` INT NOT NULL AUTO_INCREMENT,
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

DROP TABLE IF EXISTS `cov`.`28_07_Phenotypes` ; 

CREATE TABLE IF NOT EXISTS `cov`.`28_07_Phenotypes` ( 
    `ID_28_07_Phenotypes` INT NOT NULL AUTO_INCREMENT,
    `Sample_id`                     VARCHAR(10) NOT NULL,
    `ICU_Days`                      INT NOT NULL,
    `Age`                           INT NOT NULL,                          
    `Sex`                           VARCHAR(10) NOT NULL,
    `Country_origin`                VARCHAR(30) NOT NULL,
    `Pneumonia`                     CHAR(3) NOT NULL,
    `ARDS`                          CHAR(3) NOT NULL,
    `ARDS_N_ICU`                    CHAR(3) NOT NULL,
    `Skin_exanthema`                CHAR(3) NOT NULL,
    `Heart_myocarditis`             CHAR(3) NOT NULL,
    `Heart_arrhythmia`              CHAR(3) NOT NULL,
    `Liver_hepatitis`               CHAR(3) NOT NULL,
    `Kidney_glomerulonephritis`     CHAR(3) NOT NULL,
    `Kidney_tubulopathy`            CHAR(3) NOT NULL,
    `Neurological_encephalitis`     CHAR(3) NOT NULL,
    `Neurological_psychiatric`      CHAR(3) NOT NULL,
    `Neurological_polyneuropathy`   CHAR(3) NOT NULL,
    `Neurological_myelitis`         CHAR(3) NOT NULL,
    `Neurological_seizure`          CHAR(3) NOT NULL,
    `Gastrointestinal_diarrhea`     CHAR(3) NOT NULL,
    `Gastrointestinal_vomiting`     CHAR(3) NOT NULL,
    `Endocrine_dysfunction`         CHAR(3) NOT NULL,
    `Musculoskeletal_myopathy`      CHAR(3) NOT NULL,
    `Musculoskeletal_arthritis`     CHAR(3) NOT NULL,
    `Cytopenia`                     CHAR(3) NOT NULL,
    `Pulmonary_embolism`            CHAR(3) NOT NULL,
    `Deep_thrombosis`               CHAR(3) NOT NULL,
    `Peripheral_thrombosis`         CHAR(3) NOT NULL,
    `Stroke`                        CHAR(3) NOT NULL,
    `Ischemic_heart`                CHAR(3) NOT NULL,
    `Intravascular_coagulation`     CHAR(3) NOT NULL,
    `Persistent_fever`              CHAR(3) NOT NULL,
    `Fatigue_malaise`               CHAR(3) NOT NULL,
    PRIMARY KEY (`ID_28_07_Phenotypes`),
    INDEX (`Sample_id`)
)
ENGINE = MyISAM;
