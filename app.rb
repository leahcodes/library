require("sinatra")
require("sinatra/reloader")
require("./lib/author")
require("./lib/book")
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "library_test"})

get('/') do
  erb(:index)
end

get('/librarian') do
  erb(:librarian)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

post('/books') do
  @books = Book.all()
  erb(:books)
end

post('/books/new') do
  title = params.fetch("title")
  subject = params.fetch("subject")
  book = Book.new({:id => nil, :title => title, :subject => subject})
  book.save()
  @books = Book.all()
  erb(:books)
end

get('/authors') do
  @authors = Author.all()
  erb(:authors)
end

post('/authors') do
  @authors = Author.all()
  erb(:authors)
end

post('/authors/new') do
  author_first = params.fetch("author_first")
  author_last = params.fetch("author_last")
  author = Author.new({:id => nil, :first_name => author_first, :last_name => author_last})
  author.save()
  @authors = Author.all()
  erb(:authors)
end

get('/authors/:id') do
  @author = Author.find(params.fetch("id").to_i())
  @books = Book.all()
  erb(:author_info)
end

get('/books/:id') do
  @book = Book.find(params.fetch("id").to_i())
  @authors = Author.all()
  erb(:book_info)
end

patch("/authors/:id") do
  author_id = params.fetch("id").to_i()
  @author = Author.find(author_id)
  book_ids = params.fetch("book_ids")
  @author.update({:book_ids => book_ids})
  @books = Book.all()
  redirect("/authors/#{@author.id()}")
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Book.find(book_id)
  author_ids = params.fetch("author_ids")
  @book.update({:author_ids => author_ids})
  @authors = Author.all()
  erb(:book_info)
end

patch("/books/:id/update") do
  @book = Book.find(params.fetch("id").to_i())
  title = params.fetch("title")
  subject = params.fetch("subject")
  @book.update({:title => title, :subject => subject})
  @books = Book.all()
  redirect("/books/#{@book.id()}")
end

patch("/authors/:id/update") do
  @author = Author.find(params.fetch("id").to_i())
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  @author.update({:first_name => first_name, :last_name => last_name})
  @authors = Author.all()
  redirect("/authors/#{@author.id()}")
end

delete("/authors/:id/delete") do
  @author = Author.find(params.fetch("id").to_i())
  @author.delete()
  @authors = Author.all()
  erb(:authors)
end

delete("/books/:id/delete") do
  @book = Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all()
  erb(:books)
end
