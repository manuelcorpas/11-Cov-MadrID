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

gene_list  = {}

for result in results:
    ID_Sample = result[0]
    SYMBOL    = result[1]

    if SYMBOL in gene_list:
        gene_list[SYMBOL].append(ID_Sample)
    else:
        gene_list[SYMBOL] = [ID_Sample]

for gene in gene_list:
    myList = sorted(set(gene_list[gene]))
    print (gene,*myList,sep=', ')


