import gzip
import pandas as pd
import numpy as np

with gzip.open('./Homo_sapiens.gene_info.gz', 'rt') as gz_file:
    with open('./Homo_sapiens.gene_info', 'w') as output_file:
        output_file.write(gz_file.read())
df = pd.read_csv("./Homo_sapiens.gene_info", sep ='\t')
df1 = df[['GeneID','Symbol','Synonyms']]
new_df = df1.assign(Synonyms=df1['Synonyms'].str.split('|'))

new_df = new_df.explode('Synonyms')

new_df['GeneID'] = new_df['GeneID'].astype(int)
id_mapping = zip(new_df['Symbol'], new_df['GeneID'])
id_map = dict(id_mapping)
 
gene_mapping = dict(zip(new_df['Synonyms'],new_df['GeneID']))

gene_matrix = pd.read_csv("./h.all.v2023.1.Hs.symbols.gmt", sep ='\t')
gene_matrix.columns = [i for i in range(1,len(gene_matrix.columns)+1)]
genes = gene_matrix.drop(columns = [1,2])

genes_1=pd.DataFrame()
for i in genes:
  genes_1[i] = genes[i].map(gene_mapping)
#print(genes_1)

genes_2=pd.DataFrame()
for i in genes:
  genes_2[i] = genes[i].map(id_map)
print(genes_2)