import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("requerimientos.csv", index_col="nombreE")

df.plot(kind = 'barh')
plt.show()
