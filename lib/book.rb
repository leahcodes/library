class Book

  attr_reader(:id, :title, :subject)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
    @subject = attributes.fetch(:subject)
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.subject().==(another_book.subject())).&(self.id().==(another_book.id()))
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      subject = book.fetch("subject")
      id = book.fetch("id").to_i()
      books.push(Book.new({:id => id, :title => title, :subject => subject}))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, subject) VALUES ('#{@title}', '#{@subject}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @subject = attributes.fetch(:subject, @subject)
    # @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id()};")
    DB.exec("UPDATE books SET subject = '#{@subject}' WHERE id = #{self.id()};")
    attributes.fetch(:author_ids, []).each() do |author_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
    end
  end

  define_method(:authors) do
    book_authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id()};")
    results.each() do |result|
      author_id = result.fetch("author_id").to_i()
      author_results = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      first_name = author_results.first().fetch("first_name")
      last_name = author_results.first().fetch("last_name")
      book_authors.push(Author.new({:first_name => first_name, :last_name => last_name, :id => author_id}))
    end
    book_authors
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors_books WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end
end
