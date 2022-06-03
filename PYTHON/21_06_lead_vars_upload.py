import csv
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql1 = "INSERT INTO 21_06_LEAD_VARS(Chromosome,Position,RSID,RiskAllele,RAF,OddsR) VALUES('{0}','{1}','{2}','{3}','{4}','{5}')"


os.chdir("/Users/superintelligent2/CoV-MadrID.icloud/ANALYSIS/MARKERS")

for file in glob.glob("*.txt"):
    print (Path(file).stem)
    with open(file,encoding = "ISO-8859-1") as f:
        reader = csv.reader(f,delimiter="\t")
        next(reader, None)
        for row in reader:
            if len(row) == 6:
                print(row)
                if row[0] != '':
                    cursor.execute(sql1.format(*row))
            else:
                print("error: "+row)


