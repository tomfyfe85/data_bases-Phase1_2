require_relative '../lib/artist_repository'
 
def reset_artists_table
  seed_sql = File.read('spec/seeds_artist.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe ArtistRepository do 

  before(:each) do 
  reset_artists_table
  end 

  it 'return the list of artists, (added .first method)' do 
    repo = ArtistRepository.new 
    artists = repo.all

    expect(artists.length).to eq(2)
    expect(artists.first.id).to eq('1')  # => '1'
    expect(artists.first.name).to eq ("Pixies")
  end 
 
  it 'returns a single artist and info from id = "1"' do 
   repo = ArtistRepository.new
   artist = repo.find(1)
   expect(artist.name).to eq('Pixies')
   expect(artist.genre).to eq('Rock')
  end 

  it 'returns a single artist and info from id = "2"' do 
    repo = ArtistRepository.new
    artist = repo.find(2)
    expect(artist.name).to eq('ABBA')
    expect(artist.genre).to eq('Pop')
  end  

  it 'creates a new artist' do 
    repo = ArtistRepository.new 

      artist = Artist.new 
      artist.name = 'Beatles'
      artist.genre = 'Pop'

      repo.create(artist) # => nil

      artists = repo.all

      last_artist = artists.last
      expect(last_artist.name).to eq 'Beatles'
      expect(last_artist.genre).to eq 'Pop'
  end 
  
  it 'deletes from artist with id 1' do 
    repo = ArtistRepository.new
    id_to_delete = 1
    repo.delete(id_to_delete)
    
    all_artists = repo.all
    expect(all_artists.length).to eq(1)
    expect(all_artists[0].id).to eq("2")

  end
  
  it 'deletes both artists' do 
    repo = ArtistRepository.new
    id_to_delete1 = 1
    id_to_delete2 = 2
    repo.delete(id_to_delete1)
    repo.delete(id_to_delete2)
    
    all_artists = repo.all
    expect(all_artists.length).to eq(0)
    # expect(all_artists[0].id).to eq("2")

    
  end

  it 'updates a the artist with new info' do
    repo = ArtistRepository.new 

      artist = repo.find(1)

      artist.name = 'NeW NAmE'
      artist.genre = 'Disco'
      repo.update(artist)

      # use find to get the updated table

      find_artist = repo.find(1)
      expect(find_artist.name).to eq('NeW NAmE')
      expect(find_artist.genre).to eq('Disco')
  end 
end 