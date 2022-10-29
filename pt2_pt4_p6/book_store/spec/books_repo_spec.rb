require_relative '../lib/books_repo'

def reset_book_table
  seed_sql = File.read('spec/seeds_books.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end


RSpec.describe BooksRepository do 
  
  before(:each) do 
    reset_book_table
  end
 
  it 'returns list of books' do
   repo = BooksRepository.new
    books = repo.all

    expect(books.length).to eq(2) # =>  2
    expect(books[0].id).to eq('1')
    expect(books[0].title).to eq('Dune')
    expect(books[0].author_name).to eq('Frank Herbert')
  end 
end 
