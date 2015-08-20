class Author

  attr_reader(:id, :first_name, :last_name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
  end

  define_method(:==) do |another_author|
    self.first_name().==(another_author.first_name()).&(self.last_name().==(another_author.last_name())).&(self.id().==(another_author.id()))
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      first_name = author.fetch("first_name")
      last_name = author.fetch("last_name")
      id = author.fetch("id").to_i()
      authors.push(Author.new({:id => id, :first_name => first_name, :last_name => last_name}))
    end
    authors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO authors (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Author.all().each() do |author|
      if author.id().==(id)
        found_author = author
      end
    end
    found_author
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name, @first_name)
    DB.exec("UPDATE authors SET first_name = '#{@first_name}' WHERE id = #{self.id()};")

    @last_name = attributes.fetch(:last_name, @last_name)
    DB.exec("UPDATE authors SET last_name = '#{@last_name}' WHERE id = #{self.id()};")
        
    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{self.id()}, #{book_id});")
    end
  end

  define_method(:books) do
    authors_books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      books = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = books.first().fetch("title")
      subject = books.first().fetch("subject")
      authors_books.push(Book.new({:id => book_id, :title => title, :subject => subject}))
    end
    authors_books
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors_books WHERE author_id = #{self.id()};")
    DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
  end
end
