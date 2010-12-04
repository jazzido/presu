require 'dm-core'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/presu.sqlite")

class Jurisdiccion
  include DataMapper::Resource

  property :id,       Serial
  property :nombre,   String, :length => 128
  
end

class Caracter
  include DataMapper::Resource

  property :id,       Serial
  property :nombre,   String, :length => 128

end

# SAF
class Servicio
  include DataMapper::Resource

  property :id,       Serial
  property :nombre,   String, :length => 128

  belongs_to :jurisdiccion
  belongs_to :caracter

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

  belongs_to :servicio, 'Servicio', :key => true

end

