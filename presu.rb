require 'rubygems'
require 'sinatra'

require 'model'


set :views, File.dirname(__FILE__) + '/templates'
set :public, File.dirname(__FILE__) + '/static'

get '/:servicio_id' do

  @servicio = Servicio.get(params[:servicio_id])
  @registros = Registro.all(:servicio => @servicio, :order => [:fecha.asc]).to_a
  
  @total_credito_inicial = Registro.sum(:credito, :conditions => ['servicio_id = ? AND fecha = ?', @servicio.id, @registros.first.fecha])
  @total_credito = Registro.sum(:credito, :conditions => ['servicio_id = ? AND fecha = ?', @servicio.id, @registros.last.fecha])

  @programas = DataMapper.repository(:default).adapter.select('SELECT distinct(programa_name) as name FROM registros WHERE servicio_id = ?', @servicio.id)

  @semanas = DataMapper.repository(:default).adapter.select('SELECT distinct(fecha) as fecha FROM registros WHERE servicio_id = ? order by fecha', @servicio.id)

  erb :servicio
  
end

get '/' do
  @jurisdicciones = Jurisdiccion.all

  erb :servicios
end
