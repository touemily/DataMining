import pandas as pd
from sklearn.tree import DecisionTreeClassifier, plot_tree # Import Decision Tree Classifier
from sklearn.model_selection import train_test_split # Import train_test_split function
from sklearn.metrics import * #Import scikit-learn metrics module for accuracy calculation
import argparse
import matplotlib.pyplot as pyplot
from sklearn import preprocessing, svm
from sklearn.model_selection import GridSearchCV

parser = argparse.ArgumentParser(description='Program to predict inductions of baseball hall of fame')
parser.add_argument('csv_path')


def main():
    args = parser.parse_args()

    csv_path = args.csv_path

    col_names = ['playerId', 'awardCount', 'homeRuns', 'totalGames', 'oba', 'era', 'slg', 'obp', 'allStar', 'yearsPlayed', 'finalGame', 'completeGames', 'zr', 'class']

    data = pd.read_csv(csv_path, header=0)

    le = preprocessing.LabelEncoder()
    for column_name in col_names:
        if data[column_name].dtype == object:
            data[column_name] = le.fit_transform(data[column_name])
        else:
            pass

    # ['totalGames', 'allStar', 'yearsPlayed', 'completeGames', 'oba', 'era', 'slg', 'obp', 'homeRuns']
    # ['awardCount', 'homeRuns', 'totalGames', 'oba', 'era', 'slg', 'obp', 'allStar', 'completeGames', 'zr'] 0.93
    feature_cols = ['awardCount', 'homeRuns', 'totalGames', 'oba', 'era', 'slg', 'obp', 'allStar', 'completeGames', 'zr']
    X = data[feature_cols] # Features
    y = data['class'] # Target variable


    # Split dataset into training set and test set
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0) # 80% training and 20% test

    train_scores = []
    test_scores = []

    train_precision = []
    test_precision = []

    train_recall = []
    test_recall = []

    values = [i for i in range(2, 3)]

    for i in values:

        # Create Decision Tree classifer object
        clf = DecisionTreeClassifier(max_depth=i)

        # Train Decision Tree Classifer
        clf = clf.fit(X_train,y_train)

        #Predict the response for test dataset
        train_y_pred = clf.predict(X_train)
        y_pred = clf.predict(X_test)

        train_acc = accuracy_score(y_train, train_y_pred)
        test_acc = accuracy_score(y_test, y_pred)
        train_scores.append(train_acc)
        test_scores.append(test_acc)

        train_precision.append(precision_score(y_train, train_y_pred))
        test_precision.append(precision_score(y_test, y_pred))

        train_recall.append(recall_score(y_train, train_y_pred))
        test_recall.append(recall_score(y_test, y_pred))

        # Model Accuracy, how often is the classifier correct?
        print("Train Accuracy:", train_acc)
        print("Accuracy:", test_acc)
        print("Recall:", recall_score(y_test, y_pred))
        print("Precision:", precision_score(y_test, y_pred))
        print("F1 Score:", f1_score(y_test, y_pred))
        print()

    print("Average accuracy:", sum(test_scores)/len(test_scores))

    pyplot.plot(values, train_scores, '-o', label='Train')
    pyplot.plot(values, test_scores, '-o', label='Test')
    pyplot.xlabel("max_depth")
    pyplot.ylabel("Accuracy")
    pyplot.legend()
    x = pyplot.figure(1)
    x.show()

    cm = confusion_matrix(y_test, y_pred, labels=clf.classes_)
    disp = ConfusionMatrixDisplay(confusion_matrix=cm, display_labels=clf.classes_)
    disp.plot()
    pyplot.show()

    plot_tree(clf, feature_names=feature_cols)
    pyplot.savefig('taskB_tree.svg')
    


if __name__ == "__main__":
    main()