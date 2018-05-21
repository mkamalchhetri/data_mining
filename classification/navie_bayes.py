import pandas as pd

from sklearn.preprocessing import LabelEncoder
from sklearn.naive_bayes import BernoulliNB
from sklearn.naive_bayes import MultinomialNB
from sklearn.naive_bayes import GaussianNB
from sklearn.cross_validation import train_test_split
from sklearn import metrics

from sklearn.metrics import accuracy_score
import seaborn as sns


# Reading CSV File
data = pd.read_csv("../data/mushrooms.csv")


def preprocessing_navie():
    X = pd.DataFrame(data, columns=data.columns[1:len(data.columns)],
                     index=data.index)
    Y = data['type']
    le = LabelEncoder()
    x = pd.DataFrame(X, columns=[X.columns[0]])
    y = le.fit_transform(Y)

    for name in X.columns:
        x[name] = le.fit_transform(X[name])

    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.4)

    gaussian_nb = GaussianNB()
    gaussian_nb.fit(x_train, y_train)

    train_predict = gaussian_nb.predict(x_train)
    test_predict = gaussian_nb.predict(x_test)

    print("Training accuracy Naive Bayes:", metrics.accuracy_score(y_train, train_predict))
    print("Testing accuracy Naive Bayes:", metrics.accuracy_score(y_test, test_predict))


    # bernoulli navie bayes
    bernoulli_nb = BernoulliNB()
    bernoulli_nb.fit(x_train, y_train)

    train_predict_bernoulli = bernoulli_nb.predict(x_train)
    test_predict_bernoulli = bernoulli_nb.predict(x_test)

    print("Training accuracy Naive bernoulli Bayes:", metrics.accuracy_score(y_train, train_predict_bernoulli))
    print("Testing accuracy Naive bernoulli Bayes:", metrics.accuracy_score(y_test, test_predict_bernoulli))



    # multinomial navie bayes
    multinomial_nb = MultinomialNB()
    multinomial_nb.fit(x_train, y_train)

    train_predict_multinomial = multinomial_nb.predict(x_train)
    test_predict_multinomial = multinomial_nb.predict(x_test)

    print("Training accuracy Naive multinomial Bayes:", metrics.accuracy_score(y_train, train_predict_multinomial))
    print("Testing accuracy Naive multinomial Bayes:", metrics.accuracy_score(y_test, test_predict_multinomial))


if __name__ == '__main__':
    preprocessing_navie()