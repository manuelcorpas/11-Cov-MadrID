import vcf
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(db='cov',read_default_file='~/.my.cnf')
cursor = db.cursor(MySQLdb.cursors.DictCursor)

sql1 = "SELECT p.ID_Sample,s.Patient,S.Code,p.Chromosome,i.Chr_Start,i.Chr_End,p.REF,p.ALT,p.ZYG,p.GT_Bases,i.Allele,i.Consequence,i.IMPACT,i.SYMBOL,i.AF,i.gnomAD_AF FROM 17_05_PATIENT_VARIANT as p,16_05_FILTERED_ALL_VAR_CONSEQ as i,00_SAMPLE as s WHERE i.Chromosome = p.Chromosome AND i.Chr_Start = p.Chr_Position AND s.ID_Sample = p.ID_Sample AND i.IMPACT = 'HIGH';"

sql2 = "INSERT INTO 18_05_HIGH_IMPACT_VARIANT(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}')"

cursor.execute(sql1)
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

    # Checks that Effect Allele is present in the patient variant
    # Find if the Effect Allele does not match any of the Genotype Alleles
    if not Effect_Allele in GT_Alleles and Effect_Allele != '-':
            continue
            #print(ID_Sample,Chromosome,Effect_Allele,GT_Bases,Chr_Start,Chr_End)
    # Find if there are any Effect Alleles that do not match Genotype Alleles
    if not Effect_Allele in GT_Alleles:
        # Make sure deletion length is shorter than REF
        if Effect_Allele == '-' and not len(min(GT_Alleles, key=len)) < len(REF):
            continue
    print(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF)
    cursor.execute(sql2.format(ID_Sample,Patient,Code,Chromosome,Chr_Start,Chr_End,REF,ALT,ZYG,Consequence,IMPACT,SYMBOL,AF,gnomAD_AF))
