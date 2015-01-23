require('spec_helper')

describe(Stylist) do

  describe('#==') do
    it("returns as equal when stylists names and IDs match") do
      stylist1 = Stylist.new({ :name => "Wanda" })
      stylist1.save()
      stylist1_from_db = Stylist.all.first()
      expect(stylist1).to(eq(stylist1_from_db))
    end
  end

  describe('.all') do
    it("returns empty at first") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('.find_id') do
    it("returns Stylist instance corresponding to id arg") do
      test_stylist = Stylist.new({ :name => "Wanda" })
      test_stylist.save()
      expect(Stylist.find_id(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe('#save') do
    it("saves stylist into db") do
      stylist1 = Stylist.new({ :name => "Wanda" })
      stylist1.save()
      expect(Stylist.all()).to(eq([stylist1]))
    end
  end

  describe('#update') do
    it("will update the name of a stylist") do
      test_stylist = Stylist.new({ :name => "Wanda" })
      test_stylist.save()
      test_stylist.update({:name => "Robert"})
      expect(test_stylist.name()).to(eq("Robert"))
    end
  end

  describe("#delete") do
    it("lets you delete a stylist from the database") do
      test_stylist = Stylist.new({ :name => "Wanda" })
      test_stylist.save()
      test_stylist2 = Stylist.new({ :name => "Robert" })
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end
  describe("#clients") do
    it("gives an array of all clients for a stylist") do
      test_stylist = Stylist.new({ :name => "Wanda" })
      test_stylist.save()
      test_client1 = Client.new({ :name => "Gabe" })
      test_client1.save()
      test_client2 = Client.new({ :name => "Kelly" })
      test_client2.save()
      test_client1.assign_stylist(test_stylist)
      test_client2.assign_stylist(test_stylist)
      expect(test_stylist.clients()).to(eq([test_client1, test_client2]))
    end
  end
end
