require 'open-uri'
require 'nokogiri'
require 'csv'


CSV.open('juegos.csv', 'wb') do |csv|
  csv << %w[Nombre link]
  contador=0; pagina=0
  while (pagina<100)
    puts "Scrapeando la url https://www.3djuegos.com/novedades/juegos-generos/juegos-pc/#{pagina}f1f0f0/juegos-populares/..."
  
    link = "https://www.3djuegos.com/novedades/juegos-generos/juegos-pc/#{pagina}f1f0f0/juegos-populares/"
    metaCriticHTML = open(link)
    datos = metaCriticHTML.read
    parsed_content = Nokogiri::HTML(datos)
    inf_container = parsed_content.css('.hr_15').css(".cb").css(".mar_t6").css("ul")
    #puts inf_container
    #itera los elementos dentro del contenedor
    inf_container.css("li").each do |juegos|
      puts juegos.css(".s18i").css(".col_plat_i").inner_text
      puts juegos.css(".s18i").css(".col_plat_i").attr('href')
      nombre = juegos.css(".s18i").css(".col_plat_i").inner_text
      link = juegos.css(".s18i").css(".col_plat_i").attr('href')
      info = nombre  +","+ link
      csv<< info.split(",")
      contador+=1
    end
    pagina+=1
  end
  puts "Fin de Extracción, no comparta las confesiones... XD"
end