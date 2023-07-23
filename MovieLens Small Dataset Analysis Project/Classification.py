#Import τις βιβλιοθήκες που χρειαζόμαστε

import numpy as np 
import pandas as pd
from sklearn.naive_bayes import BernoulliNB
from sklearn.svm import LinearSVC
from sklearn.metrics import confusion_matrix
from sklearn.metrics import roc_auc_score
from sklearn.model_selection import GridSearchCV
from sklearn.preprocessing import OneHotEncoder
import matplotlib.pyplot as plt


#Διαβάζουμε το CSV
total = pd.read_csv("final_file.csv")

#Δεν χρειαζόμαστε τις συγκεκριμένες στήλες, οπότε τις πετάμε
total = total.drop(["movieId", "userId", "title"], axis = 1)

#Κάνουμε τα data features και labels
data = total.drop("rating", axis = 1)
labels = total["rating"].apply(lambda x : x*2).astype(int)

#Κάνουμε τα labels one hot
labels2 = np.array(labels.tolist()).reshape(-1,1)
ohe = OneHotEncoder()
ohe.fit(labels2)
initial_y = ohe.transform(labels2)
initial_y = initial_y.toarray()

#Βάζουμε τις παραμέτρους για Bernoulli
parameters = {'alpha': [0.5, 1.0, 1.5, 2.0], 'fit_prior':[True, False]}

#Φτιάχνουμε τον ταξινομητή
bern = BernoulliNB()
clf = GridSearchCV(bern, parameters)
clf.fit(data, labels)

#Κρατάμε καλύτερο estimator και score 
best_estimator = clf.best_estimator_
best_score = clf.best_score_

print(initial_y)

#Παίρνουμε τα predictions, τα κάνουμε και αυτά one hot, και υπολογίζουμε matrix
pred = best_estimator.predict(data)
pred = pred.reshape(-1,1)
pred_y = ohe.transform(pred)
pred_y = pred_y.toarray()
print(pred_y)
cm = confusion_matrix(labels,pred)
print(cm)

#Υπολογίζουμε roc_auc
roc_auc = roc_auc_score(initial_y, pred_y,  multi_class="ovr", average="micro")
print(roc_auc)


#--------------------------------------------------------------------------------


#Βάζουμε τις παραμέτρους για LS-SVM
parameters = {'C': [0.5, 1.0, 1.5]}

#Φτιάχνουμε τον ταξινομητή
svc = LinearSVC()
clf = GridSearchCV(svc, parameters)
clf.fit(data, labels)

#Κρατάμε και εδώ καλύτερο estimator και score
best_estimator = clf.best_estimator_
best_score = clf.best_score_

print(initial_y)

#Παίρνουμε τα predictions, τα κάνουμε και αυτά one hot, και υπολογίζουμε matrix
pred = best_estimator.predict(data)
pred = pred.reshape(-1,1)
pred_y = ohe.transform(pred)
pred_y = pred_y.toarray()
print(pred_y)
cm = confusion_matrix(labels,pred)
print(cm)

#Υπολογίζουμε roc_auc
roc_auc = roc_auc_score(initial_y, pred_y,  multi_class="ovr", average="micro")
print(roc_auc)