class Stylist

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id] || 'NULL'
  end

  define_method(:==) do |other|
    match_id = self.id().==(other.id())
    match_name = self.name().==(other.name())
    match_id.&(match_name)
  end

  define_singleton_method(:all) do
    stylists = []
    returned_stylists = DB.exec("SELECT * FROM stylists ORDER BY name;")
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({ :name => name, :id => id }))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes[:name] || @name
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE stylist_id = #{@id};")
    DB.exec("DELETE FROM stylists WHERE id = #{@id};")
  end

  define_method(:clients) do
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{@id};")
    returned_clients.each() do |client_hash|
      id = client_hash.fetch('id').to_i()
      name = client_hash.fetch('name')
      clients.push(Client.new({ :name => name, :id => id , :stylist_id => @id}))
    end
    clients
  end
end
