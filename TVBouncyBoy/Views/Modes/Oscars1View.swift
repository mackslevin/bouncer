//
//  Oscars1View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/19/24.
//

import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let director: String
    let movieYear: String
    let oscarsYear: String
    
    static let bestPictureWinners: [Movie] = [
        Movie(title: "Everything Everywhere All at Once", director: "Daniel Kwan, Daniel Scheinert", movieYear: "2022", oscarsYear: "2023"),
        Movie(title: "CODA", director: "Sian Heder", movieYear: "2021", oscarsYear: "2022"),
        Movie(title: "Nomadland", director: "Chloé Zhao", movieYear: "2020", oscarsYear: "2021"),
        Movie(title: "Parasite", director: "Bong Joon-ho", movieYear: "2019", oscarsYear: "2020"),
        Movie(title: "Green Book", director: "Peter Farrelly", movieYear: "2018", oscarsYear: "2019"),
        Movie(title: "The Shape of Water", director: "Guillermo del Toro", movieYear: "2017", oscarsYear: "2018"),
        Movie(title: "Moonlight", director: "Barry Jenkins", movieYear: "2016", oscarsYear: "2017"),
        Movie(title: "Spotlight", director: "Tom McCarthy", movieYear: "2015", oscarsYear: "2016"),
        Movie(title: "Birdman or (The Unexpected Virtue of Ignorance)", director: "Alejandro G. Iñárritu", movieYear: "2014", oscarsYear: "2015"),
        Movie(title: "12 Years a Slave", director: "Steve McQueen", movieYear: "2013", oscarsYear: "2014"),
        Movie(title: "Argo", director: "Ben Affleck", movieYear: "2012", oscarsYear: "2013"),
        Movie(title: "The Artist", director: "Michel Hazanavicius", movieYear: "2011", oscarsYear: "2012"),
        Movie(title: "The King's Speech", director: "Tom Hooper", movieYear: "2010", oscarsYear: "2011"),
        Movie(title: "The Hurt Locker", director: "Kathryn Bigelow", movieYear: "2009", oscarsYear: "2010"),
        Movie(title: "Slumdog Millionaire", director: "Danny Boyle", movieYear: "2008", oscarsYear: "2009"),
        Movie(title: "No Country for Old Men", director: "Joel Coen, Ethan Coen", movieYear: "2007", oscarsYear: "2008"),
        Movie(title: "The Departed", director: "Martin Scorsese", movieYear: "2006", oscarsYear: "2007"),
        Movie(title: "Crash", director: "Paul Haggis", movieYear: "2005", oscarsYear: "2006"),
        Movie(title: "Million Dollar Baby", director: "Clint Eastwood", movieYear: "2004", oscarsYear: "2005"),
        Movie(title: "The Lord of the Rings: The Return of the King", director: "Peter Jackson", movieYear: "2003", oscarsYear: "2004"),
        Movie(title: "Chicago", director: "Rob Marshall", movieYear: "2002", oscarsYear: "2003"),
        Movie(title: "A Beautiful Mind", director: "Ron Howard", movieYear: "2001", oscarsYear: "2002"),
        Movie(title: "Gladiator", director: "Ridley Scott", movieYear: "2000", oscarsYear: "2001"),
        Movie(title: "American Beauty", director: "Sam Mendes", movieYear: "1999", oscarsYear: "2000"),
        Movie(title: "Shakespeare in Love", director: "John Madden", movieYear: "1998", oscarsYear: "1999"),
        Movie(title: "Titanic", director: "James Cameron", movieYear: "1997", oscarsYear: "1998"),
        Movie(title: "The English Patient", director: "Anthony Minghella", movieYear: "1996", oscarsYear: "1997"),
        Movie(title: "Braveheart", director: "Mel Gibson", movieYear: "1995", oscarsYear: "1996"),
        Movie(title: "Forrest Gump", director: "Robert Zemeckis", movieYear: "1994", oscarsYear: "1995"),
        Movie(title: "Schindler's List", director: "Steven Spielberg", movieYear: "1993", oscarsYear: "1994"),
        Movie(title: "Unforgiven", director: "Clint Eastwood", movieYear: "1992", oscarsYear: "1993"),
        Movie(title: "The Silence of the Lambs", director: "Jonathan Demme", movieYear: "1991", oscarsYear: "1992"),
        Movie(title: "Dances with Wolves", director: "Kevin Costner", movieYear: "1990", oscarsYear: "1991"),
        Movie(title: "Driving Miss Daisy", director: "Bruce Beresford", movieYear: "1989", oscarsYear: "1990"),
        Movie(title: "Rain Man", director: "Barry Levinson", movieYear: "1988", oscarsYear: "1989"),
        Movie(title: "The Last Emperor", director: "Bernardo Bertolucci", movieYear: "1987", oscarsYear: "1988"),
        Movie(title: "Platoon", director: "Oliver Stone", movieYear: "1986", oscarsYear: "1987"),
        Movie(title: "Out of Africa", director: "Sydney Pollack", movieYear: "1985", oscarsYear: "1986"),
        Movie(title: "Amadeus", director: "Milos Forman", movieYear: "1984", oscarsYear: "1985"),
        Movie(title: "Terms of Endearment", director: "James L. Brooks", movieYear: "1983", oscarsYear: "1984"),
        Movie(title: "Gandhi", director: "Richard Attenborough", movieYear: "1982", oscarsYear: "1983"),
        Movie(title: "Chariots of Fire", director: "Hugh Hudson", movieYear: "1981", oscarsYear: "1982"),
        Movie(title: "Ordinary People", director: "Robert Redford", movieYear: "1980", oscarsYear: "1981"),
        Movie(title: "Kramer vs. Kramer", director: "Robert Benton", movieYear: "1979", oscarsYear: "1980"),
        Movie(title: "The Deer Hunter", director: "Michael Cimino", movieYear: "1978", oscarsYear: "1979"),
        Movie(title: "Annie Hall", director: "Woody Allen", movieYear: "1977", oscarsYear: "1978"),
        Movie(title: "Rocky", director: "John G. Avildsen", movieYear: "1976", oscarsYear: "1977"),
        Movie(title: "One Flew Over the Cuckoo's Nest", director: "Milos Forman", movieYear: "1975", oscarsYear: "1976"),
        Movie(title: "The Godfather Part II", director: "Francis Ford Coppola", movieYear: "1974", oscarsYear: "1975"),
        Movie(title: "The Sting", director: "George Roy Hill", movieYear: "1973", oscarsYear: "1974"),
        Movie(title: "The Godfather", director: "Francis Ford Coppola", movieYear: "1972", oscarsYear: "1973"),
        Movie(title: "The French Connection", director: "William Friedkin", movieYear: "1971", oscarsYear: "1972"),
        Movie(title: "Patton", director: "Franklin J. Schaffner", movieYear: "1970", oscarsYear: "1971"),
        Movie(title: "Midnight Cowboy", director: "John Schlesinger", movieYear: "1969", oscarsYear: "1970"),
        Movie(title: "Oliver!", director: "Carol Reed", movieYear: "1968", oscarsYear: "1969"),
        Movie(title: "In the Heat of the Night", director: "Norman Jewison", movieYear: "1967", oscarsYear: "1968"),
        Movie(title: "A Man for All Seasons", director: "Fred Zinnemann", movieYear: "1966", oscarsYear: "1967"),
        Movie(title: "The Sound of Music", director: "Robert Wise", movieYear: "1965", oscarsYear: "1966"),
        Movie(title: "My Fair Lady", director: "George Cukor", movieYear: "1964", oscarsYear: "1965"),
        Movie(title: "Tom Jones", director: "Tony Richardson", movieYear: "1963", oscarsYear: "1964"),
        Movie(title: "Lawrence of Arabia", director: "David Lean", movieYear: "1962", oscarsYear: "1963"),
        Movie(title: "West Side Story", director: "Robert Wise, Jerome Robbins", movieYear: "1961", oscarsYear: "1962"),
        Movie(title: "The Apartment", director: "Billy Wilder", movieYear: "1960", oscarsYear: "1961"),
        Movie(title: "Ben-Hur", director: "William Wyler", movieYear: "1959", oscarsYear: "1960"),
        Movie(title: "Gigi", director: "Vincente Minnelli", movieYear: "1958", oscarsYear: "1959"),
        Movie(title: "The Bridge on the River Kwai", director: "David Lean", movieYear: "1957", oscarsYear: "1958"),
        Movie(title: "Around the World in 80 Days", director: "Michael Anderson", movieYear: "1956", oscarsYear: "1957"),
        Movie(title: "Marty", director: "Delbert Mann", movieYear: "1955", oscarsYear: "1956"),
        Movie(title: "On the Waterfront", director: "Elia Kazan", movieYear: "1954", oscarsYear: "1955"),
        Movie(title: "From Here to Eternity", director: "Fred Zinnemann", movieYear: "1953", oscarsYear: "1954"),
        Movie(title: "The Greatest Show on Earth", director: "Cecil B. DeMille", movieYear: "1952", oscarsYear: "1953"),
        Movie(title: "An American in Paris", director: "Vincente Minnelli", movieYear: "1951", oscarsYear: "1952"),
        Movie(title: "All About Eve", director: "Joseph L. Mankiewicz", movieYear: "1950", oscarsYear: "1951"),
        Movie(title: "All the King's Men", director: "Robert Rossen", movieYear: "1949", oscarsYear: "1950"),
        Movie(title: "Hamlet", director: "Laurence Olivier", movieYear: "1948", oscarsYear: "1949"),
        Movie(title: "Gentleman's Agreement", director: "Elia Kazan", movieYear: "1947", oscarsYear: "1948"),
        Movie(title: "The Best Years of Our Lives", director: "William Wyler", movieYear: "1946", oscarsYear: "1947"),
        Movie(title: "The Lost Weekend", director: "Billy Wilder", movieYear: "1945", oscarsYear: "1946"),
        Movie(title: "Going My Way", director: "Leo McCarey", movieYear: "1944", oscarsYear: "1945"),
        Movie(title: "Casablanca", director: "Michael Curtiz", movieYear: "1943", oscarsYear: "1944"),
        Movie(title: "Mrs. Miniver", director: "William Wyler", movieYear: "1942", oscarsYear: "1943"),
        Movie(title: "How Green Was My Valley", director: "John Ford", movieYear: "1941", oscarsYear: "1942"),
        Movie(title: "Rebecca", director: "Alfred Hitchcock", movieYear: "1940", oscarsYear: "1941"),
        Movie(title: "Gone with the Wind", director: "Victor Fleming", movieYear: "1939", oscarsYear: "1940"),
        Movie(title: "You Can't Take It with You", director: "Frank Capra", movieYear: "1938", oscarsYear: "1939"),
        Movie(title: "The Life of Emile Zola", director: "William Dieterle", movieYear: "1937", oscarsYear: "1938"),
        Movie(title: "The Great Ziegfeld", director: "Robert Z. Leonard", movieYear: "1936", oscarsYear: "1937"),
        Movie(title: "Mutiny on the Bounty", director: "Frank Lloyd", movieYear: "1935", oscarsYear: "1936"),
        Movie(title: "It Happened One Night", director: "Frank Capra", movieYear: "1934", oscarsYear: "1935"),
        Movie(title: "Cavalcade", director: "Frank Lloyd", movieYear: "1933", oscarsYear: "1934"),
        Movie(title: "Grand Hotel", director: "Edmund Goulding", movieYear: "1932", oscarsYear: "1933"),
        Movie(title: "Cimarron", director: "Wesley Ruggles", movieYear: "1931", oscarsYear: "1932"),
        Movie(title: "All Quiet on the Western Front", director: "Lewis Milestone", movieYear: "1930", oscarsYear: "1931"),
        Movie(title: "The Broadway Melody", director: "Harry Beaumont", movieYear: "1929", oscarsYear: "1930"),
        Movie(title: "Wings", director: "William A. Wellman", movieYear: "1927", oscarsYear: "1929")
    ]
}




