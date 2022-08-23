require 'open-uri'
require 'nokogiri'
require 'csv'

CSV.open('videoJuegos4.csv', 'wb') do |csv|
  columnas = [ "También para:", "Desarrollador:", "Género:", "Jugadores:", "Idiona:", "Lanzamiento:" ]
  lineas = CSV.open('juegos.csv', 'rb').readlines()
  juego = 0
  lineas.each do |linea|
    if(juego>2054) 
    link = linea[-1]
    metaCriticHTML = open(link)
    datos = metaCriticHTML.read
    parsed_content = Nokogiri::HTML(datos)
    #puts parsed_content.css('.s22').inner_text
    resultado = "Nombre:"
    resultado +=  parsed_content.css('.s22').inner_text + ";"
     resultado +="Popularidad:"+parsed_content
      .css('.pad_t2').css(".d_fl").css(".vat").css("div")[0].inner_text + ";"
    resultado += "Valoración:" +parsed_content.css('.tar')
      .css(".s20").css(".b").css('.mar_b4').inner_text + ";"
    if( parsed_content.css('.pa').css(".t6").css(".r0").css('.c0').inner_text.length!=0)
      resultado += "Precio:" + parsed_content.css('.pa')
        .css(".t6").css(".r0").css('.c0').inner_text + ";"
    end
    parsed_content.css(".vat").css(".w100_480").css('.mar_l0_480').css(".a_n").css("dl").each do  |dl|
      lista = []
      info = []
      contador = 0
      dl.css("dt").each do  |dt|
        if (columnas.include?(dt.inner_text))
          lista.push(contador)
        end
        info.push(dt.inner_text)
        contador+=1
      end
      contador2 = 0
      dl.css("dd").each do  |dd|
        if(lista.include?(contador2))
          #puts info[contador2]
          resultado += info[contador2]+dd.inner_text+";"
        end
        contador2+=1
      end
      
    end
    
    csv << resultado.split(";")
    end
    juego +=1
    print juego
    puts "-"+ linea[0]
  end
end