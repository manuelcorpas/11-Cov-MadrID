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

with open('/Users/superintelligent2/CoV-MadrID.icloud/DATA/SAMPLES/74_samples.txt') as file:
     SAMPLES_74 = [line.rstrip() for line in file]

sql2 = "SELECT Sample,Chromosome,Chr_start,Chr_end,RSID,RiskAllele,RAF,OddsR,RiskAlleleCount FROM 22_06_PATIENT_VARIANT"
cursor.execute(sql2)
results = cursor.fetchall()

SNP  = {}
Total_alleles     = {}
Total_riskAlleles = {}

for result in results:
    Sample          = result['Sample']
    Chromosome      = result['Chromosome']
    Chr_start       = result['Chr_start']
    Chr_end         = result['Chr_end']
    RSID            = result['RSID']
    RiskAllele      = result['RiskAllele']
    RAF             = result['RAF']
    OddsR           = result['OddsR']
    RiskAlleleCount = result['RiskAlleleCount']

    if Sample in SAMPLES_74:
        Total_alleles[RSID]     = Total_alleles.get(RSID,0)+2
        Total_riskAlleles[RSID] = Total_riskAlleles.get(RSID,0)+RiskAlleleCount
        SNP[RSID] = [RSID,Chromosome,Chr_start,Chr_end,RiskAllele,RAF,OddsR]

for snp in SNP:
    freq = Total_riskAlleles[snp]/Total_alleles[snp]
    print(*SNP[snp],Total_alleles[snp],Total_riskAlleles[snp],freq)
#cursor.execute(sql1.format(*out))


