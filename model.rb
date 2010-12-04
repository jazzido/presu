require 'dm-core'
require 'dm-aggregates'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/presu.sqlite")

class Jurisdiccion
  include DataMapper::Resource

  property :id,       Serial
  property :nombre,   String, :length => 128

  has n, :servicios
  
end

class Caracter
  include DataMapper::Resource

  property :id,       Serial
  property :nombre,   String, :length => 128

end

# SAF
class Servicio
  include DataMapper::Resource

  property :id,       Serial, :key => true
  property :nombre,   String, :length => 128

  belongs_to :jurisdiccion
  belongs_to :caracter

  def variacion
    total_credito_inicial = Registro.sum(:credito, :conditions => ['servicio_id = ? AND fecha = ?', 
                                                                   id, 
                                                                   Registro.first(:servicio => self, :order => [:fecha.asc]).fecha])

    total_credito = Registro.sum(:credito, :conditions => ['servicio_id = ? AND fecha = ?', 
                                                           id, 
                                                           Registro.last(:servicio => self, :order => [:fecha.asc]).fecha])

    return total_credito - total_credito_inicial
  end

end


class Programa
  include DataMapper::Resource

  property :id,       Integer, :key => true
  property :nombre,   String, :length => 128

  belongs_to :servicio, :key => true
end

class Registro
  include DataMapper::Resource

  property :id,          Serial, :key => true
  property :fecha,       Date, :key => true
  property :credito,     Float
  property :compromiso,  Float
  property :devengado,   Float
  property :pagado,      Float
  property :programa_name, String, :length => 128

  belongs_to :servicio, 'Servicio', :key => true

end

