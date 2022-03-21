import vcf
import MySQLdb
import re
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql1 = "INSERT INTO 14_04_PATIENT_VARIANT(Chromosome,Chr_Position,ID_Sample,REF,ALT,ZYG,GT_Bases) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}')"

os.chdir("/Users/superintelligent2/CoV-MadrID.icloud/DATA/MERGED/VCF/1000G/CONCAT/")

chromosomes = ["chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10",
               "chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20",
               "chr21","chr22","chrX","chrY","chrM"]

for file in glob.glob("*.vcf"):
    print (Path(file).stem)
    vcf_reader = vcf.Reader(open(file,'r'))
    for record in vcf_reader:
        if record.CHROM in chromosomes:
            for sample in record.samples:
                if sample['GT'] != './.':
                    #print (record.CHROM[3:],record.POS,sample.sample,sample.gt_bases)
                    cursor.execute(sql1.format(record.CHROM[3:],record.POS,sample.sample,record.REF,record.ALT,sample['GT'],sample.gt_bases))

