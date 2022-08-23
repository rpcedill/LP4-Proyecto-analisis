require 'open-uri'
require 'nokogiri'
require 'csv'

require './ScraperEneba'
require './Etiqueta'

urlEneba = "https://www.eneba.com/latam/store/games?os[]=LINUX&os[]=MAC&os[]=WINDOWS&page=1&platforms[]=STEAM&regions[]=global&types[]=game"

scraper = ScraperEneba.new
#scraper.extraerDatosEtiquetas(urlSteam)
#scraper.extraerDatosCategoria()
scraper.extraerDatosProcesador()

