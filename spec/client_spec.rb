require('spec_helper')

describe(Client) do
  describe('#==') do
    it("returns as equal when clients names and IDs match") do
      client1 = Client.new({ :name => "Gabe" })
      client1.save()
      client1_from_db = Client.all.first()
      expect(client1).to(eq(client1_from_db))
    end
  end

  describe('.all') do
    it("returns empty at first") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe('.find_id') do
    it("returns Client instance corresponding to id arg") do
      test_client = Client.new({ :name => "Gabe" })
      test_client.save()
      expect(Client.find_id(test_client.id())).to(eq(test_client))
    end
  end

  describe('#save') do
    it("saves client into db") do
      client1 = Client.new({ :name => "Gabe" })
      client1.save()
      expect(Client.all()).to(eq([client1]))
    end
  end

  describe('#update') do
    it("will update the name of a client") do
      test_client = Client.new({ :name => "Gabe" })
      test_client.save()
      test_client.update({ :name => "Seth" })
      expect(test_client.name()).to(eq("Seth"))
    end
  end

  describe("#delete") do
    it("lets you delete a client from the database") do
      test_client = Client.new({ :name => "Gabe" })
      test_client.save()
      test_client2 = Client.new({ :name => "Seth" })
      test_client2.save()
      test_client.delete()
      expect(Client.all()).to(eq([test_client2]))
    end
  end

  describe('#assign_stylist') do
    it("lets you assign a stylist to a client") do
      test_client = Client.new({ :name => "Gabe" })
      test_client.save()
      test_stylist = Stylist.new({ :name => "Wanda" })
      test_stylist.save()
      test_client.assign_stylist(test_stylist)
      expect(test_client.stylist_id()).to(eq(test_stylist.id()))
    end
  end

  describe('#stylist') do
    it("gives you the stylist for a client") do
      test_client = Client.new({ :name => "Gabe" })
      test_client.save()
      test_stylist = Stylist.new({ :name => "Wanda" })
      test_stylist.save()
      test_client.assign_stylist(test_stylist)
      expect(test_client.stylist()).to(eq(test_stylist))
    end
  end
end
