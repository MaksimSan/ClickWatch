// MovieAPIService.swift
// Copyright © ClickWatch. All rights reserved.

import Foundation

final class MovieAPIService: MovieAPIServiceProtocol {
    
    // MARK: Enums

    private enum URLComponentsTitles: String {
        case scheme = "https"
        case host = "api.themoviedb.org"
        case path = "/3/movie/"
        case apiKey = "api_key"
        case apiKeyValue = "209be2942f86f39dd556564d2ad35c5c"
        case language
        case languageValue = "ru-RU"
    }

    // MARK: Private Proeprties

    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    // MARK: Public Methods

    func getMovieList(urlPath: String, completion: @escaping (Result<[FilmObject], Error>) -> Void) {
        guard let url = createURL(urlPath: urlPath) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            guard let usageData = data else { return }

            do {
                let movieList = try self.decoder.decode(Films.self, from: usageData)
                completion(.success(movieList.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getMovieDetails(movieID: Int?, completion: @escaping (Result<Details, Error>) -> Void) {
        guard let url = createURL(urlPath: String(movieID ?? .zero)) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            guard let usageData = data else { return }

            do {
                let details = try self.decoder.decode(Details.self, from: usageData)
                completion(.success(details))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: Private Methods

    private func createURL(urlPath: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = URLComponentsTitles.scheme.rawValue
        urlComponents.host = URLComponentsTitles.host.rawValue
        urlComponents.path = URLComponentsTitles.path.rawValue + urlPath
        urlComponents.queryItems = [
            URLQueryItem(name: URLComponentsTitles.apiKey.rawValue, value: URLComponentsTitles.apiKeyValue.rawValue),
            URLQueryItem(name: URLComponentsTitles.language.rawValue, value: URLComponentsTitles.languageValue.rawValue)
        ]
        return urlComponents.url
    }
}
