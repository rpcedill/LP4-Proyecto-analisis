import pandas as pd
import matplotlib.pyplot as plt

#df = pd.read_csv("requerimientos.csv", index_col="nombreE")
#df = pd.read_csv("etiquetas.csv", index_col="nombreE")
df = pd.read_csv("categorias.csv", index_col="nombreE")
nuevoDF = df.head(15)
df.plot(kind = 'barh')
#df.plot(kind = 'barh')
plt.show()