struct Oscars1View: View {
    @State private var currentMovie: Movie? = nil
    @State private var timer: Timer?
    @State private var posterURL: URL? = nil
    
    
    let refreshInterval: TimeInterval = 30
    let gold = Color(red: 1, green: 215/255, blue: 0)
    
    var body: some View {
        VStack {
            if let movie = currentMovie {
                HStack(spacing: 12) {
                    Rectangle().foregroundStyle(.secondary)
                        .aspectRatio(2/3, contentMode: .fit)
                        .overlay {
                            AsyncImage(url: posterURL) { phase in
                                switch phase {
                                    case .success(let img):
                                        img.resizable().scaledToFill()
                                    default:
                                        Color.secondary
                                }
                            }
                        }
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .foregroundStyle(Color.black.gradient)
                            .frame(height: 25)
                            .overlay {
                                Text("Best Picture")
                                    .font(.caption)
                                    .minimumScaleFactor(0.25)
                                    .foregroundStyle(gold)
                                    .opacity(0.5)
                                    .textCase(.uppercase)
                                    .bold()
                                    .fontDesign(.serif)
                            }
                        Spacer()
                        
                        Text(movie.title)
                            .font(.displayFont(size: 28))
                            .minimumScaleFactor(0.4)
                        Text("Directed by \(movie.director)")
                            .font(.caption2)
                            .minimumScaleFactor(0.4)
                            .fontDesign(.serif)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Rectangle()
                            .foregroundStyle(Color.black.gradient)
                            .frame(height: 25)
                            .overlay {
                                Text(movie.oscarsYear)
                                    .font(.caption)
                                    .minimumScaleFactor(0.25)
                                    .foregroundStyle(gold)
                                    .opacity(0.5)
                                    .textCase(.uppercase)
                                    .bold()
                            }
                            .fontDesign(.serif)
                            
                    }
                }
                .padding()
                .background {
                    ZStack {
                        AsyncImage(url: posterURL) { phase in
                            switch phase {
                                case .success(let image):
                                    image.resizable().scaledToFill()
                                default:
                                    Color.gray
                            }
                        }
                        
                        Rectangle().foregroundStyle(.thinMaterial)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            refreshMovie()
            
            timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true, block: { _ in
                refreshMovie()
            })
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    @MainActor
    func refreshMovie() {
        var newMovie = Movie.bestPictureWinners.randomElement()
        while newMovie?.id == currentMovie?.id {
            newMovie = Movie.bestPictureWinners.randomElement()
        }
        if newMovie == nil {
            return
        } else {
            Task {
                guard
                    let newMovie,
                    let apiKey = Utility.secret(key: "tmdbKey"),
                    let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(newMovie.title)&year=\(newMovie.movieYear)")
                else {
                    print("^^ pre request")
                    withAnimation { currentMovie = newMovie }
                    return
                }
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let response = try JSONDecoder().decode(TMDBMovieSearchResponse.self, from: data)
                    if let posterPath = response.results.first?.posterPath {
                        withAnimation {
                            posterURL = URL(string: "https://image.tmdb.org/t/p/w300/\(posterPath)")
                            
                            currentMovie = newMovie
                            return
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    withAnimation { currentMovie = newMovie }
                    return
                }
            }
            
            withAnimation { currentMovie = newMovie }
        }
    }
    
}

//#Preview {
//    
//    ZStack {
//        Color.purple
//        Oscars1View()
//            .frame(width: 390, height: 220)
//            .clipped()
//    }
//    
//}

// Sloppily pasted in from another project 🥴...
struct TMDBMovieSearchResponse: Codable {
    let page: Int
    let results: [TMDBMovie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct TMDBMovie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// Root struct
struct TMDBMovieDetails: Codable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: TMDBCollection?
    let budget: Int
    let genres: [TMDBGenre]
    let homepage: String
    let id: Int
    let imdbID: String
    let originCountry: [String]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [TMDBProductionCompany]
    let productionCountries: [TMDBProductionCountry]
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [TMDBSpokenLanguage]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// Collection struct
struct TMDBCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// Genre struct
struct TMDBGenre: Codable {
    let id: Int
    let name: String
}

// ProductionCompany struct
struct TMDBProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// ProductionCountry struct
struct TMDBProductionCountry: Codable {
    let iso31661: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

// SpokenLanguage struct
struct TMDBSpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

// Root struct
struct TMDBMovieCredits: Codable {
    let id: Int
    let cast: [TMDBCastMember]
    let crew: [TMDBCrewMember]
}

// Cast member struct
struct TMDBCastMember: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int
    let character: String
    let creditID: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

// Crew member struct
struct TMDBCrewMember: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let creditID: String
    let department: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case department
        case job
    }
}


