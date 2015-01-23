require('pg')
require('sinatra')
require('sinatra/reloader')
also_reload('/lib/**/*.rb')
require('./lib/stylist')
require('./lib/client')

DB = PG.connect({:dbname => 'hair_salon'})

get ('/') do
  @all_stylists = Stylist.all()
  @all_clients = Client.all()
  erb(:index)
end

get ('/add_stylist') do
  new_stylist = Stylist.new({ :name => params['name'] })
  new_stylist.save()
  redirect back
end

get ('/stylist/:id') do
  @stylist = Stylist.find_id(params['id'].to_i())
  erb(:stylist)
end

get ('/add_client/') do
  new_client = Client.new({:name => params['client'], :stylist_id => params['stylist_id'].to_i() })
  new_client.save()
  redirect back
end
