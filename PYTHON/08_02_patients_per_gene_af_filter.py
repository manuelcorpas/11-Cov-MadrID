import csv
import MySQLdb
import glob, os

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor(MySQLdb.cursors.DictCursor)

sql1 = "SELECT ID_Sample,Patient,Code,SYMBOL from 06_02_HIGH_IMPACT_VARIANT WHERE AF='-' AND gnomAD_AF='-' ORDER BY ID_Sample"
sql2 = "INSERT INTO 07_02_PATIENTS_PER_GENE(SYMBOL,Case_cnt,Control_cnt) VALUES('{0}','{1}','{2}')"

cursor.execute(sql1)
results = cursor.fetchall()

case_gene_dict    = {}
control_gene_dict = {}

for result in results:
    ID_Sample = result['ID_Sample']
    Patient   = result['Patient'  ]
    Code      = result['Code'     ]
    SYMBOL    = result['SYMBOL'   ]

    if Patient == 1 and Code == 'ES':
        if SYMBOL in case_gene_dict:
            case_gene_dict[SYMBOL].append(ID_Sample)
        else:
            case_gene_dict[SYMBOL] = [ID_Sample]
    elif Patient == 0:
        if SYMBOL in control_gene_dict:
            control_gene_dict[SYMBOL].append(ID_Sample)
        else:
            control_gene_dict[SYMBOL] = [ID_Sample]

gene_dict = {}

for gene in case_gene_dict:
    if gene in control_gene_dict:
        caseList    = sorted(set(case_gene_dict[gene]))
        controlList = sorted(set(control_gene_dict[gene]))
        gene_dict[gene] = [len(caseList),len(controlList)]

for gene in gene_dict:
    Case_cnt    = gene_dict[gene][0]
    Control_cnt = gene_dict[gene][1]
    print(gene,Case_cnt,Control_cnt)
    cursor.execute(sql2.format(gene,Case_cnt,Control_cnt))


