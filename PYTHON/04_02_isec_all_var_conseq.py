import csv
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql1 = "INSERT INTO 02_ISEC_ALL_VAR_CONSEQ(Uploaded_variation,Location,Allele,Consequence,IMPACT,SYMBOL,Gene,Feature_type,Feature,BIOTYPE,EXON,INTRON,HGVSc,HGVSp,cDNA_position,CDS_position,Protein_position,Amino_acids,Codons,Existing_variation,DISTANCE,STRAND,FLAGS,SYMBOL_SOURCE,HGNC_ID,SIFT,PolyPhen,AF,gnomAD_AF,gnomAD_AFR_AF,gnomAD_AMR_AF,gnomAD_ASJ_AF,gnomAD_EAS_AF,gnomAD_FIN_AF,gnomAD_NFE_AF,gnomAD_OTH_AF,gnomAD_SAS_AF,CLIN_SIG,SOMATIC,PHENO,MOTIF_NAME,MOTIF_POS,HIGH_INF_POS,MOTIF_SCORE_CHANGE,TRANSCRIPTION_FACTORS,Condel,MPC,CADD_PHRED,CADD_RAW,LoFtool) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}','{18}','{19}','{20}','{21}','{22}','{23}','{24}','{25}','{26}','{27}','{28}','{29}','{30}','{31}','{32}','{33}','{34}','{35}','{36}','{37}','{38}','{39}','{40}','{41}','{42}','{43}','{44}','{45}','{46}','{47}','{48}','{49}')"

sql2 = "INSERT INTO 02_UPLOAD_ERR(ID_Sample,String) VALUES('{0}','{1}')"


os.chdir("/Users/superintelligent2/CoV-MadrID.icloud/ANALYSIS/VEP/ALL-ISEC/1-CONSEQ-VARIANT")

for file in glob.glob("*.txt"):
    print (Path(file).stem)
    with open(file) as f:
        reader = csv.reader(f,delimiter="\t")
        next(reader, None)
        for row in reader:
            if len(row) == 50:
                cursor.execute(sql1.format(*row))
            else:
                string = ' '.join(row)
                new_row = [Path(file).stem,string]
                cursor.execute(sql2.format(*new_row))

