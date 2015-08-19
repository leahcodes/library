require('spec_helper')

describe(Author) do

  describe('.all') do
    it('makes an empty array to store authors in') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("is equal if they have the same name") do
      author1=Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author2=Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      expect(author1).to(eq(author2))
    end
  end

  describe('#save') do
    it('saves author to authors array') do
      author = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author.save()
      expect(Author.all()).to(eq([author]))
    end
  end

  describe('#id') do
    it("sets the ID when the author is saved") do
      author = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author.save()
      expect(author.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#first_name') do
    it('returns the first name of the author') do
      author = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author.save()
      expect(author.first_name()).to(eq("Francois"))
    end
  end

  describe('#last_name') do
    it('returns the last name of the author') do
      author = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author.save()
      expect(author.last_name()).to(eq("Gilot"))
    end
  end

  describe('.find') do
    it('find an author by its id') do
      author1 = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author1.save()
      author2 = Author.new({:id => nil, :first_name => "Haruki", :last_name => "Murakami"})
      author2.save()
      expect(Author.find(author1.id())).to(eq(author1))
    end
  end

  describe('#update') do
    it('allows a user to update information in the authors table') do
      author = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author.save()
      author.update({:first_name => "Frank"})
      expect(author.first_name()).to(eq("Frank"))
    end
  end

  describe('#delete') do
    it('removes an author from the table') do
      author1 = Author.new({:id => nil, :first_name => "Francois", :last_name => "Gilot"})
      author1.save()
      author2 = Author.new({:id => nil, :first_name => "Haruki", :last_name => "Murakami"})
      author2.save()
      author2.delete()
      expect(Author.all()).to(eq([author1]))
    end
  end

end
