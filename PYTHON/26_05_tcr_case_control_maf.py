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

sql2 = "INSERT INTO 26_05_TCR_CASE_CONTROL_MAF(GENE,RSID,Chromosome,Chr_Start,Chr_End,REF,ALT,Consequence,CADD_PHRED,Case_alleles,Control_alleles,Case_MAF,Control_MAF,AF,gnomAD_NFE_AF,gnomAD_AF) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}')"

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
            g[gene][RSID]['Chromosome']    = Chromosome
            g[gene][RSID]['Chr_Start']     = Chr_Start
            g[gene][RSID]['Chr_End']       = Chr_End
            g[gene][RSID]['REF']           = REF
            g[gene][RSID]['ALT']           = ALT

        if Patient == 1:
            g[gene][RSID]['Case_MAF']    += ALT_allele_count
        if Patient == 0:
            g[gene][RSID]['Control_MAF'] += ALT_allele_count

for gene in g:
    for snp in g[gene]:
        #GENE,RSID,Chromosome,Chr_Start,Chr_End,REF,ALT,Consequence,CADD_PHRED,Case_alleles,Control_alleles,Case_MAF,Control_MAF,AF,gnomAD_NFE_AF,gnomAD_AF
        Case_alleles    = g[gene][snp]['Case_MAF']
        Control_alleles = g[gene][snp]['Control_MAF']
        Case_MAF        = Case_alleles/Total_case_alleles
        Control_MAF     = Control_alleles/Total_control_alleles
        result = [gene,snp,g[gene][snp]['Chromosome'],g[gene][snp]['Chr_Start'],g[gene][snp]['Chr_End'],g[gene][snp]['REF'],g[gene][snp]['ALT'],g[gene][snp]['Consequence'], \
                           g[gene][snp]['CADD_PHRED'],Case_alleles,Control_alleles,Case_MAF,Control_MAF,g[gene][snp]['AF'],g[gene][snp]['gnomAD_NFE_AF'],g[gene][snp]['gnomAD_AF']]
        print(*result)
        cursor.execute(sql2.format(*result))
