import pandas as pd

from sklearn.preprocessing import LabelEncoder
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.cross_validation import train_test_split




# Reading CSV File
data = pd.read_csv("../data/mushrooms.csv")


def classification_rule():
    X = pd.DataFrame(data, columns=data.columns[1:len(data.columns)],
                     index=data.index)
    Y = data['type']
    le = LabelEncoder()
    x = pd.DataFrame(X, columns=[X.columns[0]])
    y = le.fit_transform(Y)

    for name in X.columns:
        x[name] = le.fit_transform(X[name])

    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.4)

    knn = KNeighborsClassifier(n_neighbors=3)
    knn.fit(x_train, y_train)
    knn_pred = knn.predict(x_test)
    acc_knn = round(knn.score(x_train, y_train) * 100, 2)
    print(acc_knn)


#   RandomForest
    random_forest = RandomForestClassifier(n_estimators=100)
    random_forest.fit(x_train, y_train)
    ran_pred = random_forest.predict(x_test)
    random_forest.score(x_train, y_train)
    acc_random_forest = round(random_forest.score(x_train, y_train) * 100, 2)
    print(acc_random_forest)

if __name__ == '__main__':
    classification_rule()