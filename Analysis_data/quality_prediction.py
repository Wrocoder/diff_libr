import pandas as pd

from Analysis_data.helper import get_csv_from_url

link = 'https://raw.githubusercontent.com/amankharwal/Website-data/master/water_potability.csv'
csv_file_name = "data1.csv"


# get file


import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.metrics import classification_report

get_csv_from_url(link, csv_file_name)

data = pd.read_csv(csv_file_name)

# Split the dataset into features (X) and target variable (y)
X = data.drop(columns=['Potability'])
y = data['Potability']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=786)

# Create and train a Random Forest classifier
rf_classifier = RandomForestClassifier()
rf_classifier.fit(X_train, y_train)

# Create and train a Support Vector Classifier (SVC)
svc_classifier = SVC()
svc_classifier.fit(X_train, y_train)

# Make predictions on the test data
rf_predictions = rf_classifier.predict(X_test)
svc_predictions = svc_classifier.predict(X_test)

# Evaluate the models
print("Random Forest Classifier:")
print(classification_report(y_test, rf_predictions))

print("\nSupport Vector Classifier:")
print(classification_report(y_test, svc_predictions))

