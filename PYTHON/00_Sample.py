import csv
import MySQLdb

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()


sql1 = "INSERT INTO 00_SAMPLE(ID_Sample,Patient,ICU,Country,Code,Continent) VALUES('{0}','{1}','{2}','{3}','{4}','{5}')"


file = "/Users/superintelligent2/CoV-MadrID.icloud/DATA/SAMPLES/Samples-country-continent.txt"

with open(file) as f:
    reader = csv.reader(f,delimiter="\t")
    next(reader, None)
    for row in reader:
        print(row)
        cursor.execute(sql1.format(*row))

