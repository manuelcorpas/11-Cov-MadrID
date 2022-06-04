import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor(MySQLdb.cursors.DictCursor)

TCR_genes = ['TRAV19','TRBV5-5','TRBV6-5','TRBV6-7','TRBV7-1','TRBV7-3','TRBV7-6','TRBV7-7','TRBV7-8','TRBV10-1','TRBV30']
sql1 = "SELECT ID_Sample,Patient,Existing_variation,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,SYMBOL,AF,CADD_PHRED,gnomAD_NFE_AF,gnomAD_AF FROM 25_05_TCR_HIGH_IMPACT_VARIANT WHERE SYMBOL='{0}';"

#sql2 = "INSERT INTO 25_05_TCR_HIGH_IMPACT_VARIANT(ID_Sample,Patient,Code,Existing_variation,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}')"

Total_case_alleles    = 148
Total_control_alleles = 186

g={}

for gene in TCR_genes:
    cursor.execute(sql1.format(gene))
    results = cursor.fetchall()

    g[gene] = {}

    for result in results:
        ID_Sample     = result['ID_Sample']
        Patient       = result['Patient']
        RSID          = result['Existing_variation']
        Chromosome    = result['Chromosome']
        REF           = result['REF']
        ALT           = result['ALT'][1:-1]
        ZYG           = result['ZYG']
        Chr_Start     = result['Chr_Start']
        Chr_End       = result['Chr_End']
        Consequence   = result['Consequence']
        Gene          = result['SYMBOL']
        AF            = result['AF']
        CADD_PHRED    = result['CADD_PHRED']
        gnomAD_NFE_AF = result['gnomAD_NFE_AF']
        gnomAD_AF     = result['gnomAD_AF']

        ALT_alleles      = ZYG.split("/")
        ALT_alleles      = list(map(int,ALT_alleles))
        ALT_allele_count = sum(ALT_alleles)

        if not RSID in g[gene]:
            g[gene][RSID]                  = {}
            g[gene][RSID]['Case_MAF']      = 0
            g[gene][RSID]['Control_MAF']   = 0
            g[gene][RSID]['Consequence']   = Consequence
            g[gene][RSID]['CADD_PHRED']    = CADD_PHRED
            g[gene][RSID]['AF']            = AF
            g[gene][RSID]['gnomAD_NFE_AF'] = gnomAD_NFE_AF
            g[gene][RSID]['gnomAD_AF']     = gnomAD_AF

        if Patient == 1:
            g[gene][RSID]['Case_MAF']    += ALT_allele_count
        if Patient == 0:
            g[gene][RSID]['Control_MAF'] += ALT_allele_count

        #print(Gene,ID_Sample,Patient,RSID,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,ALT_allele_count,Total_case_alleles,Total_control_alleles,AF,gnomAD_AF)
        #cursor.execute(sql2.format(ID_Sample,Patient,Code,Existing_variation,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF))


for gene in g:
    for snp in g[gene]:
        result = [gene,snp,g[gene][snp]['Case_MAF'],g[gene][snp]['Control_MAF'],g[gene][snp]['Consequence'],g[gene][snp]['CADD_PHRED'],g[gene][snp]['AF'],g[gene][snp]['gnomAD_NFE_AF'],g[gene][snp]['gnomAD_AF']]
        print(*result)
        cursor.execute(sql2.format(*result))
