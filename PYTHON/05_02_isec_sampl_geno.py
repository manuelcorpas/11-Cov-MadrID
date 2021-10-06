import vcf
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()


#sql2 = "INSERT INTO 02_UPLOAD_ERR(ID_Sample,String) VALUES('{0}','{1}')"

os.chdir("/Users/superintelligent2/CoV-MadrID.icloud/DATA/MERGED/VCF/ALL/ISEC-DB-INPUT-CHR/")

for file in glob.glob("*.vcf"):
    print (Path(file).stem)
    vcf_reader = vcf.Reader(open(file,'r'))
    for record in vcf_reader:
        for sample in record.samples:
            if sample['GT'] != './.':
                print("{}\t{}\t{}\t{}".format(record.CHROM,record.POS,sample.sample,sample['GT']))

