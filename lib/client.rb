class Client

  attr_reader(:id, :name, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @stylist_id = attributes[:stylist_id] || 0
    @id = attributes[:id]
  end

  define_method(:==) do |other|
    match_id = self.id().==(other.id())
    match_name = self.name().==(other.name())
    match_stylist_id = self.stylist_id().==(other.stylist_id())
    match_id.&(match_name.&(match_stylist_id))
  end

  define_singleton_method(:all) do
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients ORDER BY name;")
    returned_clients.each() do |client|
      name = client.fetch("name")
      id = client.fetch("id").to_i()
      stylist_id = client.fetch("stylist_id").to_i
      clients.push(Client.new({ :name => name, :stylist_id => stylist_id, :id => id }))
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes[:name] || @name
    @stylist_id = attributes[:stylist_id] || @stylist_id
    DB.exec("UPDATE clients SET name = '#{@name}', stylist_id = #{@stylist_id} WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{@id};")
  end

  define_method(:assign_stylist) do |stylist|
    @stylist_id = stylist.id()
    DB.exec("UPDATE clients SET stylist_id = #{stylist.id()} WHERE id  = #{self.id()};")
  end

  define_method(:stylist) do
    returned = DB.exec("SELECT * FROM stylists WHERE id = #{@stylist_id};")
      stylist_name = returned.first().fetch("name")
      id = returned.first().fetch("id").to_i()
      Stylist.new({ :name => stylist_name, :id => id })
  end

end
