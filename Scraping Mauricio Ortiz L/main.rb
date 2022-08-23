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

parsed_content.css('div#search_resultsRows > a.search_result_row').each do |fila|
  link = fila['href']
  rating = "No rating"
  name=fila.css('div.search_name > span.title').inner_text()
  price=fila.css('div.search_price').inner_text().split
  span=fila.css('div.search_reviewscore > span').at(0)
  if !(span.nil?)
    rating = span['data-tooltip-html'].split("<br>", 2).at(1).split("%", 2).at(0)+"%"
  end
  
  parsed_page = Nokogiri::HTML(URI.open(link).read)
  languages=[]
  #developer = parsed_page.css('')
  count=0
  parsed_page.css('table.game_language_options tr').each do |val|
    if count > 0
      languages.push(val.css('td').at(0).inner_text().split().at(0))
    end
    count+=1
  end
  
  
  puts name+' - '+rating+' - $'+price.at(0).split("$").at(1)+' - '+languages.to_s
end


puts ''
puts "------------------This is the end------------------"