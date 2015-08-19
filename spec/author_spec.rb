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
end
