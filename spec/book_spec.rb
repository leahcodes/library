require('spec_helper')

describe(Book) do

  describe('.all') do
    it('makes an empty array to store books in') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("is equal if they have the same name") do
      book1=Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book2=Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      expect(book1).to(eq(book2))
    end
  end

  describe('#save') do
    it('saves a book to books array') do
      book = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book.save()
      expect(Book.all()).to(eq([book]))
    end
  end

  describe('#id') do
    it("sets the ID when the book is saved") do
      book = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book.save()
      expect(book.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#title') do
    it('returns the title of the book') do
      book = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book.save()
      expect(book.title()).to(eq("Harry Potter and the Goblet of Fire"))
    end
  end

  describe('#subject') do
    it('returns the subject of the book') do
      book = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book.save()
      expect(book.subject()).to(eq("Fantasy"))
    end
  end

  describe('.find') do
    it('finds a book by its id') do
      book1 = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book1.save()
      book2 = Book.new({:id => nil, :title => "Harry Potter and the Half Blood Prince", :subject => "Fantasy"})
      book2.save()
      expect(Book.find(book1.id())).to(eq(book1))
    end
  end

  describe('#delete') do
    it('removes a book from the table') do
      book1 = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book1.save()
      book2 = Book.new({:id => nil, :title => "Harry Potter and the Half Blood Prince", :subject => "Fantasy"})
      book2.save()
      book2.delete()
      expect(Book.all()).to(eq([book1]))
    end
  end

  describe('#update') do
    it('allows a user to update information in the books table') do
      book = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book.save()
      joanne = Author.new(:id => nil, :first_name => "Joanne", :last_name => "Rowling")
      joanne.save()
      rita = Author.new(:id => nil, :first_name => "Rita", :last_name => "Skeeter")
      rita.save()
      book.update({:author_ids => [joanne.id(), rita.id()]})
      expect(book.authors()).to(eq([joanne, rita]))
    end
  end

  describe("#authors") do
    it("returns all of the authors for a particular book") do
      book = Book.new({:id => nil, :title => "Harry Potter and the Goblet of Fire", :subject => "Fantasy"})
      book.save()
      joanne = Author.new(:id => nil, :first_name => "Joanne", :last_name => "Rowling")
      joanne.save()
      rita = Author.new(:id => nil, :first_name => "Rita", :last_name => "Skeeter")
      rita.save()
      book.update({:author_ids => [joanne.id(), rita.id()]})
      expect(book.authors()).to(eq([joanne, rita]))
    end
  end

end
