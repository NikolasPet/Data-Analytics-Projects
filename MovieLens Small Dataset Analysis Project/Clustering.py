#Import τις βιβλιοθήκες που χρειαζόμαστε

import numpy as np 
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.cluster import DBSCAN
from sklearn.metrics import silhouette_score
import matplotlib.pyplot as plt


#Διαβάζουμε το CSV
total = pd.read_csv("final_file.csv")

#Βγάζουμε τα ratings για κάθε ταινία και παίρνουμε τις ταινίες με περισσότερες απο 100 ratings
ratings_per_movie = total[["movieId", "userId"]].groupby("movieId", as_index=False).count().sort_values(by="userId", ascending=False)
ids = ratings_per_movie[ratings_per_movie["userId"] >= 100]["movieId"].reset_index(name="movieId").drop("index", axis=1)
total = total.merge(ids, on="movieId")

#Pivotαρουμε και αν εχουμε χρήστη που δεν βαθμολόγησε βάζουμε 0
cluster_data = pd.pivot_table(total, index='userId', columns= 'title', values='rating')
cluster_data = cluster_data.fillna(0) 

print(len(cluster_data))
print(len(cluster_data.columns))



# K-means

# Βάζουμε αριθμό cluster 
cluster_no = list(range(2,11,2))
models=[]

#Κάνουμε train τον K-means και υπολογίζουμε silhouette
for cluster in cluster_no:
  print("Training KMeans for %d clusters"%(cluster))
  model = KMeans(n_clusters=cluster, max_iter=1000000, tol=1e-6, random_state = 0)
  model.fit(cluster_data)
  score = silhouette_score(cluster_data, model.labels_)
  print(score)
  models.append((cluster, model, score))

#silhouette για καθε cluster
clusters = [x[0] for x in models]
scores = [x[2] for x in models]
fig, ax = plt.subplots()
ax.plot(clusters, scores)
ax.set_ylabel("Silhouette Score")
ax.set_xlabel("# Clusters")
fig.tight_layout()
fig.savefig('KMEANS.png')
plt.close(fig)

print(models[0][1].cluster_centers_)


#----------------------------------------------------------------------------------
# DBSCAN 

# Βάζουμε αριθμό eps και samples 
epss = list(range(200, 250, 5))
minsamples = list(range(4, 10, 2))

dbscan = []

#Κάνουμε train τον DBSCAN και υπολογίζουμε silhouette
for eps in epss:
  for min_samples in minsamples:
    try:  
      print("Training DBSCAN model for eps = %.3f"%(eps/10.0))
      model = DBSCAN(eps=eps/10.0, min_samples=3)
      model.fit(cluster_data)
      score = silhouette_score(cluster_data, model.labels_)
      dbscan.append((eps, min_samples, model, score))
      print(score)
      print(np.unique(model.labels_))
    except:
      #print("label error")
      pass

#silhouette για διαφορετικους συνδυασμούς eps και samples
eps_val = [x[0] for x in dbscan if x[1] == 4]

scores_val_4 = [x[3] for x in dbscan if x[1] == 4]
scores_val_6 = [x[3] for x in dbscan if x[1] == 6]
scores_val_8 = [x[3] for x in dbscan if x[1] == 8]
fig, ax = plt.subplots()
ax.plot(eps_val, scores_val_4, label="4")
ax.plot(eps_val, scores_val_6, label="6")
ax.plot(eps_val, scores_val_8, label="8")
ax.set_ylabel("Silhouette Score")
ax.set_xlabel("# Clusters")
ax.legend(title="min_samples")
fig.tight_layout()
fig.savefig('DBSCAN.png')
plt.close(fig)