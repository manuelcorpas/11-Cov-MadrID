import csv
import MySQLdb
import glob, os
from pathlib import Path

db = MySQLdb.connect(host='localhost',
    user='root',
    passwd='',
    db='cov')
cursor = db.cursor()

sql1 = "INSERT INTO 28_07_Phenotypes(Sample_id,ICU_Days,Age,Sex,Country_origin,Pneumonia,ARDS,ARDS_N_ICU,Skin_exanthema,Heart_myocarditis,Heart_arrhythmia,Liver_hepatitis,Kidney_glomerulonephritis,Kidney_tubulopathy,Neurological_encephalitis,Neurological_psychiatric,Neurological_polyneuropathy,Neurological_myelitis,Neurological_seizure,Gastrointestinal_diarrhea,Gastrointestinal_vomiting,Endocrine_dysfunction,Musculoskeletal_myopathy,Musculoskeletal_arthritis,Cytopenia,Pulmonary_embolism,Deep_thrombosis,Peripheral_thrombosis,Stroke,Ischemic_heart,Intravascular_coagulation,Persistent_fever,Fatigue_malaise) VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}','{18}','{19}','{20}','{21}','{22}','{23}','{24}','{25}','{26}','{27}','{28}','{29}','{30}','{31}','{32}')"


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


