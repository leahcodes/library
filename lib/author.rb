class Author

  attr_reader(:id, :first_name, :last_name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      first_name = list.fetch("first_name")
      last_name = list.fetch("last_name")
      id = author.fetch("id").to_i()
      authors.push(Author.new({:id => id, :first_name => first_name, :last_name => last_name}))
    end
    authors
  end
end
