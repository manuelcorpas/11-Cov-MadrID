import csv
import MySQLdb
import glob, os

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql1 = "SELECT ID_Sample,SYMBOL FROM 00_VEP WHERE Patient = 1 ORDER BY ID_Sample"

cursor.execute(sql1)
results = cursor.fetchall()

patient_list  = {}

for result in results:
    ID_Sample = result[0]
    SYMBOL    = result[1]

    if ID_Sample in patient_list:
        patient_list[ID_Sample].append(SYMBOL)
    else:
        patient_list[ID_Sample] = [SYMBOL]

for patient in patient_list:
    myList = sorted(set(patient_list[patient]))
    print (patient,*myList,sep=', ')


