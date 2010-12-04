require 'rake'
require 'rake/tasklib'

require 'model'
require 'dm-migrations'


require 'fastercsv'

namespace :presu do
  desc "migrate the db"
  task :migrate do
    DataMapper.auto_migrate!
  end

  desc "upgrade the db"
  task :upgrade do
    DataMapper.auto_upgrade!
  end

  desc "import data"
  task :import do
    FasterCSV.foreach(ENV['DATA'] || 'data.csv', :headers => :first_row) do |row|
      j = Jurisdiccion.first_or_create(:id => row['JURISDICCION #'], :nombre => row['JURISDICCION'])

      c = Caracter.first_or_create(:id => row['CARACTER #'], :nombre => row['CARACTER'])

      s = Servicio.first_or_new(:id => row['SERVICIO #'],
                                :nombre => row['SERVICIO'])

      puts "Servicio: #{row['SERVICIO #']}, #{row['SERVICIO']}"

      s.jurisdiccion = j; s.caracter = c
      s.save

#       p = Programa.first_or_new(:id => row['PROGRAMA'].split(' - ')[0],
#                                 :nombre => row['PROGRAMA'].split(' - ')[1])
#       p.servicio = s
#       p.save

      r = Registro.new(:fecha => Date.strptime(row['FECHA'], '%m/%d/%Y'),
                       :credito => row['CREDITO'].to_f,
                       :compromiso => row['COMPROMISO'].to_f,
                       :devengado => row['DEVENGADO'].to_f,
                       :pagado => row['PAGADO'].to_f,
                       :programa_name => row['PROGRAMA'].split(' - ')[1])
      r.servicio = s
      r.save

    end
  end

end


