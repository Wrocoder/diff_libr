import pandas as pd

# Path to input
input_file = "events.csv"

# Path to output
output_file = "output.csv"

# Creating DataFrame from input csv file
df = pd.read_csv(input_file)

# fix date format
df['start_time'] = pd.to_datetime(df['start_time']).dt.strftime('%Y-%m-%d %H:%M:%S')

# save fixed data
df.to_csv(output_file, index=False)

