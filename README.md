For this project, I’m integrating two datasets to create a comprehensive anime database.

Top Anime Data

Source: Kaggle
Description: Contains popular anime titles with core details like Score, Description, English Title, Episodes, Status, Studios, and Genres. This data will populate the main animes table.

Jikan API Data

Source: Jikan API
Description: Provides mal_id (unique ID) and title_english. Matching title_english from this dataset with the English title from the Top Anime Data allows us to retrieve and store image URLs for each anime.
Database Structure
Key tables:

Animes: Stores anime details and image_url from Jikan.
Studios and Genres: List of production studios and genres.
AnimeStudios and AnimeGenres: Join tables for many-to-many relationships.
This setup links datasets via titles, using mal_id to fetch images, creating a well-rounded anime database.