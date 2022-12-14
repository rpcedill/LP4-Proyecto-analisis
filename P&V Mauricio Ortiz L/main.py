import pandas as pd
import matplotlib.pyplot as plt

games = open("games.csv", "r")
games.readline()
indie = 0
other = 0
ratingI = 0
ratingO = 0
doblaje = 0
tgames = 0
achievements = {}

for game in games:
    data = game.split(",")
    tgames += 1

    if achievements.get(int(data[4])) == None:
        achievements[int(data[4])] = [data[1]]
    else:
        achievements[int(data[4])].append(data[1])

    if data[2] != "No rating":
        if "Indie" in data[7]:
            indie += 1
            ratingI += int(data[2])
        else:
            other += 1
            ratingO += int(data[2])

    if "Spanish" in data[5]:
        doblaje += 1


# De los videojuegos revisados ¿cuáles son los 5 videojuegos con más logros para obtener?
ordered = sorted(achievements.keys(), reverse=True)
games = []
achvmnt = []
for key in ordered:
    if len(games) == 5:
        break
    for val in achievements[key]:
        if len(games) == 5:
            break
        games.append(val)
        achvmnt.append(key)
print(games)
print(achvmnt)
ds1 = pd.DataFrame({"Logros": achvmnt}, index=games)
ds1.plot(kind="bar")
plt.show()


# ¿Los juegos indie en promedio tienen calificaciones más bajas que los juegos desarrollados por grandes compañías?
print("Rating promedio de juegos indie " + str(ratingI / indie))
print("Rating promedio de juegos no indie " + str(ratingO / other))

ds2 = pd.DataFrame({"Calificación promedio": [(ratingI / indie), (ratingO / other)]}, index=["Indie", "Otros"])
ds2.plot(kind="bar")
plt.show()


# ¿Cuál es el porcentaje de juegos que tenían doblaje al español?
def func(pct):
    return "{:.1f}%".format(pct)

percentage = (doblaje * 100 / tgames)
lang = ["Español", "Otros"]
print("El porcentaje de juegos que tienen doblaje al español es " + str(percentage) + "%.")
data = [percentage, (100 - percentage)]
plt.pie(data,
        labels=lang,
        shadow=True,
        autopct=lambda pct: func(pct)
        )
plt.legend(lang,
           title="Idiomas",
           loc="center left",
           bbox_to_anchor=(1, 0, 0.5, 1))
plt.show()

print("Proyecto terminado, M15.")