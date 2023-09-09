# Water Quality Analysis using Python

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import plotly.express as px

from Analysis_data.helper import get_csv_from_url

link = 'https://raw.githubusercontent.com/amankharwal/Website-data/master/water_potability.csv'
csv_file_name = "data1.csv"


# get file
get_csv_from_url(link, csv_file_name)

data = pd.read_csv(csv_file_name)
data.head()

# data = data.dropna()
# data.isnull().sum()

# plt.figure(figsize=(15, 10))
# sns.countplot(data.Potability)
# plt.title("Distribution of Unsafe and Safe Water")
# plt.show()

data = data
figure = px.histogram(data, x="ph",
                      color="Potability",
                      title="Factors Affecting Water Quality: PH")
figure.show()

figure = px.histogram(data, x="Hardness",
                      color="Potability",
                      title="Factors Affecting Water Quality: Hardness")
figure.show()

figure = px.histogram(data, x="Solids",
                      color="Potability",
                      title="Factors Affecting Water Quality: Solids")
figure.show()

figure = px.histogram(data, x="Chloramines",
                      color="Potability",
                      title="Factors Affecting Water Quality: Chloramines")
figure.show()

figure = px.histogram(data, x="Sulfate",
                      color="Potability",
                      title="Factors Affecting Water Quality: Sulfate")
figure.show()

figure = px.histogram(data, x="Conductivity",
                      color="Potability",
                      title="Factors Affecting Water Quality: Conductivity")
figure.show()

figure = px.histogram(data, x = "Organic_carbon",
                      color = "Potability",
                      title= "Factors Affecting Water Quality: Organic Carbon")
figure.show()

figure = px.histogram(data, x = "Trihalomethanes",
                      color = "Potability",
                      title= "Factors Affecting Water Quality: Trihalomethanes")
figure.show()