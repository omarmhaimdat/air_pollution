import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.externals import joblib
from sklearn.ensemble import RandomForestRegressor
from sklearn import metrics

column_names = ['Date', 'Nitrogen_Dioxide', 'Ozone', 'PM10_Particulate', 'PM2-5_Particulate']

def train():
    data_set = './air-quality-london-time-of-day.csv'

    data = pd.read_csv(data_set, sep=',', names=column_names)
    X = data.iloc[1:, 0].values
    Y = data.iloc[1:, 4].values
    X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=0)

    print(type(X_train))

    X_train = X_train.reshape(-1, 1)
    X_test = X_test.reshape(-1, 1)

    regressor = RandomForestRegressor(n_estimators=4000)
    regressor.fit(X_train, Y_train)
    y_pred = regressor.predict(X_test)

    joblib.dump(regressor, 'pollution_prediction.pkl')
    print("Done training")

    print('Mean Absolute Error:', metrics.mean_absolute_error(Y_test, y_pred))
    print('Mean Squared Error:', metrics.mean_squared_error(Y_test, y_pred))
    print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(Y_test, y_pred)))

if __name__ == '__main__':
    train()
