import vcf
import MySQLdb
import glob, os
from pathlib import Path
import subprocess
import re

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor(MySQLdb.cursors.DictCursor)


sql1 = "INSERT INTO 24_06_MERGED(Sample,RSID,Chromosome,Chr_start,Chr_end,RiskAllele,RAF,OddsR,REF,ALT,ZYG,Allele1,Allele2,RiskAlleleCount) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}')"

os.chdir("/Users/superintelligent2/CoV-MadrID.icloud/DATA/MERGED/VCF/CoV-MadrID/CONCAT")

sql2 = "SELECT Chromosome,Chr_start,Chr_end,RSID,REF,ALT,RiskAllele,RAF,OddsR FROM 21_06_LEAD_VARS"
cursor.execute(sql2)
results = cursor.fetchall()


with open('/Users/superintelligent2/CoV-MadrID.icloud/DATA/SAMPLES/98_samples.txt') as file:
    SAMPLES_98 = [line.rstrip() for line in file]

for result in results:
    Chromosome  = result['Chromosome']
    Chr_start   = result['Chr_start']
    Chr_end     = result['Chr_end']
    RSID        = result['RSID']
    REF         = result['REF']
    ALT         = result['ALT']
    RiskAllele  = result['RiskAllele']
    RAF         = result['RAF']
    OddsR       = result['OddsR']
    Coord       = str('chr'+Chromosome+':'+str(Chr_start)+'-'+str(Chr_end))
    for file in glob.glob("AR*.vcf.gz"):
        myfile     = Path(file).stem
        Sample     = myfile.split(".")[0]
        if not Sample in SAMPLES_98:
            continue
        cmd        = str("tabix "+file+" "+Coord)
        vcf_line   = subprocess.check_output(cmd,shell=True).decode("utf-8").strip()
        if not vcf_line:
            out = [Sample,RSID,Chromosome,Chr_start,Chr_end,RiskAllele,RAF,OddsR,REF,ALT,'N/A','-','-',0]
            print(out)
            cursor.execute(sql1.format(*out))
            continue
        vcf_fields = vcf_line.split("\t")
        REFvcf     = vcf_fields[3]
        ALTvcf     = vcf_fields[4]
        REFALTvcf  = [REFvcf]+ALTvcf.split(",")
        Alleles    = [REF]+[ALT]
        GT         = vcf_fields[-1].split(":")
        ZYG        = GT[0].split("/")
        Allele1    = Alleles[int(ZYG.pop(0))]
        Allele2    = Alleles[int(ZYG.pop(0))]
        RiskAlleleCount = 0
        if Allele1 == RiskAllele:
            RiskAlleleCount +=1
        if Allele2 == RiskAllele:
            RiskAlleleCount +=1

        out = [Sample,RSID,Chromosome,Chr_start,Chr_end,RiskAllele,RAF,OddsR,REF,ALT,GT[0],Allele1,Allele2,RiskAlleleCount]
        print(out)
        cursor.execute(sql1.format(*out))


