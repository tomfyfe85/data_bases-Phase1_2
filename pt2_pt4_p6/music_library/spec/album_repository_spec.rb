require_relative '../lib/album_repository'
 
def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do 

  before(:each) do 
  reset_albums_table
end 

  it 'tests' do 
  repo = AlbumRepository.new 
  albums = repo.all
    
  expect(albums.length).to eq(2)
  expect(albums[1].id).to eq('2')  # => '1'
  expect(albums[1].title).to eq ("Waterloo")
  end 

   it 'creates a new album' do 
   repo = AlbumRepository.new 

   new_album = Album.new 
   new_album.title = 'Trompe le Monde'
   new_album.release_year = 1991
   new_album.artist_id = 1

    repo.create(new_album)

    all_albums = repo.all

     expect(all_albums.title).to eq 'Trompe le Monde'
     expect(all_albums.release_year).to eq 1991

    # expect(all_albums).to include?(new_album)
   end
end 
