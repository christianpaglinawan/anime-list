require 'csv'
require 'httparty'

AnimeStudio.destroy_all
AnimeGenre.destroy_all
Studio.destroy_all
Anime.destroy_all

# Load Jikan dataset
jikan_filename = Rails.root.join("db/Jikan_id.csv") # Adjust this path
jikan_data = CSV.read(jikan_filename, headers: true, encoding: "utf-8")

# Create a hash for quick lookup of mal_id by title_english
jikan_lookup = jikan_data.each_with_object({}) do |row, hash|
  hash[row['title_english']] = row['mal_id']
end

# Store fetched image URLs in a cache
image_cache = {}

filename = Rails.root.join("db/Top_anime_data.csv")

csv_data = File.read(filename)
puts "Loading data from this file #{filename}"

animes = CSV.parse(csv_data, headers: true, encoding: "utf-8")

animes.each do |anime|

  title = anime['English']  # Extract the title from the current row

  # Skip the entry if the title is blank
  next if title.blank?

  # Look up mal_id using title_english from the Jikan dataset
  mal_id = jikan_lookup[title]
  next unless mal_id

    # Check if image URL is already in cache
    if image_cache[mal_id]
      image_url = image_cache[mal_id]
    else
      # Make API request to Jikan
      api_response = HTTParty.get("https://api.jikan.moe/v4/anime/#{mal_id}")
      #puts "Fetching image for #{title} (mal_id: #{mal_id}): #{api_response.inspect}"

      if api_response.success?
        image_url = api_response.dig("data", "images", "jpg", "large_image_url")
        image_cache[mal_id] = image_url # Cache the result
      else
        puts "Failed to fetch data for mal_id: #{mal_id}"
        image_url = nil
      end
    end

  anime_record = Anime.create!(
    score: anime['Score'].to_f,
    description: anime['Description'],
    title: title,
    episodes: anime['Episodes'].to_i,
    status: anime['Status'],
    image_url: image_url
  )

  # Create or find studios
  studio_names = anime['Studios']&.split(', ')
  studio_names&.each do |studio_name|
    next if studio_name.blank?
    studio = Studio.find_or_create_by(name: studio_name)
    AnimeStudio.create(anime: anime_record, studio: studio)
  end

  # Create or find genres
  anime_genres = anime['Genres']&.split(', ')
  anime_genres&.each do |genre_name|
    next if genre_name.blank?
    genre = Genre.find_or_create_by(name: genre_name)
    AnimeGenre.create(anime: anime_record, genre: genre)
  end

  sleep(0.3)

end

puts "There are #{Anime.count} Animes"
puts "There are #{Studio.count} Studios"
puts "There are #{Genre.count} Genres"
puts "There are #{AnimeStudio.count} AnimeStudios"
puts "There are #{AnimeGenre.count} AnimeGenres"
