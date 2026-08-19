import pandas as pd


df_check = pd.read_csv('data/cleaned_superstore.csv')
print(df_check.shape)
print(df_check.head())
print(df_check.dtypes)