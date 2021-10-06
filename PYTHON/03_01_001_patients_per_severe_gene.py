import csv
import MySQLdb
import glob, os

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()


genes = ['ACE2','TMPRSS2','SLC6A20','ABO','PPP1R15A','IFNAR2','OAS1','OAS2','OAS3','TLR7',
        'DPP9','FOXP4-AS1','KANSL1','TAC4','DLX3','GNL3','LZTFL1','CCR9','CXCR6','XCR1',
        'FYCO1','TYK2','RAVER1','MEF2B','IL10RB','PGF','MACC1','GOLGA3','DPP7','NOTCH4',
        'CCHCR1','HLA-C']

print (genes)

sql1 = "SELECT ID_Sample,SYMBOL,Patient FROM 01_001_HIGH_IMPACT WHERE SYMBOL = %s"
sql2 = "INSERT INTO 01_001_PATIENTS_PER_GENE(gene_name,patient_count,control_count) VALUES('{0}','{1}','{2}')"

for gene in genes:
    cursor.execute(sql1,[gene])
    results = cursor.fetchall()

    for result in results:
        ID_Sample = result[0]
        SYMBOL    = result[1]
        Patient   = result[2]
        print(ID_Sample,SYMBOL)

'''
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

'''
