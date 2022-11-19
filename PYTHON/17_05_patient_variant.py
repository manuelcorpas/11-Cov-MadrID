import vcf
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(db='cov',read_default_file='~/.my.cnf')
cursor = db.cursor()


sql1 = "INSERT INTO 17_05_PATIENT_VARIANT(Chromosome,Chr_Position,ID_Sample,REF,ALT,ZYG,GT_Bases) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}')"

os.chdir("/Users/superintelligent2/CloudDocs/CoV-MadrID/DATA/FILTERED-EXOMES")


for file in glob.glob("*.vcf"):
    print (Path(file).stem)
    vcf_reader = vcf.Reader(open(file,'r'))
    for record in vcf_reader:
        for sample in record.samples:
            if sample['GT'] != './.':
                #print (record.CHROM[3:],record.POS,sample.sample,sample.gt_bases)
                cursor.execute(sql1.format(record.CHROM[3:],record.POS,sample.sample,record.REF,record.ALT,sample['GT'],sample.gt_bases))

