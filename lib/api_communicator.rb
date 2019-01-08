require 'rest-client'
require 'json'
require 'pry'


def get_character_data_from_api(character_name)

  response_string = RestClient.get("http://www.swapi.co/api/people/?search=#{character_name}")
  response_hash = JSON.parse(response_string)

  if response_hash["results"][0]
    return response_hash["results"][0]
  else
    "We do not have a character #{character_name}"
  end
end

def get_character_movies(character_data)
  #make the web request
  character_films = []

    character_data["films"].each do |film|
      film_response_string = RestClient.get(film)
      film_response_hash = JSON.parse(film_response_string)
      character_films << film_response_hash
    end

  character_films
end

def character_personal_data(character_data)

    character_data.each do |key, value|
        puts "========   #{character_data["name"]}   ========\n"
        #{}puts "Name: #{character_data["name"]}"
        puts "Height: #{character_data["height"]}cm"
        puts "Mass: #{character_data["mass"]}kg"
        puts "Hair colour: #{character_data["hair_color"]}"
        puts "Skin color: #{character_data["skin_color"]}"
        puts "Eye color: #{character_data["eye_color"]}"
        puts "Birth year: #{character_data["birth_year"]}"
        puts "Gender: #{character_data["gender"]}"
        break
    end

end


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
  puts "----------   #{film["title"]}   ----------\n"
  #puts "Title: #{film["title"]}"
  puts "Episode: #{film["episode_id"]}"
  puts "Director: #{film["director"]}"
  puts "Producer(s): #{film["producer"]}"
  puts "Release Date: #{film["release_date"]}"
  puts "This move had: #{film["characters"].length} character(s), #{film["species"].length} specie(s) & #{film["planets"].length} planet(s)!!"

  # puts "Opening Crawl: #{film["opening_crawl"][0..100]}" + "..."
  end
end

def show_character_movies(character)
  character_data = get_character_data_from_api(character)
  character_personal_data(character_data)
  films = get_character_movies(character_data)
  print_movies(films)
end

# print_movies(get_character_movies_from_api("Luke"))

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
