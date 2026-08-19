import pandas as pd

df = pd.read_csv('data/raw_superstore.csv', encoding='latin1')

print(df.info())
print(df.isnull().sum())

# This dataset uses M/D/YYYY format
df['Order Date'] = pd.to_datetime(df['Order Date'], format='%m/%d/%Y')
df['Ship Date'] = pd.to_datetime(df['Ship Date'], format='%m/%d/%Y')

df = df.drop_duplicates() 

df['Order Month'] = df['Order Date'].dt.to_period('M').astype(str)
df['Order Year'] = df['Order Date'].dt.year
df['Profit Margin'] = (df['Profit'] / df['Sales']) * 100

# Clean column names for SQL compatibility
df.columns = [c.strip().replace(' ', '_').replace('-', '_') for c in df.columns]

df.to_csv('data/cleaned_superstore.csv', index=False)
print("Cleaned data saved. Shape:", df.shape)