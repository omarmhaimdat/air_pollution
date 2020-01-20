import numpy as np
from sklearn.externals import joblib

def predict_pollution(option):
    tree_model = joblib.load('pollution_prediction.pkl')
    date = [float(option)]
    date = np.asarray(date, dtype=np.float32)
    date = date.reshape(-1, 1)
    print(date)
    temp = tree_model.predict(date)[0]
    print("-" * 48)
    print("\nThe pollution is estimated to be: " + str(temp) + "\n")
    print("-" * 48)
    return str(temp)