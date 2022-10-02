import csv
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql  = "SELECT Pneumonia,ARDS,ARDS_N_ICU,Skin_exanthema,Heart_myocarditis,Heart_arrhythmia,Liver_hepatitis,Kidney_glomerulonephritis,Kidney_tubulopathy,Neurological_encephalitis,Neurological_psychiatric,Neurological_polyneuropathy,Neurological_myelitis,Neurological_seizure,Gastrointestinal_diarrhea,Gastrointestinal_vomiting,Endocrine_dysfunction,Musculoskeletal_myopathy,Musculoskeletal_arthritis,Cytopenia,Pulmonary_embolism,Deep_thrombosis,Peripheral_thrombosis,Stroke,Ischemic_heart,Intravascular_coagulation,Persistent_fever,Fatigue_malaise FROM 28_07_Phenotypes WHERE Sample_id = '{0}'"

sql1 = "SELECT SYMBOL FROM 25_05_TCR_HIGH_IMPACT_VARIANT WHERE Patient =1 AND ID_Sample = '{0}' GROUP BY SYMBOL"

Phenotypes=['Pneumonia','ARDS','ARDS_N_ICU','Skin_exanthema','Heart_myocarditis','Heart_arrhythmia','Liver_hepatitis','Kidney_glomerulonephritis','Kidney_tubulopathy','Neurological_encephalitis','Neurological_psychiatric','Neurological_polyneuropathy','Neurological_myelitis','Neurological_seizure','Gastrointestinal_diarrhea','Gastrointestinal_vomiting','Endocrine_dysfunction','Musculoskeletal_myopathy','Musculoskeletal_arthritis','Cytopenia','Pulmonary_embolism','Deep_thrombosis','Peripheral_thrombosis','Stroke','Ischemic_heart','Intravascular_coagulation','Persistent_fever','Fatigue_malaise']
Patient={}

with open ('/Users/superintelligent2/CloudDocs/CoV-MadrID/DATA/SAMPLES/74_samples.txt') as f:
    n = 0
    while True:
        line = f.readline()
        if not line: # or n ==3:
            break
        else:
            Patient_id = line.strip()
            Patient[Patient_id] = {'phenos':[],'genes':[]}
            cursor.execute(sql.format(Patient_id))
            results = cursor.fetchall()

            for result in results:
                i = 0
                for pheno in result:

                    if pheno == 'YES':
                        Patient[Patient_id]['phenos'].append(Phenotypes[i])
                    i = i + 1

            cursor.execute(sql1.format(Patient_id))
            results = cursor.fetchall()

            for result in results:
                for gene in result:
                    Patient[Patient_id]['genes'].append(gene)
        n = n +1

for p in Patient:
    print(p,end='\t')
    #for pheno in Patient[p]['phenos']:
    print (','.join(Patient[p]['phenos']))
    print(p,end='\t')
    print (','.join(Patient[p]['genes']))
    print ('  ')


'''
os.chdir("/Users/superintelligent2/CloudDocs/CoV-MadrID/CODE/11-Cov-MadrID/INPUT/CSV")

for file in glob.glob("28_07_Phenotypes.csv"):
    print (Path(file).stem)
    with open(file,encoding = "utf-8-sig") as f:
        reader = csv.reader(f,delimiter=",")
        next(reader, None)
        for row in reader:
            if len(row) == 33:
                print(row)
                if row[0] != '':
                    cursor.execute(sql1.format(*row))
            else:
                print("error: "+row)
'''


