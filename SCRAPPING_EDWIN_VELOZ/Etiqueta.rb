class Etiqueta
  attr_accessor :nombreE, :rating

  def initialize(nombreE,rating)
    @nombreE = nombreE
    @rating = rating
  end

  def toString()
    puts "NombreE="+nombreE+"\nRating="+rating
  end

  def registrar()
    CSV.open("./Capturas/etiquetas.csv","a") do |csv|
      csv << [nombreE,rating]
    end
  end

  def registrarCategoria()
    CSV.open("./Capturas/categorias.csv","a") do |csv|
      csv << [nombreE,rating]
    end
  end

  def registrarRequerimientos()
    CSV.open("./Capturas/requerimientos.csv","a") do |csv|
      csv << [nombreE,rating]
    end
  end
end