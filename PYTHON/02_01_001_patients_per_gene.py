import csv
import MySQLdb
import glob, os

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql1 = "SELECT ID_Sample,SYMBOL,Patient FROM 01_001_HIGH_IMPACT ORDER BY SYMBOL"
sql2 = "INSERT INTO 01_001_PATIENTS_PER_GENE(gene_name,patient_count,control_count) VALUES('{0}','{1}','{2}')"

cursor.execute(sql1)
results = cursor.fetchall()

gene_list  = []
patients_per_gene = {}
controls_per_gene = {}

for result in results:
    ID_Sample = result[0]
    SYMBOL    = result[1]
    Patient   = result[2]
    gene_list.append(SYMBOL)

    if Patient == 1:
        if SYMBOL in patients_per_gene:
            patients_per_gene[SYMBOL].append(ID_Sample)
        else:
            patients_per_gene[SYMBOL] = [ID_Sample]
    else:
        if SYMBOL in controls_per_gene:
            controls_per_gene[SYMBOL].append(ID_Sample)
        else:
            controls_per_gene[SYMBOL] = [ID_Sample]

affected_genes = {}

for gene in gene_list:

    if gene in patients_per_gene and gene in controls_per_gene:
        patient_list = list(set(patients_per_gene[gene]))
        control_list = list(set(controls_per_gene[gene]))

        patient_count = sum(1 for patient in patient_list)
        control_count = sum(1 for control in control_list)

        if gene not in affected_genes:
            affected_genes[gene] = [gene,patient_count,control_count]

for gene in sorted(set(affected_genes)):
    myList = list(affected_genes[gene])
    cursor.execute(sql2.format(*myList))
    print (myList)


