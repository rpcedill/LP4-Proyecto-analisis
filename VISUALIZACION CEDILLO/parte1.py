import pandas as pd


df = pd.DataFrame(columns = ["Nombre","Popularidad","Valoración","Plataforma", "Desarrollador", "Género",
             "Jugadores", "Lanzamiento","Precio"])
file = open('videoJuegos.csv','r')
lineas = file.readlines()
contador = -1
for linea in lineas :
  datos = linea.strip('\n').split(',')
  df2 = pd.DataFrame({'Nombre': [''],
                    'Popularidad' :[''],
                    'Valoración' :[0.0],
                    'Plataforma' :['PC'],
                    'Desarrollador' :[''],
                    'Género' :[''],
                    'Jugadores' :[''],
                    'Lanzamiento' :[''],
                    'Precio' :[0.0],
                    })

  
  for elemento in datos:
    if 'Nombre:' in elemento:
      df2.loc[0,'Nombre'] = elemento.strip('Nombre:')
      
    if 'Popularidad:' in elemento:
      df2.loc[0,'Popularidad'] = elemento.strip('Popularidad:')
      
    if '"Valoración:' in elemento:
      indice = datos.index(elemento)
      df2.loc[0,'Valoración'] = float(elemento.strip('"Valoración:')+'.'+
                                     datos[indice+1].strip('"'))
      
    if 'Desarrollador:' in elemento:
      df2.loc[0,'Desarrollador'] = elemento.strip('Desarrollador:')
      
    if 'Género:' in elemento:
      df2.loc[0,'Género'] = elemento.strip('"Género:').split(' (')[0]
      
    if 'Jugadores:' in elemento:
      df2.loc[0,'Jugadores'] = elemento.strip('Jugadores:').split(" ")[0]
      
    if 'Lanzamiento:' in elemento:
      df2.loc[0,'Lanzamiento'] = elemento.strip('Lanzamiento:').split(' (')[0]
      
    if 'Precio:' in elemento:
      indice = datos.index(elemento)
      df2.loc[0,'Precio'] = float(elemento.strip('"Precio:')+'.'+
                                     datos[indice+1].split('€')[0])

  df = pd.concat([df, df2], ignore_index = False, axis = 0)

df.reset_index(drop=True, inplace=True)

df.to_csv(r'my_data.csv', index=False)