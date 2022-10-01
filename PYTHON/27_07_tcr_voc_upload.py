import csv
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql1 = "INSERT INTO 27_07_TCR_VoC(GENE,RSID,Chromosome,Chr_Start,Chr_End,REF,ALT,Consequence,CADD_PHRED,Case_MAF,Control_MAF,PValue,gnomAD_NFE_AF) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}')"


os.chdir("/Users/superintelligent2/CloudDocs/CoV-MadrID/CODE/11-Cov-MadrID/INPUT/CSV")

for file in glob.glob("*.csv"):
    print (Path(file).stem)
    with open(file,encoding = "ISO-8859-1") as f:
        reader = csv.reader(f,delimiter=",")
        next(reader, None)
        for row in reader:
            if len(row) == 13:
                print(row)
                if row[0] != '':
                    cursor.execute(sql1.format(*row))
            else:
                print("error: "+row)


