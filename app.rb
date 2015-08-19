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

post('/books/new') do
  title = params.fetch("title")
  subject = params.fetch("subject")
  book = Book.new({:title => title, :subject => subject})
  book.save()
  @books = Book.all()
  erb(:books)
end
