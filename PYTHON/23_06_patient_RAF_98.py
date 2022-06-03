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


sql1 = "INSERT INTO 23_07_PATIENT_RAF(RSID,Chromosome,Chr_start,Chr_end,RiskAllele,RAF,OddsR,Patient_RAF) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')"

os.chdir("/Users/superintelligent2/CoV-MadrID.icloud/DATA/CoV-MadrID/VCF/gVCF")

sql2 = "SELECT Chromosome,Chr_start,Chr_end,RSID,RiskAllele,RAF,OddsR,RiskAlleleCount FROM 22_06_PATIENT_VARIANT"
cursor.execute(sql2)
results = cursor.fetchall()

SNP  = {}
Total_alleles     = {}
Total_riskAlleles = {}

for result in results:
    Chromosome      = result['Chromosome']
    Chr_start       = result['Chr_start']
    Chr_end         = result['Chr_end']
    RSID            = result['RSID']
    RiskAllele      = result['RiskAllele']
    RAF             = result['RAF']
    OddsR           = result['OddsR']
    RiskAlleleCount = result['RiskAlleleCount']
    Total_alleles[RSID]     = Total_alleles.get(RSID,0)+2
    Total_riskAlleles[RSID] = Total_riskAlleles.get(RSID,0)+RiskAlleleCount
    SNP[RSID] = [RSID,Chromosome,Chr_start,Chr_end,RiskAllele,RAF,OddsR]

for snp in SNP:
    freq = Total_riskAlleles[snp]/Total_alleles[snp]
    print(*SNP[snp],Total_alleles[snp],Total_riskAlleles[snp],freq)
#cursor.execute(sql1.format(*out))


