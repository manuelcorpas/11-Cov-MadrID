import vcf
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor(MySQLdb.cursors.DictCursor)

TCR_genes = ['TRAV19','TRBV5-5','TRBV6-5','TRBV6-7','TRBV7-1','TRBV7-3','TRBV7-6','TRBV7-7','TRBV7-8','TRBV10-1','TRBV30']
ES_74     = ['AR5440','AR5443','AR5444','AR5445','AR5446','AR5447','AR5448','AR5449','AR5450','AR5451','AR5452','AR5454','AR5455','AR5457','AR5458',
             'AR5459','AR5460','AR5461','AR5462','AR5463','AR5464','AR5465','AR5466','AR5467','AR5468','AR5469','AR5470','AR5472','AR5473','AR5474',
             'AR5475','AR5476','AR5477','AR5478','AR5481','AR5484','AR5485','AR5486','AR5487','AR5488','AR5490','AR5492','AR5493','AR5495','AR5496',
             'AR5497','AR5499','AR5500','AR5501','AR5502','AR5503','AR5506','AR5507','AR5508','AR5510','AR5511','AR5512','AR5513','AR5514','AR5516',
             'AR5517','AR5518','AR5520','AR5521','AR5522','AR5524','AR5526','AR5527','AR5530','AR5533','AR5535','AR5536','AR5538','AR5539']


sql1 = "SELECT p.ID_Sample,s.Patient,S.Code,p.Chromosome,i.Chr_Start,i.Chr_End,p.REF,p.ALT,p.ZYG,p.GT_Bases,i.Allele,i.Consequence,i.IMPACT,i.SYMBOL,i.AF,i.gnomAD_AF FROM 17_05_PATIENT_VARIANT as p,16_05_FILTERED_ALL_VAR_CONSEQ as i,00_SAMPLE as s WHERE i.Chromosome = p.Chromosome AND i.Chr_Start = p.Chr_Position AND s.ID_Sample = p.ID_Sample AND i.IMPACT = 'HIGH' AND i.SYMBOL ='{0}';"

sql2 = "INSERT INTO 25_05_TCR_HIGH_IMPACT_VARIANT(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}')"

for gene in TCR_genes:
    cursor.execute(sql1.format(gene))
    results = cursor.fetchall()

    for result in results:
        ID_Sample     = result['ID_Sample']
        Patient       = result['Patient']
        Code          = result['Code']
        Chromosome    = result['Chromosome']
        Effect_Allele = result['Allele']
        GT_Bases      = result['GT_Bases']
        GT_Alleles    = GT_Bases.split('/')
        Var_Alleles   = [result['REF']]+[i for i in result['ALT'][1:-1].split(',')]
        REF           = result['REF']
        ALT           = result['ALT']
        ZYG           = result['ZYG']
        Chr_Start     = result['Chr_Start']
        Chr_End       = result['Chr_End']
        Consequence   = result['Consequence']
        IMPACT        = result['IMPACT']
        SYMBOL        = result['SYMBOL']
        AF            = result['AF']
        gnomAD_AF     = result['gnomAD_AF']

        # Print only ES_74 Patients
        if Patient == 1 and ID_Sample in ES_74:
            print(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF)
            cursor.execute(sql2.format(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF))

        # Print all 1000G
        if Patient == 0:
            print(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF)
            cursor.execute(sql2.format(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF))

