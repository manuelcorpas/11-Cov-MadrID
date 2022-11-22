import MySQLdb
import glob, os
from pathlib import Path
import sys
from sys import exit

# CAUTION: This depends on TABLES 25_05_TCR_HIGH_IMPACT_VARIANT and 27_07_TCR_VoC


db = MySQLdb.connect(db='cov',read_default_file='~/.my.cnf')
cursor = db.cursor(MySQLdb.cursors.DictCursor)

SQL_TCR_genes = {'TRBV5-5':'TRBV5_5','TRBV6-5':'TRBV6_5','TRBV7-3':'TRBV7_3','TRBV7-6':'TRBV7_6','TRBV7-7':'TRBV7_7','TRBV7-8':'TRBV7_8','TRBV10-1':'TRBV10_1','TRBV30':'TRBV30'}
SQL_TCR_RSIDs = []
TCR_genes = ['TRBV5-5','TRBV6-5','TRBV7-3','TRBV7-6','TRBV7-7','TRBV7-8','TRBV10-1','TRBV30']
ES_74     = ['AR5440','AR5443','AR5444','AR5445','AR5446','AR5447','AR5448','AR5449','AR5450','AR5451','AR5452','AR5454','AR5455','AR5457','AR5458',
             'AR5459','AR5460','AR5461','AR5462','AR5463','AR5464','AR5465','AR5466','AR5467','AR5468','AR5469','AR5470','AR5472','AR5473','AR5474',
             'AR5475','AR5476','AR5477','AR5478','AR5481','AR5484','AR5485','AR5486','AR5487','AR5488','AR5490','AR5492','AR5493','AR5495','AR5496',
             'AR5497','AR5499','AR5500','AR5501','AR5502','AR5503','AR5506','AR5507','AR5508','AR5510','AR5511','AR5512','AR5513','AR5514','AR5516',
             'AR5517','AR5518','AR5520','AR5521','AR5522','AR5524','AR5526','AR5527','AR5530','AR5533','AR5535','AR5536','AR5538','AR5539']

sql1 = "SELECT ID_Sample,Existing_variation,ZYG FROM 25_05_TCR_HIGH_IMPACT_VARIANT WHERE SYMBOL = '{0}' and Patient = 1;"

sql2 = "INSERT INTO 30_05_TCR_HIGH_IMPACT_COUNT(PATIENT,TRBV5_5,TRBV6_5,TRBV7_3,TRBV7_6,TRBV7_7,TRBV7_8,TRBV10_1,TRBV30) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}')"

sql3 = "SELECT RSID FROM 27_07_TCR_VoC;"

cursor.execute(sql3)
results = cursor.fetchall()
for RSID in results:
    SQL_TCR_RSIDs.append(RSID['RSID'])

print(SQL_TCR_RSIDs)


Total_case_alleles    = 148
Total_control_alleles = 186

g={}

for gene in TCR_genes:
    cursor.execute(sql1.format(gene))
    results = cursor.fetchall()
    g[gene] = {}

    for patient in ES_74:
        g[gene][patient] = 0


    for result in results:
        ID_Sample        = result['ID_Sample']
        RSID             = result['Existing_variation']
        ZYG              = result['ZYG']

        if RSID in SQL_TCR_RSIDs:
            ALT_alleles         = ZYG.split("/")
            ALT_alleles         = list(map(int,ALT_alleles))
            ALT_allele_count    = sum(ALT_alleles)
            g[gene][ID_Sample] += ALT_allele_count


for patient in ES_74:
    patient_row = {}

    for gene in g:
        SQL_TCR_gene =  ''
        if gene in SQL_TCR_genes:
            SQL_TCR_gene =  SQL_TCR_genes[gene]
        patient_row[SQL_TCR_gene]=g[gene][patient]

    print(patient,*patient_row.values())
    cursor.execute(sql2.format(patient,*patient_row.values()))
