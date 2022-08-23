class Juego
  attr_accessor :nombre, :imagen, :descuento, :precio, :href ,:fechaLanzamiento, :plataformas

  def initialize(nombre,imagen,descuento,precio,href,fechaLanzamiento,plataformas)
    @nombre = nombre
    @imagen = imagen
    @descuento = descuento
    @precio = precio
    @href = href
    @fechaLanzamiento = fechaLanzamiento
    @plataformas = plataformas
  end

  def toString()
    puts "Nombre="+nombre+"\nImagen="+imagen+"\nDescuento="+descuento+"\nPrecio="+precio+"\nHref="+href+"\nFechaLanzamiento="+fechaLanzamiento+"\nPlataformas="+plataformas
  end

  def registrar()
    CSV.open("./Capturas/juegos.csv","a") do |csv|
      csv << [nombre,imagen,descuento,precio,href,fechaLanzamiento,plataformas]
    end
  end
  
end