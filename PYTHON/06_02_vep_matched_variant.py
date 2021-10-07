import vcf
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()


sql1 = "SELECT p.ID_Sample,p.Chromosome,i.Chr_Start,i.Chr_End,p.REF,p.ALT,p.ZYG,p.GT_Bases,i.Allele,i.Consequence,i.IMPACT,i.SYMBOL FROM 02_PATIENT_VARIANT as p,02_ISEC_ALL_VAR_CONSEQ as i WHERE i.Chromosome = p.Chromosome AND i.Chr_Start = p.Chr_Position AND i.IMPACT = 'HIGH' AND i.Chromosome = 'X';"

sql2 = "INSERT INTO 02_HIGH_IMPACT_VARIANT(ID_Sample,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,GT_Bases,Allele,Consequence,IMPACT,SYMBOL) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}')"

cursor.execute(sql1)
results = cursor.fetchall()

for result in results:
    print(result)
