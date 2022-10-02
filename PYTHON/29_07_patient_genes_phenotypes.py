import csv
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql  = "SELECT * FROM 28_07_Phenotypes WHERE Sample_id = '{0}'"
sql1 = "SELECT Existing_variation,ZYG,SYMBOL FROM 25_05_TCR_HIGH_IMPACT_VARIANT WHERE Patient =1 and ID_Sample = '{0}'"

with open ('/Users/superintelligent2/CloudDocs/CoV-MadrID/DATA/SAMPLES/74_samples.txt') as f:
    n = 0
    while True:
        line = f.readline()
        if not line or n ==3:
            break
        else:
            Patient_id = line.strip()
            print(line.strip())
            cursor.execute(sql.format(Patient_id))
            results = cursor.fetchall()
            print(results)
            cursor.execute(sql1.format(Patient_id))
            results = cursor.fetchall()
            print(results)
        n = n +1




'''
os.chdir("/Users/superintelligent2/CloudDocs/CoV-MadrID/CODE/11-Cov-MadrID/INPUT/CSV")

for file in glob.glob("28_07_Phenotypes.csv"):
    print (Path(file).stem)
    with open(file,encoding = "utf-8-sig") as f:
        reader = csv.reader(f,delimiter=",")
        next(reader, None)
        for row in reader:
            if len(row) == 33:
                print(row)
                if row[0] != '':
                    cursor.execute(sql1.format(*row))
            else:
                print("error: "+row)
'''


