class ScraperEneba
  def extraerDatosEtiquetas(url)
    puts url
    CSV.open("./Capturas/etiquetas.csv",'wb') do |csv|
      csv << %w[nombreE rating]
    end
    
    pagina = open(url)
    contenido = pagina.read
    parsed = Nokogiri::HTML(contenido)
    contador = 0
    for i in parsed.css(".JZCH_t").css(".pFaGHa.WpvaUk") do
      if(contador < 5)
        contador +=1
        gameName = i.css(".uy1qit").css(".tUUnLz").css(".x4MuJo").css(".lirayz").css(".YLosEL").inner_text
        gameUrl = i.css(".uy1qit").css(".b3POZC").css("a").attribute("href").inner_text
        #puts gameUrl
        urlJuego = "https://www.eneba.com" + gameUrl
        puts urlJuego
        paginaJuego = open(urlJuego)
        contenidoJuego = paginaJuego.read
        parsedJuego = Nokogiri::HTML(contenidoJuego)
        parsedJuego.css(".jN0tyE").each do |infoJuego|
          rating = infoJuego.css(".mMO4Vf").css(".d52_Iq").inner_text
          et = Etiqueta.new(gameName,rating)
          et.toString
          et.registrar
        end     
      else
        break
      end       
    end
  end

  def extraerDatosCategoria()
    CSV.open("./Capturas/categorias.csv",'wb') do |csv|
      csv << %w[nombreE rating]
    end
    contador = 0
    numPagina = 1
    while(numPagina < 6)
      link = "https://www.eneba.com/latam/store/games?os[]=LINUX&os[]=MAC&os[]=WINDOWS&page=#{numPagina}&platforms[]=STEAM&regions[]=global&types[]=game"
      pagina = open(link)
      contenido = pagina.read
      parsed = Nokogiri::HTML(contenido)
      parsed.css(".JZCH_t").css(".pFaGHa.WpvaUk").each do |juego|
        gameName = juego.css(".uy1qit").css(".tUUnLz").css(".x4MuJo").css(".lirayz").css(".YLosEL").inner_text
        gameUrl = juego.css(".uy1qit").css(".b3POZC").css("a").attribute("href").inner_text
        urlJuego = "https://www.eneba.com" + gameUrl
        paginaJuego = open(urlJuego)
        contenidoJuego = paginaJuego.read
        parsedJuego = Nokogiri::HTML(contenidoJuego)
        parsedJuego.css(".tUU_Ty").css(".aoHRvN").css(".Akwlh_").each do |categorias|
          if(categorias.inner_text == "Acción")
            rating = parsedJuego.css(".jN0tyE").css(".mMO4Vf").css(".d52_Iq").inner_text
            et = Etiqueta.new(gameName,rating)
            et.toString
            et.registrarCategoria
          end            
        end
      end  
      numPagina+=1
    end
  end  

  def extraerDatosProcesador()
    CSV.open("./Capturas/requerimientos.csv",'wb') do |csv|
      csv << %w[nombreE,rating]
    end
    contador = 0
    numPagina = 1
    while(numPagina < 6)
      link = "https://www.eneba.com/latam/store/games?os[]=LINUX&os[]=MAC&os[]=WINDOWS&page=#{numPagina}&platforms[]=STEAM&regions[]=global&types[]=game"
      pagina = open(link)
      contenido = pagina.read
      parsed = Nokogiri::HTML(contenido)
      parsed.css(".JZCH_t").css(".pFaGHa.WpvaUk").each do |juego|
        gameName = juego.css(".uy1qit").css(".tUUnLz").css(".x4MuJo").css(".lirayz").css(".YLosEL").inner_text
        gameUrl = juego.css(".uy1qit").css(".b3POZC").css("a").attribute("href").inner_text
        urlJuego = "https://www.eneba.com" + gameUrl
        paginaJuego = open(urlJuego)
        contenidoJuego = paginaJuego.read
        parsedJuego = Nokogiri::HTML(contenidoJuego)
        procesador = parsedJuego.css(".ES0pMh").css(".r1iAKt").each do |elem|
          if(elem.nil?)
            next
          else
            requerimientos = elem.inner_text
            puts requerimientos
            if(requerimientos.include? "Intel Core i5")
              rating = parsedJuego.css(".jN0tyE").css(".mMO4Vf").css(".d52_Iq").inner_text
              et = Etiqueta.new(gameName,rating)
              et.registrarRequerimientos
            end  
          end          
        end
      end  
      numPagina+=1
    end
  end  
  
end