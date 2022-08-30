require 'open-uri' #consultar a la plataforma o sitio web
require 'nokogiri' #formatear, parsear a html
require 'csv' #escribir y leer csv


puts ''
puts "------------------Scraping games------------------"
puts ''

pagina = 'https://store.steampowered.com/search/?filter=topsellers'
datosHTML = URI.open(pagina)
datosStr = datosHTML.read
parsed_content = Nokogiri::HTML(datosStr)
val=0

CSV.open('games.csv', 'w') do |csv|
  csv << ['Num.', 'Name', 'Rating', 'Price', 'Languajes', 'Developers', 'Generes']
  puts 'Num. - Name - Rating - Price - Languajes - Developers - Generes'
  parsed_content.css('div#search_resultsRows > a.search_result_row').each do |fila|
    link = fila['href']
    rating = "No rating"
    name=fila.css('div.search_name > span.title').inner_text()
    price=fila.css('div.search_price').inner_text().split
    span=fila.css('div.search_reviewscore > span').at(0)
    if !(span.nil?)
      rating = span['data-tooltip-html'].split("<br>", 2).at(1).split("%", 2).at(0)
    end
    parsed_content
    parsed_page = Nokogiri::HTML(URI.open(link).read)
    languages=""
    count=0
    parsed_page.css('table.game_language_options tr').each do |val|
      if count > 0
        languages += val.css('td').at(0).inner_text().split().at(0)+";"
      end
      count+=1
    end
    languages = languages[0..-2]
    if languages.length() == 0
      languages = "No languages"
    end
    
    developers = ""
    parsed_page.css('#developers_list > a').each do |dev|
      developers += dev.inner_text()+";"
    end
    developers = developers[0..-2]
    if developers.length() == 0
      developers = "No developers"
    end
    
    generes = ""
    parsed_page.css('#genresAndManufacturer > span > a').each do |gen|
      generes += gen.inner_text()+";"
    end
    generes = generes[0..-2]
    if generes.length() == 0
      generes = "No generes"
    end
    
    val+=1
    csv << [val.to_s(), name, rating, price.at(0).split("$").at(1), languages.to_s(), developers.to_s(), generes.to_s()]
    puts val.to_s+' - '+name+' - '+rating+' - $'+price.at(0).split("$").at(1)+' - '+languages.to_s+' - '+developers.to_s+' - '+generes.to_s
    
  end
end


puts ''
puts "------------------This is the end------------------"